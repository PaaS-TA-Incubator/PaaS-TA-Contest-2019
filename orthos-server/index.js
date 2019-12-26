/**
 * orthos
 */

// import modules
const fs = require('fs');

const Koa = require('koa');
// const serve = require('koa-static');
const Router = require('koa-router');

const parse = require('csv-parse');
const _ = require('lodash');
const axios = require('axios');
const { waterfall } = require('async');

// db(mysql)
const db = new require('./DB');

/* env */

// const PORT = 8080;
const PORT = 4000;

// hyperparameters

/**
 * 최소 동의 수 (검색 가능 여부 및 사용할 데이터 정의)
 * - 너무 낮추면 의미있는 키워드도 필터링 될 수 있고
 * - 너무 높이면 의미없는 키워드도 포함될 수 있음
 */
const VOTE_MINIMA = 10;

/**
 * 제목 키워드에 붙을 BIAS
 * 가중치에 BIAS가 곱해지게 됨
 */
const TITLE_BIAS = 5;

/* tools */

/**
 * get TF (Term Frequency)
 * @param {String} keyword
 * @param {String} document
 * @return {Object} TF: { keyword, tfValue }
 */
function getTF(keyword, document) {
  return {
    keyword,
    tfValue: (document.match(new RegExp(_.compact(keyword.split('<TITLE>@')), 'g')) || []).length,
  };
}

/**
 * get TF with multiple keywords
 * @param {[String]} keywords
 * @param {String} document
 * @return {[Object]} TFs
 */
function getTFs(keywords, document) {
  return _.map(keywords, keyword => getTF(keyword, document));
}

/**
 * get ITF (Increase-TF)
 * @param {[String]} keywords
 * @param {String} document
 * @return {[Object]} ITFs
 */
function getITFs(keywords, document) {
  const tfs = getTFs(keywords, document);
  const maxTFValue = _.maxBy(tfs, ({ tfValue }) => tfValue).tfValue;

  if (maxTFValue === 0) {
    return undefined;
  }

  // return _.forEach(tfs, tf => tf.tfValue = 0.5 + 0.5 * tf.tfValue / maxTFValue);
  return _.forEach(tfs, tf => tf.tfValue /= maxTFValue);
}

/**
 * get IDF (Inverse Document Frequency)
 * @param {String} keywored
 * @param {[String]} documents
 * @return {Object} IDF: { keyword, idfValue }
 */
function getIDF(keyword, documents) {
  const includeKeywordDocuments = _.reduce(documents, (r, document) => r += new RegExp(_.compact(keyword.split('<TITLE>@'))).test(document), 0);

  return {
    keyword,
    idfValue: Math.log(documents.length / includeKeywordDocuments),
    includeKeywordDocuments,
  };
}

/**
 * get IDF with multiple keywords
 * @param {[String]} keywords
 * @param {[String]} documents
 * @return {[Object]} IDFs
 */
function getIDFs(keywords, documents) {
  return _.map(keywords, keyword => getIDF(keyword, documents));
}

/**
 * get TF-IDF
 * @param {Object} param
 * @param {Object} param.tf
 * @param {Object} param.idf
 * @return {Object} TF-IDF: { keyword, value }
 */
function getTFIDF ({ tf, idf }) {
  return {
    keyword: tf.keyword,
    value: tf.tfValue * idf.idfValue,
  };
}

/**
 * get TF-IDF with multiple values
 * @param {Object} param
 * @param {[Object]} param.tfs
 * @param {[Object]} param.idfs
 * @return {[Object]} TF-IDFs
 */
function getTFIDFs ({ tfs, idfs }) {
  return _.map(tfs, (tf) => getTFIDF({
    tf,
    idf: _.find(idfs, idf => idf.keyword === tf.keyword),
  }));
}

/**
 * get NTF-IDF
 * @param {Object} param
 * @param {Object} param.tf
 * @param {Object} param.idf
 * @return {Object} NTF-IDF
 */
function getNTFIDF({ tf, idf }) {
  return {
    keyword: tf.keyword,
    value: (Math.log(tf.tfValue + 1) + 1) * idf.idfValue,
    /*
    tfValue: tf.tfValue,
    idfValue: idf.idfValue,
    includeKeywordDocuments: idf.includeKeywordDocuments,
    */
  };
}

/**
 * get NTF-IDF with multiple values
 * @param {Object} param
 * @param {[Object]} param.tfs
 * @param {[Object]} param.idfs
 * @return {[Object]} NTF-IDFs
 */
function getNTFIDFs({ tfs, idfs }) {
  return _.map(tfs, (tf) => getNTFIDF({
    tf,
    idf: _.find(idfs, idf => idf.keyword === tf.keyword),
  }));
}

/**
 * keyword filtering function
 * - ignore short string (length > 3)
 * - alphabet, korean only
 * - ignore special character
 * - allow title keywords (<TITLE>@.*) <= ignored
 * @param {[String]} keywords
 * @return {[String]} filtered keywords
 */
function keywordFilter(keywords) {
  return _.filter(keywords, (keyword) => // whitelists
    // ignore short string, alphabet/korean only, ignore special characters
    /^[a-zA-Z가-힣\s]{3,}$/.test(keyword)
  );
}

function getTitleKeywords(keywords) {
  return _.filter(keywords, keyword => keyword.includes('<TITLE>@'));
}

/**
 * TF-IDF filtering function
 * - not null
 * - not infinity
 * - not zero
 * @param {[Object]} tfidfs
 * @return {[Object]} filtered TF-IDFs
 */
function tfidfFilter(tfidfs) {
  return _.filter(tfidfs, ({ value }) => // whitelists
    value !== null && // not null
    value !== Infinity && // not infinity
    value !== 0 // not zero
  );
}

/* koa initialization */

const app = new Koa();
const router = new Router();

/* koa server */

/**
 * root
 */
// router.get('/', serve(`${__dirname}/src`));

router.get('/search', async (ctx, next) => {
  const { query: queryR } = ctx.request.query;
  const query = decodeURIComponent(queryR);

  console.log('> search', query);

  if (Number.isNaN(Number.parseInt(query))) { // search by title
    const resData = [];
    let cnt = 0;

    const dbd = _.reverse(documentSearchDatas);

    for(doc of dbd) {
      if (doc.title.includes(query)) {
        resData.push(doc);
        cnt++;
      }

      if (cnt > 20) {
        break;
      }
    }

    ctx.body = JSON.stringify(resData);
  } else { // search by no
    ctx.body = JSON.stringify([_.find(documentSearchDatas, ({ no }) => no === query)]);
  }

  return next();
});

/**
 * get peition keyword data
 */
router.get('/get-data/:no', async (ctx, next) => {
  // print req info
  console.log(`\n> i got a new request! (${new Date()})`);

  // get pram
  const { no } = ctx.params;

  if (Number.isNaN(Number.parseInt(no))) {
    // print failed
    console.log(`> req param is not available: ${no}`);

    ctx.body = 'none';
    return next();
  }

  // print petition number
  console.log('> petition number:', no);

  // get petition data
  const { title, contents, category } = _.flow(
    _.values,
    _.flatten,
    _.partial(_.find, _, ({ no: docNo }) => docNo === no),
  )(documentsDatas);

  // print petition category, ttile
  console.log(`> petition category: ${category}, title: ${title}`);

  // init documents
  const categoryDocuments = documentsDatas[category];
  const docIndex = _.findIndex(categoryDocuments, ({ contents }) => contents.startsWith(title));

  console.log(docIndex);

  // 추천이 VOTE_MINIMA 개 미만은 검색 안 됨 (-1)
  if (docIndex === -1) {
    ctx.body = JSON.stringify([{
      keyword: `동의가 ${VOTE_MINIMA} 개 미만인 글은 검색이 불가능합니다. 양해 부탁드립니다.`,
      value: -1,
    }]);

    return next();
  }

  // get keyword
  // 키워드 분석 시 특정 ip에서만 사용되기에, 이를 어쩔 수 없이 이용
  const { data: { keywords, sentences } } = await axios.post('https://tbyi9q1jth.execute-api.ap-northeast-2.amazonaws.com/dev/get-keywords', {
    title,
    contents,
  })
    .catch(err => console.log(err));

  // print info
  // console.log('> get sentences, keywords');
  // console.log('> get sentences', sentences); // sentences[0] <- title, sentences[1:] <- contents
  // console.log('> get keywords', keywords); // /^<TITLE>@.*/ <- title keywords

  // keyword filtering
  const titleKeywords = getTitleKeywords(keywords);
  const filterKeywords = [...titleKeywords, ...keywordFilter(keywords)];

  // console.log('> filtering keywords', filterKeywords, titleKeywords);

  /*
  const similaryDocs = _.flow(
    _.partial(_.map, _, ({ contents, no, title, startDate }) => ({
      no,
      title,
      startDate,
      value: _.sumBy(getTFs(titleKeywords, contents), ({ tfValue }) => tfValue),
    })),
    _.partial(_.filter, _, ({ value }) => value),
    _.partial(_.sortBy, _, ({ value }) => -value),
    _.partial(_.slice, _, 0, 10),
  )(categoryDocuments);
  */

  /**
   * TF values
   * tfs = [
   *   { keyword, tfValue } <- keyword_i
   * ]
   */
  const tfs = getITFs(filterKeywords, categoryDocuments[docIndex].contents);

  /**
   * IDF values
   * idfs = [
   *   { keyword, idfValue } <- keyword_i
   * ]
   */
  const idfs = getIDFs(filterKeywords, _.map(categoryDocuments, ({ contents }) => contents));

  /**
   * TF values from all documents
   * tfsValues = [
   *   [ <- document_i (not-sorted)
   *     { keyword, tfValue } <- keyword_j
   *   ]
   * ]
   * tfsDocs = [ { no, title, startDate, tfValues } ]
   */
  /*
  const tfsDocs = _.map(categoryDocuments, ({ no, title, startDate, contents }) => ({
    no,
    title,
    startDate,
    tfValues: getITFs(titleKeywords, contents),
  }));
  */

  /**
    * TF-IDF values from all documents
    * tfidfDocs = [
    *   [ <- document_i (`tfidfDoc`)
    *     { keyword, value, tfValue, idfValue } <- keyword_j (sorted by NTF-IDF value)
    *   ]
    * ]
    * - `rank`: rank of NTF-IDF values
    */
   /*
  const tfidfDocs = _.map(tfsDocs, (tfs) =>
    _.flow(
      getNTFIDFs, // get NTF-IDF values
      // note 'title'
      _.partial(_.forEach, _, (ntfidf) => ntfidf.keyword.startsWith('<TITLE>@') ? ntfidf.value *= 5 : ntfidf.value ),
    )({ tfs, idfs }),
  );

  console.log(tfidfDocs);
  */

  /**
   * NTF-IDF values
   * ntfidf = [
   *   { keyword, value } <- keyword_i
   * ]
   */
  const ntfidfs = _.flow(
    getNTFIDFs,
    _.partial(_.forEach, _, (ntfidf) => // apply TITLE_BIAS
      titleKeywords.includes(ntfidf.keyword) ? ntfidf.value *= TITLE_BIAS : ntfidf.value),
    _.partial(_.sortBy, _, ({ value }) => -value),
  )({ tfs, idfs });

  /*
  const similaryDocs = _.flow(
    _.partial(_.map, _, ({ no, title, startDate, contents}) => ({
      no,
      title,
      startDate,
      ntfidfs: getNTFIDFs({
        tfs: getITFs(filterKeywords, contents),
        idfs,
      }),
    })),
    _.partial(_.filter, ({ ntfidfs: { length } }) => length),
    _.partial(_.map, _, (ntfidfDoc) => ({
      ...ntfidfDoc,
      ntfidfSum: _.sumBy(ntfidfDoc.ntfidfs, ({ value }) => value),
    })),
  )(categoryDocuments);
  */

  let similaryDocs = _.map(categoryDocuments, ({ no, title, startDate, contents }) => ({
    no, title, startDate,
    ntfidfs: getNTFIDFs({
      tfs: getITFs(filterKeywords, contents),
      idfs,
    }),
  }));

  similaryDocs = _.filter(similaryDocs, ({ ntfidfs: { length } }) => length);
  similaryDocs = _.map(similaryDocs, ({ no, title, startDate, ntfidfs }) => ({
    no, title, startDate,
    ntfidfSum: _.sumBy(ntfidfs, ({ value }) => value),
  }))
  similaryDocs = _.flow(
    _.partial(_.sortBy, _, ({ ntfidfSum }) => -ntfidfSum),
    // _.partial(_.slice, _, 1, 100),
  )(similaryDocs);

  /**
   * get TF values from sentences
   * => .slice(1)을 하는 이유: 첫 번째 sentence는 제목임
   */
  const tfsSentences = _.flow(
    _.partial(_.map, _, (sentence, ind) => ({ // get TF values from each sentences
      sentence,
      index: ind,
      tfValue: _.reduce(titleKeywords, (res, keyword) => res += getTF(keyword, sentence).tfValue, 0),
    })),
    _.partial(_.filter, _, ({ tfValue }) => tfValue !== 0), // ignore useless sentence
    _.partial(_.sortBy, _, ({ tfValue }) => -tfValue), // sort by tfV
    // filtering
    _.partial(_.filter, _, (sentence, index, sentences) => sentence.tfValue >= (sentences[2] || { tfValue: 0 }).tfValue),
    _.partial(_.sortBy, _, ({ index }) => index), // sort by index
  )(sentences.slice(1));

  // print process info
  console.log('> solved!');

  const response = {
    title,
    keywords: ntfidfs,
    sentences: tfsSentences,
    similaryDocs,
  };

  // console.log('> response', response);

  // response to client
  ctx.body = JSON.stringify(response);

  return next();
});

/* process */

/**
 * process (server)
 */
const process = () => {
  app
  .use(router.routes())
  .use(router.allowedMethods());

  app.listen(PORT, () => { console.log('start koa via:', PORT); });
};

/**
 * run
 */

const documentsDatas = { // docuemnt datas
  /**
   * <category>: ['<document>'],
   */
};

const documentSearchDatas = [
  /**
   * { no, title }
   */
];

// get documents
let datas;

(async () => {
  datas = await db.query('SELECT * FROM petitions');

  datas // parsing data
  .pipe(parse())
  .on('data', ([no, startDate, endDate, ans, vote, category, title, contents]) => {
    if (vote > VOTE_MINIMA) {
      if (!documentsDatas[category]) {
        documentsDatas[category] = [];
      }

      console.log(`[server initialization... ${Math.floor(no / 517122 * 100)}%]`);

      documentsDatas[category].push({
        no,
        startDate,
        endDate,
        ans,
        vote,
        category,
        title,
        contents: `${title}\\n\\n\\n\\n${contents}`,
      });
      documentSearchDatas.push({ no, title, startDate });
    }
  });

  datas.on('end', () => { // start analysis process
    // print documents
    console.log(
      'initialized!\n\n--- categories ---\n',
      _.reduce(documentsDatas, (r, { length }, k) => _.set(r, k, length), { }),
      '\n\n--- all:',
      _.reduce(documentsDatas, (r, { length }) => r += length, 0),
      '---',
    );

    // start process
    process();
  });
})();

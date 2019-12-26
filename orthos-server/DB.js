/**
 * orthos db
 */

// import modules
const mysql = require('mysql');
const _ = require('lodash');

// env
const HOST = '';
const USERNAME = '';
const PASSWORD = '';
const DB_NAME = 'orthos';

/**
 * DB
 */
class DB {
  constructor() {
    this.conn = mysql.createConnection({
      host: HOST,
      user: USERNAME,
      password: PASSWORD,
      database: DB_NAME,
    });

    this.conn.connect();
  }

  /**
   * querying
   * @param {String} q query
   */
  query(q) {
    console.log('> new query:', q);

    return new Promise(async (resolve, reject) => {
      this.conn.query(q, (err, results, fields) => {
        if (err) {
          return reject(err);
        }

        return resolve(results);
      });
    });
  }

  /**
   * for wrap data
   */
  static wrap(data) {
    return _.map(data, v => `"${v}"`).join(',');
  }

  /**
   * destroy conn
   */
  destroy() {
    this.conn.end();
  }
}

module.exports = DB;
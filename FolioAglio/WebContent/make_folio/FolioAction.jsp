<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="file.DBUtil"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="js2pdf.css">
<link rel="stylesheet"
   href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.debug.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<title>Folio2PDF</title>
<style>
@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);
</style>
<%
   // 인증된 세션이 없는경우, 해당페이지를 볼 수 없게 함.
   if (session.getAttribute("signedUser") == null) {
      response.sendRedirect("../logout.jsp");
   }
%>
<script>
function fnSaveAsSave(){
   if(!document.querySelector('#title').value){
      alert("이름을 지정해 주세요.")
      $("#title").focus();
      return false;
   }
   html2canvas(document.body).then(function(canvas){
        var imgData = canvas.toDataURL('image/png');

       $.ajax({

            type: "POST",

            url: "makeImgFile.jsp",

            contentType: "application/x-www-form-urlencoded; charset=utf-8",

            data: { "imgUrl": imgData, 
                  "name":"/"+document.querySelector('#title').value}

          }).success(function() {

            alert('pdf파일을 서버에 저장하였습니다.'); 
            opener.location.href="/main/main.jsp"
            self.close();
          });
       
       $.ajax({

          type: "POST",

          url: "upload.jsp",

          data: {"name":"/"+document.querySelector('#title').value.replace(/%/g, '%25'),
             "title":document.querySelector('#title').value.replace(/%/g, '%25')}

        }).success(function() {
           
        });
  });
}
function fnSaveAsPdf() {
    html2canvas(document.body).then(function(canvas){
       if(!document.querySelector('#title').value){
          alert("이름을 지정해 주세요.")
          $("#title").focus();
          return false;
       }
            var imgData = canvas.toDataURL('image/png');
            var imgWidth = 300;
            var pageHeight = imgWidth/1.414; // 한페이지의 길이

            var imgHeight = canvas.height * imgWidth/ canvas.width; //비율로 계산한 전체 높이
            var heightLeft = imgHeight;      //남은 높이

            var doc = new jsPDF('l', 'mm');
            var position = 0;
         
            // 첫 페이지 출력
            doc.addImage(imgData, 'PNG', 0, position,imgWidth, imgHeight);
            heightLeft -= pageHeight;
            
            while (heightLeft >= 0) {
               //position = heightLeft - pageHeight;
               position -= 210; 
               console.log(position);
               doc.addPage();
               doc.addImage(imgData, 'PNG', 0, position,imgWidth, imgHeight);
               heightLeft -= pageHeight;
            }
            doc.save(document.querySelector('#title').value+'.pdf');
      });
}
</script>   
</head>
<body>
      <%!public boolean hidden(String str) {
      if (str == null) {
         return false;
      } else if (str.equals("")) {
         return false;
      } else
         return true;
   }%>
      <%
         Object session_object = session.getAttribute("signedUser");
         String session_name = (String) session_object;
         Connection conn = DBUtil.getConn();
         int i = 0, PIlen = 0, edulen = 0, awdlen = 0, carrlen = 0, abrdlen = 0, EAlen = 0, sklen = 0;
         String[] PIArr = request.getParameterValues("PI");
         if (PIArr != null)
            PIlen = PIArr.length;
         String[] eduNumArr = request.getParameterValues("edu");
         if (eduNumArr != null)
            edulen = eduNumArr.length;
         String[] carrNumArr = request.getParameterValues("carr");
         if (carrNumArr != null)
            carrlen = carrNumArr.length;
         String[] awdNumArr = request.getParameterValues("award");
         if (awdNumArr != null)
            awdlen = awdNumArr.length;
         String[] abrdNumArr = request.getParameterValues("abrd");
         if (abrdNumArr != null)
            abrdlen = abrdNumArr.length;
         String[] EANumArr = request.getParameterValues("EA");
         if (EANumArr != null)
            EAlen = EANumArr.length;
         String[] skNumArr = request.getParameterValues("skill");
         if (skNumArr != null)
            sklen = skNumArr.length;
      %>

      <p align="center" style="font-family: 'Jeju Gothic'; font-size: 80px;">PORTFOLIO</p>

      <%
         String sql = "select * from personal_information where id=?;";
         PreparedStatement pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, session_name);
         ResultSet rs = pstmt.executeQuery();
         if (rs.next()) {
      %>
      <p align="center" class="main_title">인적사항</p>
      <div align="center">
         <table class="type07">
            <tbody>
               <tr>
                  <th scope="row">이름</th>
                  <td><%=rs.getString("name")%></td>
               </tr>
               <tr>
                  <th scope="row">영문명</th>
                  <td><%=rs.getString("en_name")%></td>
               </tr>
               <tr>
                  <th scope="row">생년월일</th>
                  <td><%=rs.getString("birth")%></td>
               </tr>
               <tr>
                  <th scope="row">이메일</th>
                  <td><%=rs.getString("email")%></td>
               </tr>
               <tr>
                  <th scope="row">전화번호</th>
                  <td><%=rs.getString("call_num")%></td>
               </tr>
               <%
                  if (PIlen > 0) {
                        while (i < PIlen) {
                           if (Integer.parseInt(PIArr[i]) == 1) {
               %>
               <tr>
                  <th scope="row">국적</th>
                  <td><%=rs.getString("country")%></td>
               </tr>
               <%
                  } else if (Integer.parseInt(PIArr[i]) == 2) {
               %>
               <tr>
                  <th scope="row">성별</th>
                  <td><%=rs.getString("sex")%></td>
               </tr>
               <%
                  } else if (Integer.parseInt(PIArr[i]) == 3) {
               %>
               <tr>
                  <th scope="row">주소</th>
                  <td><%=rs.getString("address")%></td>
               </tr>
               <%
                  } else if (Integer.parseInt(PIArr[i]) == 4) {
               %>
               <%
                  if (hidden(rs.getString("git_address"))) {
               %>
               <tr>
                  <th scope="row">git 주소</th>
                  <td><%=rs.getString("git_address")%></td>
               </tr>
               <%
                  }
               %>
               <%
                  } else if (Integer.parseInt(PIArr[i]) == 5) {
               %>
               <%
                  if (hidden(rs.getString("picture"))) {
               %>
               <tr>
                  <th scope="row">사진</th>
                  <td><img src="../personal/<%=rs.getString("picture")%>" /></td>
               </tr>
               <%
                  }
               %>
               <%
                  } else if (Integer.parseInt(PIArr[i]) == 6) {
               %>
               <%
                  if (hidden(rs.getString("personal_memo"))) {
               %>
               <tr>
                  <th scope="row">메모</th>
                  <td><%=rs.getString("personal_memo")%></td>
               </tr>
               <%
                  }
               %>
               <%
                  }
                           i++;
                        }
                     }
               %>
            </tbody>
         </table>
      </div>
      <%
         }
         i = 0;
         rs.close();
         pstmt.close();
      %>

      <p style="padding: 10px;">

         <%
            if (edulen > 0) {
               sql = "select * from education where school_num=?;";
               pstmt = conn.prepareStatement(sql);
         %>
      
      <p align="center" class="main_title">학력</p>
      <%
         while (i < edulen) {
               pstmt.setInt(1, Integer.parseInt(eduNumArr[i]));
               rs = pstmt.executeQuery();

               if (rs.next()) {
                  if (Integer.parseInt(rs.getString("school_radio")) == 1) {
      %>
      <div align="center">
         <p class="title">고등학교</p>
         <table class="type07">
            <tbody>
               <tr>
                  <th scope="row">학교명</th>
                  <td><%=rs.getString("school_name")%></td>
               </tr>
               <tr>
                  <th scope="row">학교소재지</th>
                  <td><%=rs.getString("school_location")%></td>
               </tr>
               <tr>
                  <th scope="row">계열</th>
                  <td><%=rs.getString("division")%></td>
               </tr>
               <tr>
                  <th scope="row">입학일자</th>
                  <td><%=rs.getString("e_date")%></td>
               </tr>
               <tr>
                  <th scope="row">졸업일자</th>
                  <td><%=rs.getString("g_date")%></td>
               </tr>
               <tr>
                  <th scope="row">졸업여부</th>
                  <td><%=rs.getString("g_state")%></td>
               </tr>
               <p style="padding: 10px;">
            </tbody>
         </table>
      </div>
      <%
         } else if (Integer.parseInt(rs.getString("school_radio")) == 2) {
      %>
      <div align="center">
         <p class="title">대학교</p>
         <table class="type07">
            <tbody>
               <tr>
                  <th scope="row">학교명</th>
                  <td><%=rs.getString("school_name")%></td>
               </tr>
               <tr>
                  <th scope="row">학교소재지</th>
                  <td><%=rs.getString("school_location")%></td>
               </tr>
               <tr>
                  <th scope="row">계열</th>
                  <td><%=rs.getString("division")%></td>
               </tr>
               <tr>
                  <th scope="row">입학구분</th>
                  <td><%=rs.getString("e_state")%></td>
               </tr>
               <tr>
                  <th scope="row">입학일자</th>
                  <td><%=rs.getString("e_date")%></td>
               </tr>
               <tr>
                  <th scope="row">졸업일자</th>
                  <td><%=rs.getString("g_date")%></td>
               </tr>
               <tr>
                  <th scope="row">졸업여부</th>
                  <td><%=rs.getString("g_state")%></td>
               </tr>
               <tr>
                  <th scope="row">전공</th>
                  <td><%=rs.getString("major")%></td>
               </tr>
               <tr>
                  <th scope="row">학점</th>
                  <td><%=rs.getString("grade")%></td>
               </tr>
               <tr>
                  <th scope="row">전체학점</th>
                  <td><%=rs.getString("total_grade")%></td>
               </tr>
               <tr>
                  <th scope="row">전공학점</th>
                  <td><%=rs.getString("major_grade")%></td>
               </tr>
               <tr>
                  <th scope="row">이수학점</th>
                  <td><%=rs.getString("classes")%></td>
               </tr>
               <%
                  if (hidden(rs.getString("submajor"))) {
               %>
               <tr>
                  <th scope="row">복수전공, 부전공</th>
                  <td><%=rs.getString("submajor")%></td>
               </tr>
               <%
                  }
               %>
               <%
                  if (hidden(rs.getString("edu_memo"))) {
               %>
               <tr>
                  <th scope="row">메모</th>
                  <td><%=rs.getString("edu_memo")%></td>
               </tr>
               <%
                  }
               %>
            </tbody>
         </table>
      </div>
      <p style="padding: 10px;">
         <%
            } else if (Integer.parseInt(rs.getString("school_radio")) == 3) {
         %>
      
      <div align="center">
         <p class="title">대학원</p>
         <table class="type07">
            <tbody>
               <tr>
                  <th scope="row">학교명</th>
                  <td><%=rs.getString("school_name")%></td>
               </tr>
               <tr>
                  <th scope="row">학교소재지</th>
                  <td><%=rs.getString("school_location")%></td>
               </tr>
               <tr>
                  <th scope="row">계열</th>
                  <td><%=rs.getString("division")%></td>
               </tr>
               <tr>
                  <th scope="row">입학일자</th>
                  <td><%=rs.getString("e_date")%></td>
               </tr>
               <tr>
                  <th scope="row">졸업일자</th>
                  <td><%=rs.getString("g_date")%></td>
               </tr>
               <tr>
                  <th scope="row">졸업여부</th>
                  <td><%=rs.getString("g_state")%></td>
               </tr>
               <tr>
                  <th scope="row">전공</th>
                  <td><%=rs.getString("major")%></td>
               </tr>
               <tr>
                  <th scope="row">학점</th>
                  <td><%=rs.getString("grade")%></td>
               </tr>
               <tr>
                  <th scope="row">전체학점</th>
                  <td><%=rs.getString("total_grade")%></td>
               </tr>
               <%
                  if (hidden(rs.getString("edu_memo"))) {
               %>
               <tr>
                  <th scope="row">메모</th>
                  <td><%=rs.getString("edu_memo")%></td>
               </tr>
               <%
                  }
               %>
               <p style="padding: 10px;">
            </tbody>
         </table>
      </div>
      <%
         }
               }
               i++;
            }
            rs.close();
            pstmt.close();
         }
         i = 0;

         if (carrlen > 0) {
            sql = "select * from carrier where carrier_num=?;";
            pstmt = conn.prepareStatement(sql);
      %><p align="center" class="main_title">경력</p>
      <%
         while (i < carrlen) {
               pstmt.setInt(1, Integer.parseInt(carrNumArr[i]));
               rs = pstmt.executeQuery();

               if (rs.next()) {
      %>
      <div align="center">
         <table class="type07">
            <tbody>
               <tr>
                  <th scope="row">회사명</th>
                  <td><%=rs.getString("company_name")%></td>
               </tr>
               <tr>
                  <th scope="row">직위</th>
                  <td><%=rs.getString("position")%></td>
               </tr>
               <tr>
                  <th scope="row">담당업무</th>
                  <td><%=rs.getString("work")%></td>
               </tr>
               <tr>
                  <th scope="row">연봉</th>
                  <td><%=rs.getString("salary")%></td>
               </tr>
               <tr>
                  <th scope="row">재직기간</th>
                  <td><%=rs.getString("s_period")%>~<%=rs.getString("e_period")%></td>
               </tr>
               <%
                  if (hidden(rs.getString("detail"))) {
               %>
               <tr>
                  <th scope="row">상세설명</th>
                  <td><%=rs.getString("detail")%></td>
               </tr>
               <%
                  }
               %>
               <%
                  if (hidden(rs.getString("picture"))) {
               %>
               <tr>
                  <th scope="row">사진</th>
                  <td><img src="../career/<%=rs.getString("picture")%>" /></td>
               </tr>
               <%
                  }
               %>
               <%
                  if (hidden(rs.getString("carrier_memo"))) {
               %>
               <tr>
                  <th scope="row">메모</th>
                  <td><%=rs.getString("carrier_memo")%></td>
               </tr>
               <%
                  }
               %>
            </tbody>
         </table>
      </div>
      <p style="padding: 10px;">
         <%
            }
                  i++;
               }
               rs.close();
               pstmt.close();
            }
            i = 0;

            if (abrdlen > 0) {
               sql = "select * from abroad where abroad_num=?;";
               pstmt = conn.prepareStatement(sql);
         %>
      
      <p align="center" class="main_title">해외경험</p>
      <%
         while (i < abrdlen) {
               pstmt.setInt(1, Integer.parseInt(abrdNumArr[i]));
               rs = pstmt.executeQuery();

               if (rs.next()) {
      %>
      <div align="center">
         <table class="type07">
            <tbody>
            <tbody>
               <tr>
                  <th scope="row">체류국가</th>
                  <td><%=rs.getString("country_name")%></td>
               </tr>
               <tr>
                  <th scope="row">체류형태</th>
                  <td><%=rs.getString("reason")%></td>
               </tr>
               <tr>
                  <th scope="row">구사언어</th>
                  <td><%=rs.getString("abroad_language")%></td>
               </tr>
               <tr>
                  <th scope="row">시작날짜</th>
                  <td><%=rs.getString("abroad_s_date")%></td>
               </tr>
               <tr>
                  <th scope="row">끝날짜</th>
                  <td><%=rs.getString("abroad_g_date")%></td>
               </tr>
               <%
                  if (hidden(rs.getString("abroad_detail"))) {
               %>
               <tr>
                  <th scope="row">상세설명</th>
                  <td><%=rs.getString("abroad_detail")%></td>
               </tr>
               <%
                  }
               %>
               <%
                  if (hidden(rs.getString("picture"))) {
               %>
               <tr>
                  <th scope="row">사진</th>
                  <td><img src="../abroad/<%=rs.getString("picture")%>" /></td>
               </tr>
               <%
                  }
               %>
               <%
                  if (hidden(rs.getString("abroad_memo"))) {
               %>
               <tr>
                  <th scope="row">메모</th>
                  <td><%=rs.getString("abroad_memo")%></td>
               </tr>
               <%
                  }
               %>
            </tbody>
            </tbody>
         </table>
      </div>
      <p style="padding: 10px;">
         <%
            }
                  i++;
               }
               rs.close();
               pstmt.close();
            }
            i = 0;

            if (EAlen > 0) {
               sql = "select * from external_activities where activity_num=?;";
               pstmt = conn.prepareStatement(sql);
         %>
      
      <p align="center" class="main_title">대외활동</p>
      <%
         while (i < EAlen) {
               pstmt.setInt(1, Integer.parseInt(EANumArr[i]));
               rs = pstmt.executeQuery();

               if (rs.next()) {
      %>
      <div align="center">
         <table class="type07">
            <tbody>
               <tr>
                  <th scope="row">구분</th>
                  <td><%=rs.getString("activity_radio")%></td>
               </tr>
               <tr>
                  <th scope="row">단체명</th>
                  <td><%=rs.getString("group_name")%></td>
               </tr>
               <tr>
                  <th scope="row">시작날짜</th>
                  <td><%=rs.getString("activity_s_date")%></td>
               </tr>
               <tr>
                  <th scope="row">끝날짜</th>
                  <td><%=rs.getString("activity_e_date")%></td>
               </tr>
               <%
                  if (hidden(rs.getString("activity_detail"))) {
               %>
               <tr>
                  <th scope="row">활동 상세 내용</th>
                  <td><%=rs.getString("activity_detail")%></td>
               </tr>
               <%
                  }
               %>
               <%
                  if (hidden(rs.getString("picture"))) {
               %>
               <tr>
                  <th scope="row">사진</th>
                  <td><img
                     src="../external_activity/<%=rs.getString("picture")%>" /></td>
               </tr>
               <%
                  }
               %>
               <%
                  if (hidden(rs.getString("activity_memo"))) {
               %>
               <tr>
                  <th scope="row">메모</th>
                  <td><%=rs.getString("activity_memo")%></td>
               </tr>
               <%
                  }
               %>
            </tbody>
         </table>
      </div>
      <p style="padding: 10px;">
         <%
            }
                  i++;
               }
               rs.close();
               pstmt.close();
            }
            i = 0;

            if (awdlen > 0) {
               sql = "select * from award where award_num=?;";
               pstmt = conn.prepareStatement(sql);
         %>
      
      <p align="center" class="main_title">수상 경력</p>
      <%
         while (i < awdlen) {
               pstmt.setInt(1, Integer.parseInt(awdNumArr[i]));
               rs = pstmt.executeQuery();

               if (rs.next()) {
      %>
      <div align="center">
         <table class="type07">
            <tbody>
               <tr>
                  <th scope="row">수상명</th>
                  <td><%=rs.getString("awd_name")%></td>
               </tr>
               <tr>
                  <th scope="row">주최</th>
                  <td><%=rs.getString("awd_org")%></td>
               </tr>
               <tr>
                  <th scope="row">결과</th>
                  <td><%=rs.getString("awd_result")%></td>
               </tr>
               <%
                  if (hidden(rs.getString("picture"))) {
               %>
               <tr>
                  <th scope="row">사진</th>
                  <td><img src="../award/<%=rs.getString("picture")%>" /></td>
               </tr>
               <%
                  }
               %>
               <%
                  if (hidden(rs.getString("awd_memo"))) {
               %>
               <tr>
                  <th scope="row">메모</th>
                  <td><%=rs.getString("awd_memo")%></td>
               </tr>
               <%
                  }
               %>
            </tbody>
         </table>
      </div>
      <p style="padding: 10px;">
         <%
            }
                  i++;
               }
               rs.close();
               pstmt.close();
            }
            i = 0;

            if (sklen > 0) {
               sql = "select * from skill where issue_num=?;";
               pstmt = conn.prepareStatement(sql);
         %>
      
      <p align="center" class="main_title">어학/자격증</p>
      <%
         while (i < sklen) {
               pstmt.setInt(1, Integer.parseInt(skNumArr[i]));
               rs = pstmt.executeQuery();
               String div1 = "language";
               String div2 = "classfication";
               if (rs.next()) {
                  if (div1.equals(rs.getString("skill_radio"))) {
      %>
      <div align="center">
         <p class="title">어학</p>
         <table class="type07">
            <tbody>
               <tr>
                  <th scope="row">외국어명</th>
                  <td><%=rs.getString("language_name")%></td>
               </tr>
               <tr>
                  <th scope="row">어학종류</th>
                  <td><%=rs.getString("kind")%></td>
               </tr>
               <tr>
                  <th scope="row">수험번호</th>
                  <td><%=rs.getString("application_num")%></td>
               </tr>
               <tr>
                  <th scope="row">응시일자</th>
                  <td><%=rs.getString("test_date")%></td>
               </tr>
               <%
                  if (hidden(rs.getString("score"))) {
               %>
               <tr>
                  <th scope="row">취득점수</th>
                  <td><%=rs.getString("score")%></td>
               </tr>
               <%
                  }
               %>
               <%
                  if (hidden(rs.getString("score_name"))) {
               %>
               <tr>
                  <th scope="row">취득급수</th>
                  <td><%=rs.getString("score_name")%></td>
               </tr>
               <%
                  }
               %>
               <p style="padding: 10px;">
            </tbody>
         </table>
      </div>
      <%
         } else if (div2.equals(rs.getString("skill_radio"))) {
      %>
      <div align="center">
         <p class="title">자격증</p>
         <table class="type07">
            <tbody>
               <tr>
                  <th scope="row">자격증명</th>
                  <td><%=rs.getString("classfication_name")%></td>
               </tr>
               <tr>
                  <th scope="row">발급기관</th>
                  <td><%=rs.getString("issue_org")%></td>
               </tr>
               <tr>
                  <th scope="row">취득일자</th>
                  <td><%=rs.getString("issue_date")%></td>
               </tr>
            </tbody>
         </table>
      </div>
      <p style="padding: 10px;">
         <%
            }
                  }
                  i++;
               }
               rs.close();
               pstmt.close();
            }
            i = 0;
            conn.close();
         %>
      <div align="right" style="margin-right: 20px;" >
         <img align="center" src="../image/name1.png" class="img_gray"><br>
      </div>
   <div align="center" data-html2canvas-ignore="true">
         <input type=text id=title name=title placeholder="저장할 파일명" >
        <button align="center" onclick="fnSaveAsSave()" class="button_css">Save</button>
      <button align="center" onclick="fnSaveAsPdf()" class="button_css">PDF</button>
   </div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="file.DBUtil" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width" initial-scale ="1">
<link rel="stylesheet" type="text/css" href="../maincss.css">
<style>
   @import url(http://fonts.googleapis.com/earlyaccess/hanna.css);
   @import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);
   

   .field{
      padding : 10px;
   }
   
   </style>
<meta charset="utf-8">
<title>자격증</title>
<script>
   var option = "width = 400, height = 400, top = 100, left = 200, location = no";
   
   function alart_del(){
      alert("삭제되었습니다.");
   }
   function popup_skill(){
      var url = "skill_information.jsp";
      var name = "Skill";
      window.open(url, name, option);
   }
   function language(num){
      window.open('language.jsp?issue_num='+num, '', option);
   }
   function popup_class(num){
      window.open('class.jsp?issue_num='+num, '', option);
   }
   function showhide(num){
         if(document.getElementById(num).style.display=='block'){
            document.getElementById(num).style.display='none';
         }else{
            document.getElementById(num).style.display='block';
            
         }
      }
</script>
<%  // 인증된 세션이 없는경우, 해당페이지를 볼 수 없게 함.
    if (session.getAttribute("signedUser") == null) {
        response.sendRedirect("../logout.jsp");
    }
%>
</head>
<body>
   <div align = center>
       <a href="../logout.jsp"><button class = "logout" style="float: right;">로그아웃</button></a>
      <a role="button" href="../main/main.jsp"><img src="../image/name.png"  width = "340" height="100" ></a>
      
   </div>
   <header>
      <div class="navbar container">
            <div class="navbar_item">
            <ul>
               <li><a class="menuLink" href="../personal/personal.jsp">인적</a></li>
               <li><a class="menuLink" href="../education/education.jsp">학력</a></li>
               <li><a class="menuLink" href="../career/career.jsp">경력</a></li>
               <li><a class="menuLink" href="../abroad/abroad.jsp">해외경험</a></li>
               <li><a class="menuLink" href="../external_activity/external_activity.jsp">대외활동</a></li>
               <li><a class="menuLink" href="../award/awards.jsp">수상경력</a></li>
               <li><a class="menuLink" href="../certification/certification.jsp" style="color : #636363;">어학/자격증</a></li>
               <li><a class="menuLink" href="../calendar/Calendar.jsp">캘린더</a></li>
               </ul>
            </div>
      </div>
   </header>
   
   <%
   String session_name = (String)session.getAttribute("signedUser");
      
   try{
      Connection conn = DBUtil.getConn();
         
      String sql = "select * from skill where id=?";
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, session_name);
      ResultSet rs = pstmt.executeQuery();
         
      while(rs.next()) {
         
   %>
   
   <%
         if(rs.getString("skill_radio").equals("language")){
      
   %>
   <div class="field">
      <input type="button" value="<%=rs.getString("kind") %>" onclick="showhide(<%=rs.getInt("issue_num") %>)" class="field_button">
      <table style="display:none; z-index:999;" id="<%=rs.getInt("issue_num") %>" class="type07">
         <thead>
            <tr>
               <th scope="cols">항목</th>
               <th scope="cols">내용</th>
            </tr>
         </thead>
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
            <tr>
               <th scope="row">취득점수</th>
               <td><%=rs.getString("score")%></td>
            </tr>
            <tr>
               <th scope="row">취득급수</th>
               <td><%=rs.getString("score_name")%></td>
            </tr>
            <tr>
               <td colspan="2" style="text-align: center;"> 
               <input type="button" value="수정" onclick="language(<%=rs.getInt("issue_num") %>)">
               <a href="langDel.jsp?issue_num=<%=rs.getString("issue_num") %>"><input type="button" onclick="alart_del()" value="삭제" ></a>
               <input type="button" value="닫기" onclick="showhide(<%=rs.getString("issue_num") %>);">
               </td>
            </tr>
            </tbody>
         </table>
   </div>
   <%
            }
            else{
   %>
   <div class="field">
      <input type="button" value="<%=rs.getString("classfication_name") %>" onclick="showhide(<%=rs.getInt("issue_num") %>)" class="field_button">
      <table style="display:none; z-index:999;" id = "<%=rs.getString("issue_num") %>"  class="type07">
      <thead>
      <tr>
         <th scope="cols">항목</th>
         <th scope="cols">내용</th>
      </tr>
      </thead>
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
      <tr>
         <td colspan="2" style="text-align: center;"> 
            <input type="button" value="수정" onclick="popup_class(<%=rs.getInt("issue_num") %>)">
            <a href = "classDel.jsp?issue_num=<%=rs.getString("issue_num") %>"><input type="button" value="삭제" ></a>
            <input type="button" value="닫기" onclick="showhide(<%=rs.getString("issue_num") %>);">
         </td>
         </tr>
      </tbody>
   </table> 
   </div>
   
   <%
            }
         }
         rs.close();
         conn.close();
         pstmt.close();
      } catch(SQLException e){
         System.out.println(e.toString());
      }
   %>
      
   <div>
      <a class="aa" aria-expanded="true" role="button" onClick="popup_skill()" tabindex="0">
            <svg height="32px" style="enable-background:new 0 0 32 32;" version="1.1" viewBox="0 0 32 32" width="32px" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
            <path d="M16,0C7.164,0,0,7.164,0,16s7.164,16,16,16s16-7.164,16-16S24.836,0,16,0z M24,18h-6v6h-4v-6H8v-4h6   V8h4v6h6V18z" style="fill:#636363;"/></svg>
         </a>
   </div>

</body>
</html>
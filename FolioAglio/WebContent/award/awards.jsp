<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="file.DBUtil" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../maincss.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width" initial-scale ="1">
<meta charset="utf-8">
<title>수상경력</title>
<script>
   var option = "width = 500, height = 300, top = 100, left = 200, location = no";
   function popup_award(){
      var url = "award_information.jsp";
      var name = "award";
      window.open(url, name, option);
   }
   function alart_del(){
		alert("삭제되었습니다.");
	}
   function award(num){
      window.open('awardForm.jsp?awd_num='+num, '', option);
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
               <li><a class="menuLink" href="../award/awards.jsp" style="color : #636363;">수상경력</a></li>
               <li><a class="menuLink" href="../certification/certification.jsp">어학/자격증</a></li>
               <li><a class="menuLink" href="../calendar/Calendar.jsp">캘린더</a></li>
               </ul>
            </div>
      </div>
   </header>

   
   <%
   Object session_object=session.getAttribute("signedUser");
   String session_name=(String)session_object;
   Connection conn = DBUtil.getConn();
   String s_type = "";
   
   String sql = "select * from award where id = ?";
   PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1,session_name);
    ResultSet rs = pstmt.executeQuery();
   
   while(rs.next()) {
   
   %>
   
   <div class="field">

      <input type="button" value="<%=rs.getString("awd_name") %>" class="field_button" onclick="showhide(<%=rs.getString("award_num") %>);">
      
      <table style="display:none; z-index:999;" id = "<%=rs.getString("award_num") %>"  class="type07">
      <thead>
      <tr>
         <th scope="cols">항목</th>
         <th scope="cols">내용</th>
      </tr>
      </thead>
      <tbody>
      <tr>
         <th scope="row">수상 명</th>
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
      <tr>
         <th scope="row">사진</th>
         <td><image src="<%=rs.getString("picture")%>" width=50px heigh=50px></td>
      </tr>
      <tr>
         <th scope="row">메모</th>
         <td><%=rs.getString("awd_memo")%></td>
      </tr>
      <tr>
         <td colspan="2" style="text-align: center;"> 
            <input type="button" value="수정" onclick="award(<%=rs.getString("award_num") %>);">
            <a href = "awardDel.jsp?awd_num=<%=rs.getString("award_num") %>"><input type="button" value="삭제" onclick="alart_del()"></a>
            <input type="button" value="닫기" onclick="showhide(<%=rs.getString("award_num") %>);">
         </td>
         </tr>
      </tbody>
   </table>
      
   </div>
   
   <%
   }


   rs.close();
   conn.close();
   pstmt.close();
   %>
   <div>
      <a class="aa" aria-expanded="true" role="button" onClick="popup_award()" tabindex="0">
            <svg height="32px" style="enable-background:new 0 0 32 32;" version="1.1" viewBox="0 0 32 32" width="32px" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
            <path d="M16,0C7.164,0,0,7.164,0,16s7.164,16,16,16s16-7.164,16-16S24.836,0,16,0z M24,18h-6v6h-4v-6H8v-4h6   V8h4v6h6V18z" style="fill:#636363;"/></svg>
         </a>
   </div>

</body>
</html>
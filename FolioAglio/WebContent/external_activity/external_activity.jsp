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
<title>대외활동</title>
<script>
	var option = "width = 600, height = 500, top = 100, left = 200, location = no";
	function popup_external_activities(){
		var url = "activity_information.jsp";
		var name = "External_Activities";
		window.open(url, name, option);
	}
	function get_activity(num){
		window.open("externalForm.jsp?activity_num="+num, '', option);
	}
	function showhide(num){
	      if(document.getElementById(num).style.display=='block'){
	         document.getElementById(num).style.display='none';
	      }else{
	         document.getElementById(num).style.display='block'; 
	      }
	   }
	function alart_del(){
		alert("삭제되었습니다.");
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
         		<li><a class="menuLink" href="../external_activity/external_activity.jsp" style="color : #636363;">대외활동</a></li>
         		<li><a class="menuLink" href="../award/awards.jsp">수상경력</a></li>
         		<li><a class="menuLink" href="../certification/certification.jsp">어학/자격증</a></li>
         		<li><a class="menuLink" href="../calendar/Calendar.jsp">캘린더</a></li>
         		</ul>
   			</div>
		</div>
	</header>

	
		
	<%
	Connection conn = DBUtil.getConn();
	String s_type = "";

	Object session_object=session.getAttribute("signedUser");
	String session_name=(String)session_object;

	String sql = "select * from external_activities where id=?";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,session_name);
	ResultSet rs = pstmt.executeQuery();

	
	while(rs.next()) {
	
	%>
	
	<div class="field">
		<input type="button" value="<%=rs.getString("group_name") %>" onclick="showhide(<%=rs.getInt("activity_num") %>)" class="field_button">
		<table style="display:none; z-index:999;" id = "<%=rs.getString("activity_num") %>"  class="type07">
      <thead>
      <tr>
         <th scope="cols">항목</th>
         <th scope="cols">내용</th>
      </tr>
      </thead>
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
         <th scope="row">활동기간</th>
         <td><%=rs.getString("activity_s_date")%> ~ <%=rs.getString("activity_e_date")%></td>
      </tr>
      <tr>
         <th scope="row">상세설명</th>
         <td><%=rs.getString("activity_detail")%></td>
      </tr>
      <tr>
         <th scope="row">메모</th>
         <td><%=rs.getString("activity_memo")%></td>
      </tr>
      <tr>
         <th scope="row">사진</th>
         <td><image src="<%=rs.getString("picture")%>" width=50px heigh=50px></td>
      </tr>
      <tr>
         <td colspan="2" style="text-align: center;"> 
            <input type="button" value="수정" onclick="get_activity(<%=rs.getInt("activity_num") %>)">
            <a href = "externalDel.jsp?ext_num=<%=rs.getString("activity_num") %>"><input type="button" value="삭제" onclick="alart_del()"></a>
            <input type="button" value="닫기" onclick="showhide(<%=rs.getString("activity_num") %>);">
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
		<a class="aa" aria-expanded="true" role="button" onClick="popup_external_activities()" tabindex="0">
   			<svg height="32px" style="enable-background:new 0 0 32 32;" version="1.1" viewBox="0 0 32 32" width="32px" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
   			<path d="M16,0C7.164,0,0,7.164,0,16s7.164,16,16,16s16-7.164,16-16S24.836,0,16,0z M24,18h-6v6h-4v-6H8v-4h6   V8h4v6h6V18z" style="fill:#636363;"/></svg>
   		</a>
	</div>

</body>
</html>
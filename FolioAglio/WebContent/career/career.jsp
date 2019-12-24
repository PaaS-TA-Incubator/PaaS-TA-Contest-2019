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
<style>
   @import url(http://fonts.googleapis.com/earlyaccess/hanna.css);
   @import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);
   

   
   </style>
<meta charset="utf-8">
<title>경력</title>
<script>
	var option = "width = 600, height = 500, top = 100, left = 200, location = no";
	function popup_career(){
		var url = "career_information.jsp";
		var name = "Carrier";	
		window.open(url, name, option);
	}
	function alart_del(){
		alert("삭제되었습니다.");
	}
	function get_carr(num){
		window.open("careerForm.jsp?carr_num="+num, '', option);
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
         		<li><a class="menuLink" href="../career/career.jsp" style="color : #636363;">경력</a></li>
         		<li><a class="menuLink" href="../abroad/abroad.jsp">해외경험</a></li>
         		<li><a class="menuLink" href="../external_activity/external_activity.jsp">대외활동</a></li>
         		<li><a class="menuLink" href="../award/awards.jsp">수상경력</a></li>
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
	
	String sql = "select * from carrier where id =?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1,session_name);
    ResultSet rs = pstmt.executeQuery();
	
	while(rs.next()) {
	
	%>
	
	<div class="field">
		<input type="button" value="<%=rs.getString("company_name") %>" onclick="showhide(<%=rs.getString("carrier_num") %>)" class="field_button">
		<table style="display:none; z-index:999;" id = "<%=rs.getString("carrier_num") %>"  class="type07">
      <thead>
      <tr>
         <th scope="cols">항목</th>
         <th scope="cols">내용</th>
      </tr>
      </thead>
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
         <td><%=rs.getString("s_period")%> ~ <%=rs.getString("e_period")%></td>
      </tr>
      <tr>
         <th scope="row">상세설명</th>
         <td><%=rs.getString("detail")%></td>
      </tr>
      <tr>
         <th scope="row">사진</th>
         <td><image src="<%=rs.getString("picture")%>" width=50px heigh=50px></td>
      </tr>
      <tr>
         <th scope="row">메모</th>
         <td><%=rs.getString("carrier_memo")%></td>	
      </tr>
      <tr>
         <td colspan="2" style="text-align: center;"> 
            <input type="button" value="수정" onclick="get_carr(<%=rs.getString("carrier_num") %>)">
            <a href = "careerDel.jsp?carr_num=<%=rs.getString("carrier_num") %>"><input type="button" onclick="alart_del()" value="삭제" ></a>
            <input type="button" value="닫기" onclick="showhide(<%=rs.getString("carrier_num") %>);">
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
		<a class="aa" aria-expanded="true" role="button" onClick="popup_career()" tabindex="0">
   			<svg height="32px" style="enable-background:new 0 0 32 32;" version="1.1" viewBox="0 0 32 32" width="32px" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
   			<path d="M16,0C7.164,0,0,7.164,0,16s7.164,16,16,16s16-7.164,16-16S24.836,0,16,0z M24,18h-6v6h-4v-6H8v-4h6   V8h4v6h6V18z" style="fill:#636363;"/></svg>
   		</a>
	</div>

</body>
</html>
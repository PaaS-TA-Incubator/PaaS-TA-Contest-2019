
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="file.DBUtil" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../maincss.css">
   
<style>
   @import url(http://fonts.googleapis.com/earlyaccess/hanna.css);
   @import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);

   .fil0 {
       fill: black;
       fill-rule: nonzero;
   }
   .box {
      display : block;
      border : 0.5px solid;
      width : 150px;
   }
   .aa{
   	  position : fixed;
   	  right : 20px;
   	  bottom : 20px;
   }
   .item{
   	  display : inline-block;
   	  vertical-align : top;
   	  padding : 10px;
   	  margin-bottom : 2rem;
   	  width : 95%;
   }
   .dashboard{
   	  border-radius : 0.75rem;
   	  border : 0.06rem solid #636363;
   	  margin : 10px;
   }
   .info ul li{
	  font-size : 15px;
	  margin-bottom : 5px;
	  list-style : none;
   }
   .field{
   	padding : 10px;
   }
   
   </style>
<meta charset="EUC-KR">
<title>학적</title>
<script>
	var option = "width = 500, height = 400, top = 100, left = 200, location = no";
	
	function popup_education(){
		var url = "education_information.jsp";
		var name = "Education";
		window.open(url, name, option);
	}
	function popup_highschool(num){
		var url = "highschool.jsp?school_num="+num;
		var name = "HighSchool";
		window.open(url, name, option);
	}
	function popup_collage(num){
		window.open('college.jsp?school_num='+num, '', option);
	}
	function popup_graduated(num){
		window.open('graduated.jsp?school_num='+num, '', option);
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
		<a role="button" href="../main/main.jsp"><img src="../image/name.png"  style="width:340px; height:100px;" ></a>
		
	</div>
	<header>
		<div class="navbar container">
   			<div class="navbar_item">
      		<ul>
	      		<li><a class="menuLink" href="../personal/personal.jsp">인적</a></li>
         		<li><a class="menuLink" href="../education/education.jsp" style="color : #636363;">학력</a></li>
         		<li><a class="menuLink" href="../career/career.jsp">경력</a></li>
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
	String s_type = "";
	String session_name = (String)session.getAttribute("signedUser");

	try {
		Connection conn = DBUtil.getConn();
		
		String sql = "select * from education where id=? order by school_radio ;";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,session_name);
		ResultSet rs = pstmt.executeQuery();
	
		while(rs.next()) {
			s_type = rs.getString("school_radio");
			
			if(s_type.equals("1")){
	%>
	
	<div class="field">
		<input type="button" value="<%=rs.getString("school_name") %>" onClick="showhide(<%=rs.getInt("school_num") %>)" class="field_button">
		<table style="display:none; z-index:999;" id = "<%=rs.getString("school_num") %>"  class="type07">
      <thead>
      <tr>
         <th scope="cols">항목</th>
         <th scope="cols">내용</th>
      </tr>
      </thead>
      <tbody>
      <tr>
         <th scope="row">구분</th>
         <td>고등학교</td>
      </tr>
      <tr>
         <th scope="row">학교명</th>
         <td><%=rs.getString("school_name")%></td>
      </tr>
      <tr>
         <th scope="row">학교 소재지</th>
         <td><%=rs.getString("school_location")%></td>
      </tr>
      <tr>
         <th scope="row">계열</th>
         <td><%=rs.getString("division")%></td>
      </tr>
      <tr>
         <th scope="row">일자</th>
         <td><%=rs.getString("e_date")%> ~ <%=rs.getString("g_date")%></td>
      </tr>
      <tr>
         <th scope="row">졸업여부</th>
         <td><%=rs.getString("g_state")%></td>
      </tr>
      <tr>
         <th scope="row">메모</th>
         <td><%=rs.getString("edu_memo")%></td>
      </tr>
      <tr>
         <td colspan="2" style="text-align: center;"> 
            <input type="button" value="수정" onClick="popup_highschool(<%=rs.getInt("school_num") %>)">
            <a href = "highDel.jsp?edu_num=<%=rs.getString("school_num") %>"><input type="button" value="삭제" onclick="alart_del()"></a>
            <input type="button" value="닫기" onclick="showhide(<%=rs.getString("school_num") %>);">
         </td>
         </tr>
      </tbody>
   </table>
	</div>
	
	<%		
			}
			else if (s_type.equals("2")){
	%>
	
	<div class="field">
		<input type="button" value="<%=rs.getString("school_name") %>"  onClick="showhide(<%=rs.getInt("school_num") %>)" class="field_button">
		<table style="display:none; z-index:999;height:350px;overflow-y:scroll;" id = "<%=rs.getString("school_num") %>"  class="type07">
      <thead>
      <tr>
         <th scope="cols">항목</th>
         <th scope="cols">내용</th>
      </tr>
      </thead>
      <tbody>
      <tr>
         <th scope="row">구분</th>
         <td>대학교</td>
      </tr>
      <tr>
         <th scope="row">학교명</th>
         <td><%=rs.getString("school_name")%></td>
      </tr>
      <tr>
         <th scope="row">학교 소재지</th>
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
         <th scope="row">일자</th>
         <td><%=rs.getString("e_date")%> ~ <%=rs.getString("g_date")%></td>
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
         <td><%=rs.getString("grade")%> / <%=rs.getString("total_grade")%></td>
      </tr>
      <tr>
         <th scope="row">전공학점</th>
         <td><%=rs.getString("major_grade")%> / <%=rs.getString("g_state")%></td>
      </tr>
      <tr>
         <th scope="row">이수학점</th>
         <td><%=rs.getString("classes")%></td>
      </tr>
      <tr>
         <th scope="row">부전공 / 복수전공명</th>
         <td><%=rs.getString("submajor")%></td>
      </tr>
      <tr>
         <th scope="row">메모</th>
         <td><%=rs.getString("edu_memo")%></td>
      </tr>
      <tr>
         <td colspan="2" style="text-align: center;"> 
            <input type="button" value="수정" onClick="popup_collage(<%=rs.getInt("school_num") %>)">
            <a href = "collegeDel.jsp?edu_num=<%=rs.getString("school_num") %>"><input type="button" value="삭제" onclick="alart_del()"></a>
            <input type="button" value="닫기" onclick="showhide(<%=rs.getString("school_num") %>);">
         </td>
         </tr>
      </tbody>
   </table>
</div>
	
	<%
			}
			else if (s_type.equals("3")){
	%>
	
	<div class="field">
		<input type="button" value="<%=rs.getString("school_name") %>"  onClick="showhide(<%=rs.getInt("school_num") %>)" class="field_button">
		<table style="display:none; z-index:999;height:350px;overflow-y:scroll;" id = "<%=rs.getString("school_num") %>"  class="type07">
      <thead>
      <tr>
         <th scope="cols">항목</th>
         <th scope="cols">내용</th>
      </tr>
      </thead>
      <tbody>
      <tr>
         <th scope="row">구분</th>
         <td>대학원</td>
      </tr>
      <tr>
         <th scope="row">학교 소재지</th>
         <td><%=rs.getString("school_location")%></td>
      </tr>
      <tr>
         <th scope="row">계열</th>
         <td><%=rs.getString("division")%></td>
      </tr>
      <tr>
         <th scope="row">일자</th>
         <td><%=rs.getString("e_date")%> ~ <%=rs.getString("g_date")%></td>
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
         <td><%=rs.getString("grade")%> / <%=rs.getString("total_grade")%></td>
      </tr>
      <tr>
         <th scope="row">메모</th>
         <td><%=rs.getString("edu_memo")%></td>
      </tr>
      <tr>
         <td colspan="2" style="text-align: center;"> 
            <input type="button" value="수정" onClick="popup_graduated(<%=rs.getInt("school_num") %>)">
            <a href = "graduatedDel.jsp?edu_num=<%=rs.getString("school_num") %>"><input type="button" value="삭제" onclick="alart_del()" ></a>
            <input type="button" value="닫기" onclick="showhide(<%=rs.getString("school_num") %>);">
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
		<a class="aa" aria-expanded="true" role="button" onClick="popup_education()" tabindex="0">
	   		<svg height="32px" style="enable-background:new 0 0 32 32;" version="1.1" viewBox="0 0 32 32" width="32px" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
	   		<path d="M16,0C7.164,0,0,7.164,0,16s7.164,16,16,16s16-7.164,16-16S24.836,0,16,0z M24,18h-6v6h-4v-6H8v-4h6   V8h4v6h6V18z" style="fill:#636363;"/></svg>
	   	</a>
	</div>
</body>
</html>
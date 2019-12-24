<%@ page import="java.sql.*" %>
<%@ page import="file.DBUtil" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="../maincss.css">
<meta charset="utf-8">
<title>Insert title here</title>

<script>

	window.addEventListener('load', function() {
		var confirm = document.querySelector('#confirm');
		
		confirm.addEventListener('click', function() {
	
			var radio = document.querySelectorAll('.radio');
			var language_name = document.querySelector('#language_name');
			var kind = document.querySelector('#kind');
			var application_num = document.querySelector('#application_number');
			var test_date = document.querySelector('#test_date');
			var score = document.querySelector('#score');
			var score_name = document.querySelector('#score_name');
			
			if (language_name.value == '') {
				alert('외국어명을 입력하세요.');
				language_name.focus();
			} else if (kind.value == '') {
				alert('어학 종류를 입력하세요 ')
				kind.focus();
			} else if (application_number.value == '') {
				alert('수험번호를 입력하세요 ')
				application_number.focus();
			} else if (test_date.value == '') {
				alert('응시일자를 입력하세요 ')
				test_date.focus();
			} else{
				var formData = $("#form1").serialize();
	        	 $.ajax({
	                 cache : false,
	                 url : "langUpdate.jsp", // 요기에
	                 type : 'POST', 
	                 data : formData,
	                 async: false,	
	                 success : function(data) {
						
	                 }
	             });
	            self.close();
	            opener.location.reload();
	         }
			
		});
	});
</script>
</head>
<body>
	<%
	String session_name = (String)session.getAttribute("signedUser");
	int issue_num = Integer.parseInt(request.getParameter("issue_num"));
	
	try{
		Connection conn = DBUtil.getConn();
		String sql = "select * from skill where id=? and issue_num=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, session_name);
		pstmt.setInt(2, issue_num);
		
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()){
		
	%>
	<form action="langUpdate.jsp" method="post" id="form1">
		<fieldset class="field_info">
			<legend>어학</legend>
			<table>
				<tr>
					<td>외국어명</td>
					<td><input type="text" id="language_name" name="language_name" value="<%=rs.getString("language_name") %>"></td>
				</tr>
				<tr>
					<td>어학종류</td>
					<td><input type="text" id="kind" name="kind" value="<%=rs.getString("kind") %>"></td>
				</tr>
				<tr>
					<td>수험번호</td>
					<td><input type="text" id="application_number" name="application_number" value="<%=rs.getString("application_num") %>"></td>
				</tr>
				<tr>
					<td>응시일자</td>
					<td><input type="text" id="test_date" name="test_date" placeholder="날짜넣기" value="<%=rs.getString("test_date") %>">
					<script>
						$(function(){
							$("#test_date").datepicker({dateFormat: "yy-mm-dd"});
						});
					</script></td>
				</tr>
				<tr>
					<td>취득점수</td>
					<td><input type="text" id="score" name="score" value="<%=rs.getString("score") %>"></td>
				</tr>
				<tr>
					<td>취득급수</td>
					<td><input type="text"  id="score_name" name="score_name" value="<%=rs.getString("score_name") %>"></td>
				</tr>
				<tr align = "right">
					<td colspan="2"><input type="button" id="confirm" class="button_css"
						value="수정">
					</td>
					<td><input type="hidden" name="issue_num" value="<%=rs.getInt("issue_num") %>"></td>
				</tr>
				</table>
		</fieldset>
	</form>
	<%
			}
		} catch (SQLException e){
			System.out.println(e.toString());
		}
	%>
</body>
</html>
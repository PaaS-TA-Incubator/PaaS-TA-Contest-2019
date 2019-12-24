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
		var confirm1 = document.querySelector('#confirm1');
		
		confirm1.addEventListener('click', function() {
			var classfication_name = document.querySelector('#classfication_name');
			var issue_org = document.querySelector('#issue_org');
			var issue_date = document.querySelector('#issue_date');
			
			if (classfication_name.value == '') {
				alert('자격증명을 입력하세요.');
				classfication_name.focus();
			} else if (issue_org.value == '') {
				alert('발급 기관을 입력하세요 ')
				issue_org.focus();
			} else if (issue_date.value == '') {
				alert('취득일자를 입력하세요 ')
				issue_date.focus();
			} else{
				var formData = $("#form1").serialize();
	        	 $.ajax({
	                 cache : false,
	                 enctype: 'multipart/form-data',
	                 url : "classUpdate.jsp", // 요기에
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
	int num = Integer.parseInt(request.getParameter("issue_num"));
	
	try{
		Connection conn = DBUtil.getConn();
		
		String sql = "select * from skill where id=? and issue_num=?;";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, session_name);
		pstmt.setInt(2, num);
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()){
		
	%>
	
	<form action="classUpdate.jsp" method="post" id="form1">
		<fieldset class="field_info">
			<legend>자격증</legend>
			<table>
				<tr>
					<td>자격증명</td>
					<td><input type="text" id="classfication_name" name="classfication_name" value="<%=rs.getString("classfication_name") %>"></td>
				</tr>
				<tr>
					<td>발급기관</td>
					<td><input type="text" id="issue_org" name="issue_org" value="<%=rs.getString("issue_org") %>"></td>
				</tr>
				<tr>
					<td>취득일자</td>
					<td><input type="text" id="issue_date" name="issue_date" placeholder="날짜넣기" value="<%=rs.getString("issue_date") %>">
					<script>
						$(function(){
							$("#issue_date").datepicker({dateFormat: "yy-mm-dd"});
						});
					</script></td>
				</tr>
				<tr align = "right">
					<td colspan="2"><input type="button" id="confirm1" class="button_css"
						value="수정">
					</td>
					<td><input type="hidden" name="issue_num" value="<%=rs.getInt("issue_num") %>"></td>
				</tr>
			</table>
		</fieldset>
	</form>
	<%
		}
		rs.close();
		pstmt.close();
		conn.close();
	} catch(SQLException e){
		System.out.println(e.toString());
	}
	%>
</body>
</html>
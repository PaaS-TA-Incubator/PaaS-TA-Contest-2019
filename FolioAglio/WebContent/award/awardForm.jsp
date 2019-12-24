<%@ page import="java.sql.*" %>
<%@ page import="file.DBUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../maincss.css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale ="1">
<title>수상</title>
<script>
	window.addEventListener('load', function() {
		var confirm = document.querySelector('#confirm');
		
		confirm.addEventListener('click', function() {

			var name = document.querySelector('#name');
			var org = document.querySelector('#org');
			var result = document.querySelector('#result');
			var attachment = document.querySelector('#attachment');
			var memo = document.querySelector('#memo');			
			
			// 전체 검사
			// 회사명이 입력되지 않았을시
			if (name.value == '') {
				alert('수상 명을 입력하세요.');
				name.focus();
			} else if (org.value == '') {
				alert('주최를 입력하세요 ')
				org.focus();
			} else if (result.value == '') {
				alert('결과를 입력하세요 ')
				result.focus();
			}else {
				var formData = $("#form1").serialize();
   	 		var form = $('#form2')[0];
	    	var formData2 = new FormData(form);
	
	    	 $.ajax({
	             cache : false,
	             url : "awardUpdate.jsp", // 요기에
	             type : 'POST', 
	             data : formData,
	             async: false,
	             success : function(data) {
					
	             }
	         });
	    	 $.ajax({
	             cache : false,
	             enctype: 'multipart/form-data',
	             url : "upload.jsp?com="+(name.value).replace(/%/g, '%25'), // 요기에
	             type : 'POST', 
	             data : formData2,
	             processData: false,
	             contentType: false,
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

	Object session_object=session.getAttribute("signedUser");
	String session_name=(String)session_object;
	int num = Integer.parseInt(request.getParameter("awd_num")); 
			
	try{
		Connection conn = DBUtil.getConn();
		String sql = "select * from award where id=? and award_num=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, session_name);
		pstmt.setInt(2, num);
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()){
		
	%>

	<form action="awardUpdate.jsp" method="post" id = "form1">
		<fieldset class="field_info">
			<legend>수상내용</legend>
			<table>
				<tr>
					<td>수상 명</td>
					<td><input type="text" id="name" name="name" value="<%=rs.getString("awd_name") %>"></td>
				</tr>
				<tr>
					<td>주최</td>
					<td><input type="text" id="org" name="org" value="<%=rs.getString("awd_org") %>"></td>
				</tr>
				<tr>
					<td>결과</td>
					<td><input type="text" id="result" name="result" value="<%=rs.getString("awd_result") %>"></td>
				</tr>
				<tr>
					<td>메모</td>
					<td><textarea id="memo" rows="3" name="memo" cols="50"><%=rs.getString("awd_memo") %></textarea></td>
					<td><input type="hidden" name="awd_num" value="<%= num %>"></td>
				</tr>
				<tr align="right">
					<td colspan="2"><input type="button" id="confirm" name="confirm" class="button_css"
						value="확인">
					</td>
				</tr>
			</table>
		</fieldset>
	</form>
	<form method="post" id="form2" enctype="multipart/form-data" action="upload.jsp">
			<table>
				<tr>
					<td><input type="file" value="파일 선택" accept="image/*" id="picture" name="picture" value="<%=rs.getString("picture") %>"/></td>
				</tr>
				
			</table>
		</form>
	<%
		}
	} catch(SQLException e){
		System.out.println(e.toString());
	}
	%>
</body>
</html>
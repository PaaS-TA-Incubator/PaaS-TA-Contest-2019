<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="maincss.css">
<meta charset="utf-8">
<title>패스워드 재설정</title>
<script>
	window.addEventListener('load', function() {
	    var confirm = document.querySelector('#confirm');
	    
	    confirm.addEventListenr('click', function(){
	    	var userPW = document.querySelector('#userPW');
	    	var userRPW = document.querySelector('#userRPW');
	    	
	    	if (userPW.value != userRPW.value){
		    	alert('비밀번호가 다릅니다.');
		    	userRPW.focus();
		    	}
	    	else {
	    		document.getElementById('form1').submit();
	      	}
	    });
	    
	 });
	    
</script>
</head>
<body>
	<form action="repwAction.jsp" method="post" id="form1">
		<div align="center">
			<h2 class="pw_h">비밀번호 재설정</h2>
			<table>
			<tr>
				<td class="pw_i">비밀번호</td>
				<td> : <input type="password" id="userPW" name="userPW" placeholder="비밀번호를 입력하세요."></td>
			</tr>
			<tr>
				<td class="pw_i">비밀번호 확인</td>
				<td> : <input type="password" id="userRPW" name="userRPW" placeholder="비밀번호를 다시 입력하세요."></td>
			</tr>
			</table>
			<p style="padding:2px;"></p>
			<input class="button_css" id="confirm" type="submit" value="비밀번호  변경">
			<input type="hidden" id="userID" name="userID" value="<%=request.getParameter("userID") %>">
		</div>

	</form>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="maincss.css">
<meta charset="utf-8">
<title>Forgot PassWord</title>
</head>
<body>
	<form action="pwAction.jsp" method="post">
		<div align="center">
		<h2 class="pw_h">비밀번호 찾기</h2>
			<table>
			<tr>
				<td class="pw_i">아이디</td>
				<td> : <input type="text" id="userID" name="userID" placeholder="ID를 입력하세요."></td>
			</tr>
			<tr>
				<td class="pw_i">이름</td>
				<td> : <input type="text" id="userName" name="userName" tabindex="2" placeholder="이름을 입력하세요."></td>
			</tr>
			<tr>
				<td class="pw_i">이메일</td>
				<td> : <input type="text" id="userEmail" name="userEmail" tabindex="2" placeholder="이메일을 입력하세요."></td>
			</tr>
			</table>
			<p style="padding:2px;"></p>
			<input class="button_css" type="submit" value="비밀번호찾기">
		</div>
	</form>

</body>
</html>
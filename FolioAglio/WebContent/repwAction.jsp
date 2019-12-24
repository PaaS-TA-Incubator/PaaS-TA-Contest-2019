<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ page import="java.sql.*" %>
<%@ page import="file.DBUtil" %>
<%@ page import="sha256.ShaPasswordEncoderTest" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String userID = request.getParameter("userID");
		String userPW = request.getParameter("userPW");
		String userRPW = request.getParameter("userRPW");
		
		Connection conn = DBUtil.getConn();
		ShaPasswordEncoderTest sha256 = new ShaPasswordEncoderTest();
		String salt=sha256.generateSalt();
		String hash_pwd = sha256.getName(userPW + salt);
		
		try{
			String sql = "update personal_information set pwd=? , salt=? where id=?;";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hash_pwd);
			pstmt.setString(2, salt);
			pstmt.setString(3, userID);
			pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
			%>
			
			<script>window.close();</script>
			
			<%
			
		} catch(SQLException e){
			System.out.println(e.toString());
		}
	%>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="file.DBUtil" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<%
	String session_name = (String)session.getAttribute("signedUser");
	int num = Integer.parseInt(request.getParameter("awd_num"));
	try{
		Connection conn = DBUtil.getConn();
		
		
		String sql = "delete from award where id=? and award_num=?;";		
		PreparedStatement pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, session_name);
		pstmt.setInt(2, num);
		pstmt.executeUpdate();
		
		DBUtil.close(pstmt);
		DBUtil.close(conn);
		response.sendRedirect("awards.jsp");
	} catch(SQLException e){
		System.out.println(e.toString());
	}
	%>
	
</body>
</html>
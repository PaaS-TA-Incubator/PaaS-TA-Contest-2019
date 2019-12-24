<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="file.DBUtil" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<%

	try{
		Connection conn = DBUtil.getConn();
		
		String country_name = URLDecoder.decode(request.getParameter("country"), "UTF-8");
		String reason = URLDecoder.decode(request.getParameter("reason"), "UTF-8");
		String abroad_language = URLDecoder.decode(request.getParameter("language"), "UTF-8");
		String abroad_s_date = URLDecoder.decode(request.getParameter("s_period"), "UTF-8");
		String abroad_g_date = URLDecoder.decode(request.getParameter("e_period"), "UTF-8");
		String abroad_detail = URLDecoder.decode(request.getParameter("detail"), "UTF-8");
		String abroad_memo = URLDecoder.decode(request.getParameter("memo"), "UTF-8");
		Object session_object=session.getAttribute("signedUser");
		String session_name=(String)session_object;
		
		String sql = "insert into abroad(country_name, reason, abroad_language, abroad_s_date, abroad_g_date, abroad_detail, abroad_memo, id) values (?,?,?,?,?,?,?,?);";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, country_name);
		pstmt.setString(2, reason);
		pstmt.setString(3, abroad_language);
		pstmt.setString(4, abroad_s_date);
		pstmt.setString(5, abroad_g_date);
		pstmt.setString(6, abroad_detail);
		pstmt.setString(7, abroad_memo);
		pstmt.setString(8, session_name);
		pstmt.executeUpdate();
		
		DBUtil.close(pstmt);
		DBUtil.close(conn);
	} catch(SQLException e){
		System.out.println(e.toString());
	}
	%>
	
</body>
</html>
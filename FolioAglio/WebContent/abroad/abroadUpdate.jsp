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
	String session_name = (String)session.getAttribute("signedUser");
	
	try{
		Connection conn = DBUtil.getConn();
		
		String country_name = URLDecoder.decode(request.getParameter("country"), "UTF-8");
		String reason = URLDecoder.decode(request.getParameter("reason"), "UTF-8");
		String abroad_language = URLDecoder.decode(request.getParameter("language"), "UTF-8");
		String abroad_s_date = URLDecoder.decode(request.getParameter("s_period"), "UTF-8");
		String abroad_g_date = URLDecoder.decode(request.getParameter("e_period"), "UTF-8");
		String abroad_detail = URLDecoder.decode(request.getParameter("detail"), "UTF-8");
		String abroad_memo = URLDecoder.decode(request.getParameter("memo"), "UTF-8");
		int num = Integer.parseInt(request.getParameter("num"));
		
		String sql = "update abroad set country_name=?, reason=?, abroad_language=?, abroad_s_date=?, abroad_g_date=?, abroad_detail=?,abroad_memo=? where id=? and abroad_num=?;";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, country_name);
		pstmt.setString(2, reason);
		pstmt.setString(3, abroad_language);
		pstmt.setString(4, abroad_s_date);
		pstmt.setString(5, abroad_g_date);
		pstmt.setString(6, abroad_detail);
		pstmt.setString(7, abroad_memo);
		pstmt.setString(8, session_name);
		pstmt.setInt(9, num);
		pstmt.executeUpdate();
		
		DBUtil.close(pstmt);
		DBUtil.close(conn);
	} catch(SQLException e){
		System.out.println(e.toString());
	}
	%>
	
</body>
</html>
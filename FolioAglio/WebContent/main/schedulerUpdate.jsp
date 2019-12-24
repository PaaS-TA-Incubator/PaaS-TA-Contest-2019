<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="file.DBUtil" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Scheduler</title>
</head>
<body>

	<%
	Connection conn = DBUtil.getConn();
	
	String sch_name = URLDecoder.decode(request.getParameter("name"), "UTF-8");
	String sch_date = URLDecoder.decode(request.getParameter("date"), "UTF-8");
	String sch_time = URLDecoder.decode(request.getParameter("time"), "UTF-8");
	String sch_memo = URLDecoder.decode(request.getParameter("memo"), "UTF-8");
	int sch_num = Integer.parseInt(request.getParameter("sch_num"));
	Object session_object=session.getAttribute("signedUser");
	String session_name=(String)session_object;
	
	String sql = "update scheduler set sch_name=?, sch_date=?, sch_time=?, sch_memo=? where sch_num=? and id=?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, sch_name);
	pstmt.setString(2, sch_date);
	pstmt.setString(3, sch_time);
	pstmt.setString(4, sch_memo);
	pstmt.setInt(5, sch_num);
	pstmt.setString(6, session_name);
	pstmt.executeUpdate();
	
	DBUtil.close(pstmt);
	DBUtil.close(conn);
	%>
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="file.DBUtil"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Scheduler</title>
</head>
<body>

	<%
	Connection conn = DBUtil.getConn();
	
	int sch_num = Integer.parseInt(request.getParameter("sch_num"));
	String sql = "delete from scheduler where sch_num=?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	pstmt.setInt(1, sch_num);
	pstmt.executeUpdate();
	
	DBUtil.close(pstmt);
	DBUtil.close(conn);
	%>
	
</body>
</html>
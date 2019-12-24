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
	
	int activity_num = Integer.parseInt(request.getParameter("activity_num"));
	String activity_radio = URLDecoder.decode(request.getParameter("radio"), "UTF-8");
	String group_name = URLDecoder.decode(request.getParameter("name"), "UTF-8");
	String activity_s_date = URLDecoder.decode(request.getParameter("s_period"), "UTF-8");
	String activity_e_date = URLDecoder.decode(request.getParameter("e_period"), "UTF-8");
	String activity_detail = URLDecoder.decode(request.getParameter("detail"), "UTF-8");
	String activity_memo = URLDecoder.decode(request.getParameter("memo"), "UTF-8");
	Object session_object = session.getAttribute("signedUser");
	String session_name = (String)session_object;

	
	String sql = "update external_activities set activity_radio=?, group_name=?, activity_s_date=?, activity_e_date=?, activity_detail=?, activity_memo=? where activity_num=? and id=?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, activity_radio);
	pstmt.setString(2, group_name);
	pstmt.setString(3, activity_s_date);
	pstmt.setString(4, activity_e_date);
	pstmt.setString(5, activity_detail);
	pstmt.setString(6, activity_memo);
	pstmt.setInt(7, activity_num);
	pstmt.setString(8, session_name);
	pstmt.executeUpdate();
	
	DBUtil.close(pstmt);
	DBUtil.close(conn);
	%>
	
</body>
</html>
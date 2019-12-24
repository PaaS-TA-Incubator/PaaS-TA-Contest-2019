<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="file.DBUtil" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Awards Insert</title>
</head>
<body>

	<%
	Connection conn = DBUtil.getConn();
	
	
	if (session.getAttribute("signedUser") == null) {
        response.sendRedirect("../logout.jsp");
    }
	
	String awd_name = URLDecoder.decode(request.getParameter("name"), "UTF-8");
	String awd_org = URLDecoder.decode(request.getParameter("org"), "UTF-8");
	String awd_result = URLDecoder.decode(request.getParameter("result"), "UTF-8");
	String awd_memo = URLDecoder.decode(request.getParameter("memo"), "UTF-8");
	Object session_object=session.getAttribute("signedUser");
	String session_name=(String)session_object;
	
	String sql = "insert into award(awd_name, awd_org, awd_result, awd_memo, id) values (?,?,?,?,?);";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, awd_name);
	pstmt.setString(2, awd_org);
	pstmt.setString(3, awd_result);
	pstmt.setString(4, awd_memo);
	pstmt.setString(5, session_name);
	pstmt.executeUpdate();
	
	DBUtil.close(pstmt);
	DBUtil.close(conn);
	%>
	
</body>
</html>
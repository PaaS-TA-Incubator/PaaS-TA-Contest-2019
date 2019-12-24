<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="file.DBUtil" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Awards Update</title>
</head>
<body>

	<%
	
	if (session.getAttribute("signedUser") == null) {
        response.sendRedirect("../logout.jsp");
    }
	
	try{
		Connection conn = DBUtil.getConn();
		String awd_name = URLDecoder.decode(request.getParameter("name"), "UTF-8");
		String awd_org = URLDecoder.decode(request.getParameter("org"), "UTF-8");
		String awd_result = URLDecoder.decode(request.getParameter("result"), "UTF-8");
		String awd_memo = URLDecoder.decode(request.getParameter("memo"), "UTF-8");
		int awd_num = Integer.parseInt(request.getParameter("awd_num"));
		Object session_object=session.getAttribute("signedUser");
		String session_name=(String)session_object;
		
		String sql = "update award set awd_name=?, awd_org=?, awd_result=?, awd_memo=? where id=? and award_num=?;";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, awd_name);
		pstmt.setString(2, awd_org);
		pstmt.setString(3, awd_result);
		pstmt.setString(4, awd_memo);
		pstmt.setString(5, session_name);
		pstmt.setInt(6, awd_num);
		pstmt.executeUpdate();
		
		DBUtil.close(pstmt);
		DBUtil.close(conn);
	} catch(SQLException e){
		System.out.println(e.toString());
	}
	%>
	
</body>
</html>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.sql.*" %>
<%@ page import="file.DBUtil" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
		
		String school_name = URLDecoder.decode(request.getParameter("graduated_name"), "UTF-8");
		String school_location = URLDecoder.decode(request.getParameter("graduated_location"), "UTF-8");
		String division = URLDecoder.decode(request.getParameter("graduated_division"), "UTF-8");
		String e_date = URLDecoder.decode(request.getParameter("graduated_e_date"), "UTF-8");
		String g_date = URLDecoder.decode(request.getParameter("graduated_g_date"), "UTF-8");
		String g_state = URLDecoder.decode(request.getParameter("graduated_g_state"), "UTF-8");
		String major = URLDecoder.decode(request.getParameter("graduated_major"), "UTF-8");
		String grade = URLDecoder.decode(request.getParameter("graduated_grade"), "UTF-8");
		String total_grade = URLDecoder.decode(request.getParameter("graduated_total_grade"), "UTF-8");
		String edu_memo = URLDecoder.decode(request.getParameter("graduated_memo"), "UTF-8");
		int school_num = Integer.parseInt(request.getParameter("school_num"));

		String sql = "update education set school_name=?, school_location=?, division=?, e_date=?, g_date=?, g_state=?, major=?, grade=?, total_grade=?, edu_memo=? where school_radio='3' and id=? and school_num=?;";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, school_name);
		pstmt.setString(2, school_location);
		pstmt.setString(3, division);
		pstmt.setString(4, e_date);
		pstmt.setString(5, g_date);
		pstmt.setString(6, g_state);
		pstmt.setString(7, major);
		pstmt.setString(8, grade);
		pstmt.setString(9, total_grade);
		pstmt.setString(10, edu_memo);
		pstmt.setString(11, session_name);
		pstmt.setInt(12, school_num);
		pstmt.executeUpdate();

		pstmt.close();	
		conn.close();
	} catch(SQLException e){
		System.out.println(e.toString());
	}
	%>
</body>
</html>
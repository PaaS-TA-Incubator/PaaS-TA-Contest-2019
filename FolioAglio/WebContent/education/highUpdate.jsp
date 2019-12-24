<%@ page import="java.sql.*" %>
<%@ page import="file.DBUtil" %>
<%@ page import="java.net.URLDecoder"%>
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
	Object session_object = session.getAttribute("signedUser");
	String session_name = (String)session_object;
	
	try{
		String school_name = URLDecoder.decode(request.getParameter("name"), "UTF-8");
		String school_location = URLDecoder.decode(request.getParameter("location"), "UTF-8");
		String division = URLDecoder.decode(request.getParameter("division"), "UTF-8");
		String e_date = URLDecoder.decode(request.getParameter("e_date"), "UTF-8");
		String g_date = URLDecoder.decode(request.getParameter("g_date"), "UTF-8");
		String g_state = URLDecoder.decode(request.getParameter("g_state"), "UTF-8");
		String edu_memo = URLDecoder.decode(request.getParameter("memo"), "UTF-8");
		int school_num = Integer.parseInt(request.getParameter("school_num"));
		
		Connection conn = DBUtil.getConn();
		String sql = "update education set school_name=?, school_location=?, division=?, e_date=?, g_date=?, g_state=?, edu_memo=? where school_radio='1' and id=? and school_num=?;";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, school_name);
		pstmt.setString(2, school_location);
		pstmt.setString(3, division);
		pstmt.setString(4, e_date);
		pstmt.setString(5, g_date);
		pstmt.setString(6, g_state);
		pstmt.setString(7, edu_memo);
		pstmt.setString(8, session_name);
		pstmt.setInt(9, school_num);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	} catch (SQLException e){
		System.out.println(e.toString());
	}
	%>

</body>
</html>
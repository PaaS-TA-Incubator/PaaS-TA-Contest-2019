<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
	Connection conn = DBUtil.getConn();
	
	try{
		String radio = "";
		String school_radio = URLDecoder.decode(request.getParameter("radio"), "UTF-8");
		Object session_object = session.getAttribute("signedUser");
		String session_name = (String)session_object;
		
		if (school_radio.equals("high")) { 
			radio = "1";
			String school_name = URLDecoder.decode(request.getParameter("high_name"), "UTF-8");
			String school_location = URLDecoder.decode(request.getParameter("high_location"), "UTF-8");
			String division = URLDecoder.decode(request.getParameter("high_division"), "UTF-8");
			String e_date = URLDecoder.decode(request.getParameter("high_e_date"), "UTF-8");
			String g_date = URLDecoder.decode(request.getParameter("high_g_date"), "UTF-8");
			String g_state = URLDecoder.decode(request.getParameter("high_g_state"), "UTF-8");
			String edu_memo = URLDecoder.decode(request.getParameter("high_memo"), "UTF-8");
			
			String sql = "insert into education(school_radio, school_name, school_location, division, e_date, g_date, g_state, edu_memo, id) values (?,?,?,?,?,?,?,?,?);";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, radio);
			pstmt.setString(2, school_name);
			pstmt.setString(3, school_location);
			pstmt.setString(4, division);
			pstmt.setString(5, e_date);
			pstmt.setString(6, g_date);
			pstmt.setString(7, g_state);
			pstmt.setString(8, edu_memo);
			pstmt.setString(9, session_name);
			pstmt.executeUpdate();
			
			pstmt.close();
		}
		else if (school_radio.equals("collage")) { 
			radio = "2";
			String school_name = URLDecoder.decode(request.getParameter("collage_name"), "UTF-8");
			String school_location = URLDecoder.decode(request.getParameter("collage_location"), "UTF-8");
			String division = URLDecoder.decode(request.getParameter("collage_division"), "UTF-8");
			String e_state = URLDecoder.decode(request.getParameter("collage_e_state"), "UTF-8");
			String e_date = URLDecoder.decode(request.getParameter("collage_e_date"), "UTF-8");
			String g_date = URLDecoder.decode(request.getParameter("collage_g_date"), "UTF-8");
			String g_state = URLDecoder.decode(request.getParameter("collage_g_state"), "UTF-8");
			String major = URLDecoder.decode(request.getParameter("collage_major"), "UTF-8");
			String grade = URLDecoder.decode(request.getParameter("collage_grade"), "UTF-8");
			String total_grade = URLDecoder.decode(request.getParameter("collage_total_grade"), "UTF-8");
			String major_grade = URLDecoder.decode(request.getParameter("collage_major_grade"), "UTF-8");
			String classes = URLDecoder.decode(request.getParameter("collage_classes"), "UTF-8");
			String submajor = URLDecoder.decode(request.getParameter("collage_submajor"), "UTF-8");
			String edu_memo = URLDecoder.decode(request.getParameter("collage_memo"), "UTF-8");
			
			String sql = "insert into education(school_radio, school_name, school_location, division, e_state, e_date, g_date, g_state, major, grade, total_grade, major_grade, classes, submajor, edu_memo, id) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, radio);
			pstmt.setString(2, school_name);
			pstmt.setString(3, school_location);
			pstmt.setString(4, division);
			pstmt.setString(5, e_state);
			pstmt.setString(6, e_date);
			pstmt.setString(7, g_date);
			pstmt.setString(8, g_state);
			pstmt.setString(9, major);
			pstmt.setString(10, grade);
			pstmt.setString(11, total_grade);
			pstmt.setString(12, major_grade);
			pstmt.setString(13, classes);
			pstmt.setString(14, submajor);
			pstmt.setString(15, edu_memo);
			pstmt.setString(16, session_name);
			pstmt.executeUpdate();
			
			pstmt.close();
		}
		else { 
			radio = "3";
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

			String sql = "insert into education(school_radio, school_name, school_location, division, e_date, g_date, g_state, major, grade, total_grade, edu_memo, id) values (?,?,?,?,?,?,?,?,?,?,?,?);";
			PreparedStatement pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, radio);
			pstmt.setString(2, school_name);
			pstmt.setString(3, school_location);
			pstmt.setString(4, division);
			pstmt.setString(5, e_date);
			pstmt.setString(6, g_date);
			pstmt.setString(7, g_state);
			pstmt.setString(8, major);
			pstmt.setString(9, grade);
			pstmt.setString(10, total_grade);
			pstmt.setString(11, edu_memo);
			pstmt.setString(12, session_name);
			pstmt.executeUpdate();

			pstmt.close();	
		}
		conn.close();
	} catch(SQLException e){
		System.out.println(e.toString());
	}
	
	%>
	
</body>
</html>
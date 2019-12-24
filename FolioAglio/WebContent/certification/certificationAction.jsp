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
		String skill_radio = URLDecoder.decode(request.getParameter("radio"), "UTF-8");
		
		if (skill_radio.equals("language")){
			String language_name = URLDecoder.decode(request.getParameter("language_name"), "UTF-8");
			String kind = URLDecoder.decode(request.getParameter("kind"), "UTF-8");
			String application_num = URLDecoder.decode(request.getParameter("application_number"), "UTF-8");
			String test_date = URLDecoder.decode(request.getParameter("test_date"), "UTF-8");
			String score = URLDecoder.decode(request.getParameter("score"), "UTF-8");
			String score_name = URLDecoder.decode(request.getParameter("score_name"), "UTF-8");
			
			String sql = "insert into skill(skill_radio, language_name, kind, application_num, test_date, score, score_name, id) values (?,?,?,?,?,?,?,?);";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, skill_radio);
			pstmt.setString(2, language_name);
			pstmt.setString(3, kind);
			pstmt.setString(4, application_num);
			pstmt.setString(5, test_date);
			pstmt.setString(6, score);
			pstmt.setString(7, score_name);
			pstmt.setString(8, session_name);
			pstmt.executeUpdate();

			DBUtil.close(pstmt);
			DBUtil.close(conn);
		}
		else {
			String classfication_name = URLDecoder.decode(request.getParameter("classfication_name"), "UTF-8");
			String issue_org = URLDecoder.decode(request.getParameter("issue_org"), "UTF-8");
			String issue_date = URLDecoder.decode(request.getParameter("issue_date"), "UTF-8");
			
			String sql = "insert into skill(skill_radio, classfication_name, issue_org, issue_date, id) values (?,?,?,?,?);";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, skill_radio);
			pstmt.setString(2, classfication_name);
			pstmt.setString(3, issue_org);
			pstmt.setString(4, issue_date);
			pstmt.setString(5, session_name);
			pstmt.executeUpdate();
			
			DBUtil.close(pstmt);
			DBUtil.close(conn);
		}
	
	} catch(SQLException e){
		System.out.println(e.toString());
	}
	%>
	
</body>
</html>
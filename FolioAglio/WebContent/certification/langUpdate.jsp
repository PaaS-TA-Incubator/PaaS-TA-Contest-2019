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
	String session_name = (String)session.getAttribute("signedUser");
	
	try{
		Connection conn = DBUtil.getConn();
		
		String language_name = URLDecoder.decode(request.getParameter("language_name"), "UTF-8");
		String kind = URLDecoder.decode(request.getParameter("kind"), "UTF-8");
		String application_num = URLDecoder.decode(request.getParameter("application_number"), "UTF-8");
		String test_date = URLDecoder.decode(request.getParameter("test_date"), "UTF-8");
		String score = URLDecoder.decode(request.getParameter("score"), "UTF-8");
		String score_name = URLDecoder.decode(request.getParameter("score_name"), "UTF-8");
		int num = Integer.parseInt(request.getParameter("issue_num"));
		
		String sql = "update skill set language_name=?, kind=?, application_num=?, test_date=?, score=?, score_name=? where id=? and issue_num=? and skill_radio='language';";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, language_name);
		pstmt.setString(2, kind);
		pstmt.setString(3, application_num);
		pstmt.setString(4, test_date);
		pstmt.setString(5, score);
		pstmt.setString(6, score_name);
		pstmt.setString(7, session_name);
		pstmt.setInt(8, num);
		pstmt.executeUpdate();

		DBUtil.close(pstmt);
		DBUtil.close(conn);
	} catch(SQLException e){
			System.out.print(e.toString());
	}
	%>

</body>
</html>
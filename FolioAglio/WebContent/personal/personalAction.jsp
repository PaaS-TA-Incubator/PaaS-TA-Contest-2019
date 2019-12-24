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
	Connection conn = DBUtil.getConn();
		
	String country = URLDecoder.decode(request.getParameter("country"), "UTF-8");
	String birth = URLDecoder.decode(request.getParameter("birth"), "UTF-8");
	String name = URLDecoder.decode(request.getParameter("name"), "UTF-8");
	String en_name = URLDecoder.decode(request.getParameter("en_name"), "UTF-8");
	String sex = URLDecoder.decode(request.getParameter("gender"), "UTF-8");
	String email = URLDecoder.decode(request.getParameter("email"), "UTF-8");
	String call_num = URLDecoder.decode(request.getParameter("number"), "UTF-8");
	String address = URLDecoder.decode(request.getParameter("address"), "UTF-8");
	String git_address = URLDecoder.decode(request.getParameter("git_address"), "UTF-8");
	String personal_memo = URLDecoder.decode(request.getParameter("memo"), "UTF-8");
	Object session_object=session.getAttribute("signedUser");
	String session_name=(String)session_object;
	
	
	String sql = "update personal_information set country = ?,birth = ?,name = ? , en_name = ?, sex =?,email=?,call_num=?,address=?,git_address=?,personal_memo=? where id=? ;";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, country);
	pstmt.setString(2, birth);
	pstmt.setString(3, name);
	pstmt.setString(4, en_name);
	pstmt.setString(5, sex);
	pstmt.setString(6, email);
	pstmt.setString(7, call_num);
	pstmt.setString(8, address);
	pstmt.setString(9, git_address);
	pstmt.setString(10, personal_memo);
	pstmt.setString(11, session_name);
	pstmt.executeUpdate();
	
	DBUtil.close(pstmt);
	DBUtil.close(conn);
	%>
	
</body>
</html>
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
		
		String classfication_name = URLDecoder.decode(request.getParameter("classfication_name"), "UTF-8");
		String issue_org = URLDecoder.decode(request.getParameter("issue_org"), "UTF-8");
		String issue_date = URLDecoder.decode(request.getParameter("issue_date"), "UTF-8");
		int num = Integer.parseInt(request.getParameter("issue_num"));
		
		String sql = "update skill set classfication_name=?, issue_org=?, issue_date=? where id=? and issue_num=? and skill_radio='classfication';";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, classfication_name);
		pstmt.setString(2, issue_org);
		pstmt.setString(3, issue_date);
		pstmt.setString(4, session_name);
		pstmt.setInt(5, num);
		pstmt.executeUpdate();
		
		DBUtil.close(pstmt);
		DBUtil.close(conn);
	} catch(SQLException e){
			System.out.print(e.toString());
	}
	%>

</body>
</html>
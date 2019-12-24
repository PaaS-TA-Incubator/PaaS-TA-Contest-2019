<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="file.DBUtil" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

   <%
   Connection conn = DBUtil.getConn();
   String company_name = URLDecoder.decode(request.getParameter("name"), "UTF-8");
   String position = URLDecoder.decode(request.getParameter("position"), "UTF-8");
   String work = URLDecoder.decode(request.getParameter("work"), "UTF-8");
   String salary = URLDecoder.decode(request.getParameter("salary"), "UTF-8");
   String s_period = URLDecoder.decode(request.getParameter("s_period"), "UTF-8");
   String e_period = URLDecoder.decode(request.getParameter("e_period"), "UTF-8");
   String detail = URLDecoder.decode(request.getParameter("detail"), "UTF-8");
   String carrier_memo = URLDecoder.decode(request.getParameter("memo"), "UTF-8");
   Object session_object=session.getAttribute("signedUser");
	String session_name=(String)session_object;

   String sql = "insert into carrier(company_name, position, work, salary, s_period, e_period, detail, carrier_memo, id) values (?,?,?,?,?,?,?,?,?);";
   PreparedStatement pstmt = conn.prepareStatement(sql);
   
   pstmt.setString(1, company_name);
   pstmt.setString(2, position);
   pstmt.setString(3, work);
   pstmt.setString(4, salary);
   pstmt.setString(5, s_period);
   pstmt.setString(6, e_period);
   pstmt.setString(7, detail);
   pstmt.setString(8, carrier_memo);
   pstmt.setString(9, session_name);
   pstmt.executeUpdate();
   
   DBUtil.close(pstmt);
   DBUtil.close(conn);
   %>
</body>
</html>
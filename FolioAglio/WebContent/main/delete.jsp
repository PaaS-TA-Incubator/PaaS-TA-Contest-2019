<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="file.DBUtil" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

   <%
   Object session_object=session.getAttribute("signedUser");
   String session_name=(String)session_object;
   String title = URLDecoder.decode(request.getParameter("title"), "UTF-8");
   System.out.println(URLDecoder.decode(request.getParameter("title"), "UTF-8"));
   try{
      Connection conn = DBUtil.getConn();
   
      String sql = "delete from folio where id=? and title=?;";      
      PreparedStatement pstmt = conn.prepareStatement(sql);
         
      pstmt.setString(1, session_name);
      pstmt.setString(2, title);
      pstmt.executeUpdate();
      
      DBUtil.close(pstmt);
      DBUtil.close(conn);
      response.sendRedirect("main.jsp");
   } catch(SQLException e){
      System.out.println(e.toString());
   }
   %>
   
</body>
</html>
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

   try{
      Connection conn = DBUtil.getConn();
      
      String url = "IMG"+URLDecoder.decode(request.getParameter("name"), "UTF-8");
      String title = URLDecoder.decode(request.getParameter("title"), "UTF-8");
      Object session_object=session.getAttribute("signedUser");
      String session_name=(String)session_object;
      
      String sql = "insert into folio(url,title,id) values (?,?,?);";
      PreparedStatement pstmt = conn.prepareStatement(sql);
      
      pstmt.setString(1, url);
      pstmt.setString(2, title);
      pstmt.setString(3, session_name);

      pstmt.executeUpdate();
      
      DBUtil.close(pstmt);
      DBUtil.close(conn);
   } catch(SQLException e){
      System.out.println(e.toString());
   }
   %>
   
</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="file.DBUtil" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
   <%
   String userID = request.getParameter("userID");
   String userName = new String(request.getParameter("userName").getBytes("ISO-8859-1"), "UTF-8");
   String userEmail = request.getParameter("userEmail");
   
   
   Connection conn = DBUtil.getConn();
   
   try {
      String sql = "select name, email from personal_information where id=?";
      PreparedStatement stmt = conn.prepareStatement(sql);
      stmt.setString(1, userID);
      ResultSet rs = stmt.executeQuery();
      
      if(rs.next()){
         if (rs.getString(1).equals(userName) && rs.getString(2).equals(userEmail)){
            response.sendRedirect("repw.jsp?userID="+userID);
         }
         else{
            %> <script>
            alert("이름 또는 이메일이 틀렸습니다.");
            location.href="findpw.jsp";
               </script>
            <%
         }
      }
      
      else {
         %>
         <script>
         alert("존재하지 않는 ID입니다.");
         location.href="findpw.jsp";
         </script>
         <%
      }
      
      rs.close();
      stmt.close();
      conn.close();
      
   } catch(SQLException e){
      System.out.println(e.toString());
   }
   
   %>
</body>
</html>
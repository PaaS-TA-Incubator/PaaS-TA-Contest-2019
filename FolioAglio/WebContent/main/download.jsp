<%@ page import="file.fileDAO" %>
<%@ page import="java.io.File" %>
<%@page import="java.util.Enumeration"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.sql.*" %>
<%@ page import="file.DBUtil" %>
<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.debug.js"></script>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script>
window.onload = function (){
   html2canvas(document.body).then(function(canvas){

       var imgData = canvas.toDataURL('image/png');
      
       var imgWidth = 300;
       var pageHeight = imgWidth/1.414; // 한페이지의 길이

       var imgHeight = canvas.height * imgWidth/ canvas.width; //비율로 계산한 전체 높이
       var heightLeft = imgHeight;      //남은 높이

       var doc = new jsPDF('l', 'mm');
       var position = 0;
    
       // 첫 페이지 출력
       doc.addImage(imgData, 'PNG', 0, position,imgWidth, imgHeight);
       heightLeft -= pageHeight;
       
       while (heightLeft >= 0) {
          //position = heightLeft - pageHeight;
          position -= 210; 
          console.log(position);
          doc.addPage();
          doc.addImage(imgData, 'PNG', 0, position,imgWidth, imgHeight);
          heightLeft -= pageHeight;
       }
       doc.save('<%=request.getParameter("name")%>'+'.pdf');
});
}
       </script>
</head>
<body>
<%
   Connection conn = DBUtil.getConn();
   String session_name = (String)session.getAttribute("signedUser");
   String src = "";
    String name = URLDecoder.decode(request.getParameter("name"), "UTF-8");
      String sql = "select * from folio where id=? and title = ?";

      System.out.println(URLDecoder.decode(request.getParameter("name"), "UTF-8"));
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, session_name);
      pstmt.setString(2, name);
      ResultSet rs = pstmt.executeQuery();

      if(rs.next()) {
         src=rs.getString("url");
      }
%>
      <div style="text-align: center;" >
   <img src="../<%=src%>.png">
   </div>
</body>
</html>
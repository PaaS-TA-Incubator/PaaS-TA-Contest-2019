<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="file.DBUtil" %>
<%@ page import="sha256.ShaPasswordEncoderTest" %>

<%
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    Connection conn = DBUtil.getConn();
    
    String sql = "select salt,pwd from personal_information where id = ?;";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1,id);
    ResultSet rs = pstmt.executeQuery();
    
    
    String redirectUrl = "login.jsp"; // 인증 실패시 재요청 될 url 
    if(rs.next()){
    	String dbPW = rs.getString("pwd");
    	String dbsalt = rs.getString("salt");
    	ShaPasswordEncoderTest sha256 = new ShaPasswordEncoderTest();
        String hash = sha256.getName(pw+dbsalt);
        
    	if(dbPW.equals(hash)){
    		session.setAttribute("signedUser", id); // 인증되었음 세션에 남김
            redirectUrl = "main/main.jsp"; // 인증 성공 시 재요청 url
            response.sendRedirect(redirectUrl);
    	}
    	else{%>
    	<script> alert("잘못된 아이디나 패스워드를 입력하였습니다."); 
    	location.href="login.jsp";
    	</script>
    	<%
    	 }
    }
    else{%>
	<script> alert("잘못된 아이디나 패스워드를 입력하였습니다."); 
	location.href="login.jsp";
	</script>
	<%
	 }
    rs.close();
    conn.close();
    pstmt.close();

%>

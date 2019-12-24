<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="file.DBUtil" %>
<%@ page import="sha256.ShaPasswordEncoderTest" %>
<%
    String id = request.getParameter("id");
    String pwd = request.getParameter("pwd");
    String username = new String(request.getParameter("username").getBytes("ISO-8859-1"), "UTF-8");
    String email = request.getParameter("email");
    String call_num = request.getParameter("call_num");
    String birth = request.getParameter("birthyy") + "-" +request.getParameter("birthmm") +"-"+ request.getParameter("birthdd");
    String sex = new String(request.getParameter("sex").getBytes("ISO-8859-1"), "UTF-8");
    Connection conn = DBUtil.getConn();
	
    ShaPasswordEncoderTest sha256 = new ShaPasswordEncoderTest();
    String salt=sha256.generateSalt();
    String hash_pwd = sha256.getName(pwd+salt);
    
    String sql = "insert into personal_information (birth,name,sex,email,call_num,id,pwd,salt) values(?,?,?,?,?,?,?,?);";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1,birth);
    pstmt.setString(2,username);
    pstmt.setString(3,sex);
    pstmt.setString(4,email);
    pstmt.setString(5,call_num);
    pstmt.setString(6,id);
    pstmt.setString(7,hash_pwd);
    pstmt.setString(8,salt);
    pstmt.executeUpdate();

    conn.close();
    pstmt.close();
    %>
    <script> alert("회원가입이 완료되었습니다."); 
	location.href="login.jsp";
	</script>
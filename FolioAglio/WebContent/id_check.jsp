<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="file.DBUtil" %>
<%
    String id = request.getParameter("id");
    Connection conn = DBUtil.getConn();
    String sql = "select id from personal_information where id = ?;";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1,id);
    ResultSet rs = pstmt.executeQuery();

    if(rs.next()){
    	out.write("0");
    }
    else{
    	out.write("1");
    	}
    
    rs.close();
    conn.close();
    pstmt.close();

%>
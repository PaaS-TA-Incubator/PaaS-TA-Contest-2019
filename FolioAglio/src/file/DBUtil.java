package file;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class DBUtil {
	public static Connection getConn() {
		Connection conn = null;
		try {
			String url = "jdbc:mysql://10.10.5.15:3306/op_242b1bc8_a6d7_417e_8fcd_77b2d623d514?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
			String id = "b5ccb48763e31451";
			String pw = "c32ca248cd0ba4a7";
			
//			String url = "jdbc:mysql://localhost:3306/file?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&characterEncoding=UTF-8";
//			String id = "root";
//			String pw = "";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(url, id, pw);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	public static void close(Connection conn) {
		try{if(conn != null) {conn.close();}}catch(Exception e) {e.printStackTrace();}
	}
	public static void close(Statement stmt) {
		try{if(stmt != null) {stmt.close();}}catch(Exception e) {e.printStackTrace();}
	}
	public static void close(ResultSet rs) {
		try{if(rs != null) {rs.close();}}catch(Exception e) {e.printStackTrace();}
	}
	public static void close(PreparedStatement pstmt) {
		try{if(pstmt != null) {pstmt.close();}}catch(Exception e) {e.printStackTrace();}
	}
}

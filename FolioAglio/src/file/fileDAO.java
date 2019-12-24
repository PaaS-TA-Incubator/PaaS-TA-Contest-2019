package file;

import java.sql.*;

public class fileDAO {

   private Connection conn;

   // 생성자를 통해 db연결 해줌

   public fileDAO() {

      try {

         String url = "jdbc:mysql://10.10.5.15:3306/op_242b1bc8_a6d7_417e_8fcd_77b2d623d514?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
         String id = "b5ccb48763e31451";
         String pw = "c32ca248cd0ba4a7";
         
//         String url = "jdbc:mysql://localhost:3306/file?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&characterEncoding=UTF-8";
//         String id = "root";
//         String pw = "system";

         Class.forName("com.mysql.cj.jdbc.Driver");
         conn = DriverManager.getConnection(url, id, pw);

      } catch(Exception e) {

         e.printStackTrace();

      }

   }


   public int upload(String table, String fileRealName, String session_name, String com) {
      String SQL = "";
      
      if(table.equals("abroad")) {
         SQL = "update abroad set picture=? where id=? and country_name=?";
      }

      else if(table.equals("award")) {
         SQL = "update award set picture=? where id=? and awd_name=?";
      }

      else if(table.equals("carrier")) {   
         SQL = "update carrier set picture=? where id=? and company_name=?";
      }


      else if(table.equals("external_activity")) {
         SQL = "update external_activities set picture=? where id=? and group_name=?";
      }

      try {

         PreparedStatement pstmt = conn.prepareStatement(SQL);

         //pstmt.setString(1,  table);

         pstmt.setString(1,  fileRealName);
         
         pstmt.setString(2,  session_name);
         
         pstmt.setString(3, com);

         return pstmt.executeUpdate();

      } catch(Exception e) {

         e.printStackTrace();

      }
      

      return -1;

   }

   
   public int p_upload(String table, String fileRealName, String session_name) {
      String SQL = "update personal_information set picture=? where id=?";
      try {
         PreparedStatement pstmt = conn.prepareStatement(SQL);
         pstmt.setString(1,  fileRealName);
         pstmt.setString(2,  session_name);
         return pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      }
      return -1;
   }

}
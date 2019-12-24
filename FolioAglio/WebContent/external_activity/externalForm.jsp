<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="file.DBUtil" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../maincss.css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale ="1">
<title>대외활동</title>
<script>
   window.addEventListener('load', function() {
      var confirm = document.querySelector('#confirm');
      
      confirm.addEventListener('click', function() {

         var radio = document.querySelector('#radio');
         var name = document.querySelector('#name');
         var s_period = document.querySelector("#s_period");
         var e_period = document.querySelector("#e_period");
         var detail = document.querySelector('#detail');
         var picture = document.querySelector('#picture');
         var memo = document.querySelector('#memo');
         
         // 전체 검사
         // 구분이 입력되지 않았을시
         if (radio.value == '') {
            alert('구분을 입력하세요.');
            radio.focus();
            // 단체명이 입력되지 않았을시
         } else if (name.value == '') {
            alert('단체명을 입력하세요.');
            name.focus();
         // 시작 활동기간이 입력되지 않았을시
         } else if (s_period.value == '') {
            alert('활동기간을 입력하세요.');
            s_period.focus();
            //끝 활동기간이 입력되지 않았을시
         } else if (e_period.value == '') {
            alert('활동기간을 입력하세요 ')
            e_period.focus();
         }else {
            var formData = $("#form1").serialize().replace(/%/g, '%25');
                 var form = $('#form2')[0];
             var formData2 = new FormData(form);
      
              $.ajax({
                   cache : false,
                   url : "externalUpdate.jsp", // 요기에
                   type : 'POST', 
                   data : formData,
                   async: false,
                   success : function(data) {
                  
                   }
               });
              $.ajax({
                   cache : false,
                   enctype: 'multipart/form-data',
                   url : "upload.jsp?com="+name.value, // 요기에
                   type : 'POST', 
                   data : formData2,
                   processData: false,
                   contentType: false,
                   async: false,   
                   success : function(data) {
                  
                   }
               });
              self.close();
              opener.location.reload();
         }

      });
   });
</script>
</head>
<body>
   <%
   
   int activity_num = Integer.parseInt(request.getParameter("activity_num"));
   Object session_object = session.getAttribute("signedUser");
   String session_name = (String)session_object;
   
   try{
      Connection conn = DBUtil.getConn();
      String sql = "select activity_radio, group_name, activity_s_date, activity_e_date, activity_detail, picture, activity_memo from external_activities where activity_num=? and id=?;";
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, activity_num);
      pstmt.setString(2, session_name);
      ResultSet rs = pstmt.executeQuery();
      
      if(rs.next()){
      
   %>
   <form action="externalUpdate.jsp" method="post" id = "form1">
      <fieldset class="field_info">
         <legend>대외 활동</legend>
         <table>
            <tr>
               <td>구분</td>
               <td><select id="radio" name = "radio">
                     <option <% if( rs.getString(1).equals("봉사활동"))  { out.print("selected"); } %>>봉사활동</option>
                     <option <% if( rs.getString(1).equals("교내활동"))  { out.print("selected"); } %>>교내활동</option>
                     <option <% if( rs.getString(1).equals("사회활동"))  { out.print("selected"); } %>>사회활동</option>
                     <option <% if( rs.getString(1).equals("아르바이트"))  { out.print("selected"); } %>>아르바이트</option>
                     <option <% if( rs.getString(1).equals("기타"))  { out.print("selected"); } %>>기타</option>
               </select></td>
            </tr>
            <tr>
               <td>단체명</td>
               <td><input type="text" id="name" name="name" value="<%=rs.getString(2) %>"></td>
            </tr>
            <tr>
               <td>활동기간</td>
               <td><input type="text" id="s_period" name="s_period" placeholder="날짜넣기" value="<%=rs.getString(3) %>">
               <script>
                  $(function(){
                     $("#s_period").datepicker({dateFormat: "yy-mm-dd"});
                  });
               </script> ~ 
               <input type="text" id="e_period" name="e_period" placeholder="날짜넣기" value="<%=rs.getString(4) %>">
               <script>
                  $(function(){
                     $("#e_period").datepicker({dateFormat: "yy-mm-dd"});
                  });
               </script></td>
            </tr>
            <tr>
               <td>상세설명</td>
               <td><textarea id="detail" name="detail" rows="10" cols="50"><%=rs.getString(5) %></textarea></td>
            </tr>
            <tr>
               <td>메모</td>
               <td><textarea id="memo" name="memo" rows="3" cols="50"> <%=rs.getString(7) %></textarea></td>
               <td><input type="hidden" name="activity_num" value="<%= activity_num %>"></td>
            </tr>
            <tr align="right">
               <td colspan="2"><input type="button" id="confirm" name="confirm" class="button_css"
                  value="확인">
               </td>
            </tr>
         </table>
      </fieldset>
   </form>
   
   <form method="post" id="form2" enctype="multipart/form-data" action="upload.jsp">
         <table>
            <tr>
               <td><input type="file" value="파일 선택" accept="image/*" id="picture" name="picture" value = "<%=rs.getString(6) %>"/></td>
            </tr>
            
         </table>
      </form>
   <%
      }
      rs.close();
      pstmt.close();
      conn.close();
   } catch(SQLException e){
      System.out.println(e.toString());
   }
   %>
</body>
</html>
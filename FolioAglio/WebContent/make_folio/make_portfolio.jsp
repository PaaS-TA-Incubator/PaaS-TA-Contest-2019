<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="file.DBUtil" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width" initial-scale ="1">
<link rel="stylesheet" href="../maincss.css">
<link rel="stylesheet" href="makePF.css">
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<meta charset="utf-8">
<title>경력</title>
<%
   Object session_object=session.getAttribute("signedUser");
   String session_name=(String)session_object;
   Connection conn = DBUtil.getConn();
%>
<script>
   var option = 'width=1100, height=screen.availHeight';
   function PI_Btn() {
      window.open('','folio', option);
      document.getElementById('PIForm').submit();
   }
   function eduBtn() {
      window.open('','folio', option);
      document.getElementById('eduForm').submit();
   }
   function carrBtn() {
      window.open('','folio', option);
      document.getElementById('carrForm').submit();
   }
   function abrdBtn() {
      window.open('','folio', option);
      document.getElementById('abrdForm').submit();
   }
   function EA_Btn() {
      window.open('','folio', option);
      document.getElementById('EAForm').submit();
   }
    function awdBtn() {
       window.open('','folio', option);
      document.getElementById('awdForm').submit();
   }
    function skBtn() {
       window.open('','folio', option);
      document.getElementById('skForm').submit();
   }
    function result() {
       var w = window.open("about:blank","_blank","width=1100, height=screen.availHeight, top=0,left=0,scrollbars=no");
      var formData = $("#PIForm,#eduForm,#carrForm,#abrdForm,#EAForm,#awdForm,#skForm").serialize();
      $.ajax({
         url : "FolioAction.jsp", // 요기에
         type : 'POST',
         data : formData,
         async: false,
         success : function(data) {
            w.document.write(data);
         }
      });

   }
</script>
<%  // 인증된 세션이 없는경우, 해당페이지를 볼 수 없게 함.
    if (session.getAttribute("signedUser") == null) {
        response.sendRedirect("../logout.jsp");
    }
%>
</head>
<body>

      <div align = center>
       <a href="../logout.jsp"><button class = "logout" style="float: right;">로그아웃</button></a>
      <a role="button" href="../main/main.jsp"><img src="../image/name.png"  width = "340" height="100" ></a>
      
   </div>
   <header>
      <div class="navbar container">
            <div class="navbar_item">
            <ul>
               <li><a class="menuLink" href="../personal/personal.jsp">인적</a></li>
               <li><a class="menuLink" href="../education/education.jsp">학력</a></li>
               <li><a class="menuLink" href="../career/career.jsp">경력</a></li>
               <li><a class="menuLink" href="../abroad/abroad.jsp">해외경험</a></li>
               <li><a class="menuLink" href="../external_activity/external_activity.jsp">대외활동</a></li>
               <li><a class="menuLink" href="../award/awards.jsp">수상경력</a></li>
               <li><a class="menuLink" href="../certification/certification.jsp">어학/자격증</a></li>
               <li><a class="menuLink" href="../calendar/Calendar.jsp">캘린더</a></li>
               </ul>
            </div>
      </div>
   </header>

   <% 
   String sql = "select * from personal_information where id = ?";
   PreparedStatement pstmt = conn.prepareStatement(sql);
   pstmt.setString(1,session_name);
   ResultSet rs = pstmt.executeQuery();%>
   <form method="post" name="PIForm" id="PIForm" action="FolioAction.jsp" target="folio">
      <div style="padding-bottom:20px; padding-top:20px;">
      <label for="pi" class="menu" title="인적사항 전체선택" style="cursor:pointer"><input type="checkbox" id="pi" class="m1" style="display:none">인적사항</label> <input type="button" class="btn" value="미리보기" onclick="PI_Btn()"/>
      <span style="float:right;">
<label for="total" class="letter1" style="cursor:pointer"><input type="checkbox" id="total" class="check-all">전체선택</label>
<button type="button" onclick="result()" class="button_css1">포트폴리오 생성</button></span>

      </div>
      <%if(rs.next()) {%>
            <input type="checkbox" class="chk1" name="PI" value="1"><label class="letter">국적</label>
            <input type="checkbox" class="chk1" name="PI" value="2"><label class="letter">성별</label>
            <input type="checkbox" class="chk1" name="PI" value="3"><label class="letter">주소</label>
            <input type="checkbox" class="chk1" name="PI" value="4"><label class="letter">git 주소</label>
            <input type="checkbox" class="chk1" name="PI" value="5"><label class="letter">사진</label>
            <input type="checkbox" class="chk1" name="PI" value="6"><label class="letter">메모</label>
      <%}
      rs.close();
      pstmt.close();
      %>
      
   </form>
   <% 
   sql = "select * from education where id = ?";
   pstmt = conn.prepareStatement(sql);
   pstmt.setString(1,session_name);
   rs = pstmt.executeQuery();%>
   <form method="post" id="eduForm" action="FolioAction.jsp" target="folio">
      <div style="padding-bottom:20px; padding-top:30px;">
      <label for="ED" class="menu" title="학력 전체선택" style="cursor:pointer"><input type="checkbox" id="ED" class="m2" style="display:none">학력</label> <input type="button" class="btn" value="미리보기" onclick="eduBtn()"></div>
      <%while(rs.next()) {%>
         <input type="checkbox" class="chk2" name="edu" value="<%=rs.getString("school_num")%>"><label class="letter"><%=rs.getString("school_name")%></label>
      <%}
      rs.close();
      pstmt.close();
      %>
      
   </form>
   <%
   sql = "select * from carrier where id = ?";
   pstmt = conn.prepareStatement(sql);
   pstmt.setString(1,session_name);
   rs = pstmt.executeQuery();%>
   <form method="post" id="carrForm" action="FolioAction.jsp" target="folio">
      <div style="padding-bottom:20px; padding-top:30px;">
      <label for="CA" class="menu" title="경력 전체선택" style="cursor:pointer"><input type="checkbox" id="CA" class="m3" style="display:none">경력</label> <input type="button" class="btn" value="미리보기" onclick="carrBtn()"></div>
      <%while(rs.next()) {%>
         <input type="checkbox" class="chk3" name="carr" value="<%=rs.getString("carrier_num")%>"><label class="letter"><%=rs.getString("company_name")%></label>
      <%}
      rs.close();
      pstmt.close();
      %>
      
   </form>
   <% 
   sql = "select * from abroad where id = ?";
   pstmt = conn.prepareStatement(sql);
   pstmt.setString(1,session_name);
   rs = pstmt.executeQuery();%>
   <form method="post" id="abrdForm" action="FolioAction.jsp" target="folio">
      <div style="padding-bottom:20px; padding-top:30px;">
      <label for="AB" class="menu" title="해외경험 전체선택" style="cursor:pointer"><input type="checkbox" id="AB" class="m4" style="display:none">해외경험</label> <input type="button" class="btn" value="미리보기" onclick="abrdBtn()"></div>
      <%while(rs.next()) {%>
         <input type="checkbox" class="chk4" name="abrd" value="<%=rs.getString("abroad_num")%>"><label class="letter"><%=rs.getString("country_name")%></label>
      <%}
      rs.close();
      pstmt.close();
      %>
     
   </form>
   <% 
   sql = "select * from external_activities where id = ?";
   pstmt = conn.prepareStatement(sql);
   pstmt.setString(1,session_name);
   rs = pstmt.executeQuery();%>
   <form method="post" id="EAForm" action="FolioAction.jsp" target="folio">
      <div style="padding-bottom:20px; padding-top:30px;">
      <label for="ea" class="menu" title="대외활동 전체선택" style="cursor:pointer"><input type="checkbox" id="ea" class="m5" style="display:none">대외활동</label> <input type="button" class="btn" value="미리보기" onclick="EA_Btn()">
      </div>
      <%while(rs.next()) {%>
         <input type="checkbox" class="chk5" name="EA" value="<%=rs.getString("activity_num")%>"><label class="letter"><%=rs.getString("group_name")%></label>
      <%}
      rs.close();
      pstmt.close();
      %>
      
   </form>
   <% 
   sql = "select * from award where id = ?";
   pstmt = conn.prepareStatement(sql);
   pstmt.setString(1,session_name);
   rs = pstmt.executeQuery();%>
   <form method="post" id="awdForm" action="FolioAction.jsp" target="folio">
      <div style="padding-bottom:20px; padding-top:30px;">
      <label for="AW" class="menu" title="수상경력 전체선택" style="cursor:pointer"><input type="checkbox" id="AW" class="m6" style="display:none">수상경력</label>  <input type="button" class="btn" value="미리보기" onclick="awdBtn()"></div>
      <%while(rs.next()) {%>
         <input type="checkbox" class="chk6" name="award" value="<%=rs.getString("award_num")%>"><label class="letter"><%=rs.getString("awd_name")%></label>
      <%}
      rs.close();
      pstmt.close();
      %>

   </form>
   <% 
   sql = "select * from skill where id = ?";
   pstmt = conn.prepareStatement(sql);
   pstmt.setString(1,session_name);
   rs = pstmt.executeQuery();%>
   <form method="post" id="skForm" action="FolioAction.jsp" target="folio">
   <div style="padding-bottom:20px; padding-top:30px;">
    <label for="SK" class="menu" title="어학/자격증 전체선택" style="cursor:pointer"><input type="checkbox" id="SK" class="m7" style="display:none">어학/자격증</label> <input type="button" class="btn" value="미리보기" onclick="skBtn()">
   </div>
     
      <%
      String div1 = "language";
      String div2 = "classfication";
      while(rs.next()) {         
            if(div1.equals(rs.getString("skill_radio"))){%>
               <input type="checkbox" class="chk7" name="skill" value="<%=rs.getString("issue_num")%>"><label class="letter"><%=rs.getString("kind")%></label>
            <%} else if(div2.equals(rs.getString("skill_radio"))){%>
               <input type="checkbox" class="chk7" name="skill" value="<%=rs.getString("issue_num")%>"><label class="letter"><%=rs.getString("classfication_name")%></label>
            <%}
      }
      rs.close();
      pstmt.close();
      %>
      
   </form>
   <p style="padding:20px;"></p>

   
    <%conn.close();%>
    <script>
      $( document ).ready( function() {
        $( '.check-all' ).click( function() {
          $( '.chk1' ).prop( 'checked', this.checked );
          $( '.chk2' ).prop( 'checked', this.checked );
          $( '.chk3' ).prop( 'checked', this.checked );
          $( '.chk4' ).prop( 'checked', this.checked );
          $( '.chk5' ).prop( 'checked', this.checked );
          $( '.chk6' ).prop( 'checked', this.checked );
          $( '.chk7' ).prop( 'checked', this.checked );
        } );
        $( '.m1' ).click( function() {
            $( '.chk1' ).prop( 'checked', this.checked );
          } );
        $( '.m2' ).click( function() {
            $( '.chk2' ).prop( 'checked', this.checked );
          } );
        $( '.m3' ).click( function() {
            $( '.chk3' ).prop( 'checked', this.checked );
          } );
        $( '.m4' ).click( function() {
            $( '.chk4' ).prop( 'checked', this.checked );
          } );
        $( '.m5' ).click( function() {
            $( '.chk5' ).prop( 'checked', this.checked );
          } );
        $( '.m6' ).click( function() {
            $( '.chk6' ).prop( 'checked', this.checked );
          } );
        $( '.m7' ).click( function() {
            $( '.chk7' ).prop( 'checked', this.checked );
          } );
      } );
    </script>
</body>
</html>
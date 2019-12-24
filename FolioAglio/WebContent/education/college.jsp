<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="file.DBUtil" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../maincss.css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	window.addEventListener('load', function() {
		var confirm1 = document.querySelector('#confirm1');
		confirm1.addEventListener('click', function() {
	
			var radio = document.querySelectorAll('.radio'); //구분
			var name = document.querySelector('#collage_name'); //학교명
			var location = document.querySelector('#collage_location'); // 학교 소재지
			var division = document.querySelector('#collage_division'); //계열			
			var e_state = document.querySelector('#collage_e_state'); // 입학구분
			var e_date = document.querySelector("#collage_e_date"); //입학일자
			var g_date = document.querySelector('#collage_g_date'); // 졸업일자
			var g_state = document.querySelector('#collage_g_state'); //졸업여부
			var major = document.querySelector('#collage_major'); //전공
			var grade = document.querySelector('#collage_grade'); //학점
			var classes = document.querySelector('#collage_classes'); //이수학점
			var total_grade = document.querySelector('#collage_total_grade');//전체학점
			var major_grade = document.querySelector('#collage_major_grade');//전공학점
			var transfer = document.querySelector('#collage_submajor'); //복수전공, 부전공
			var memo = document.querySelector('#collage_memo');
			
			
			// 전체 검사
			if (collage_name.value == '') {
				alert('학교명을 입력하세요.');
				collage_name.focus();
			} else if (collage_location.value == '') {
				alert('학교 소재지를 입력하세요.');
				collage_location.focus();
			} else if (collage_division == '') {
				alert("계열을 입력하세요");
				collage_division.focus();
			} else if (collage_e_state.value == '') {
				alert('입학 구분을 입력하세요 ')
				collage_e_state.focus();
			} else if (collage_e_date.value == '') {
				alert('입학일자를 입력하세요 ')
				collage_e_date.focus();
			} else if (collage_g_date.value == '') {
				alert('졸업일자를 입력하세요 ')
				collage_g_date.focus();
			} else if (collage_g_state.value == '') {
				alert('졸업여부를 입력하세요 ')
				collage_g_state.focus();
			} else if (collage_major.value == '') {
				alert('전공을 입력하세요 ')
				collage_major.focus();
			} else if (collage_grade.value == '') {
				alert('학점을 입력하세요 ')
				collage_grade.focus();
			} else if (collage_major_grade.value == '') {
				alert('전공 학점을 입력하세요 ')
				collage_major_grade.focus();
			} else if (collage_classes.value == '') {
				alert('이수 학점을 입력하세요 ')
				collage_classes.focus();
			} else if (collage_total_grade.value == '') {
				alert('전체 학점을 입력하세요 ')
				collage_total_grade.focus();
			}else {
	        	 var formData = $("#form1").serialize();
	        	 $.ajax({
	                 cache : false,
	                 url : "collegeUpdate.jsp", // 요기에
	                 type : 'POST', 
	                 data : formData,
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
<meta charset="utf-8">
<title>대학교</title>
<%  // 인증된 세션이 없는경우, 해당페이지를 볼 수 없게 함.
    if (session.getAttribute("signedUser") == null) {
        response.sendRedirect("../logout.jsp");
    }
%>
</head>
<body>
	<%
	Connection conn = DBUtil.getConn();
	int school_num = Integer.parseInt(request.getParameter("school_num"));
	String session_name = (String)session.getAttribute("signedUser");
	
	try {
		String sql = "select school_name, school_location, division, e_state, e_date, g_date, g_state, major, grade, total_grade, major_grade, classes, submajor, edu_memo from education where school_num=? and id=?;";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, school_num);
		pstmt.setString(2, session_name);
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()){
	%>
	<form action="collegeUpdate.jsp" method="post" id="form1">
		<fieldset class = "field_info">
			<legend>대학교</legend>
			<table  id="collage" style="display:block;">
			<tr>
					<td>학교명</td>
					<td><input type="text" id="collage_name" name="collage_name" value="<%=rs.getString(1) %>"></td>
				</tr>
				<tr>
					<td>학교 소재지</td>
					<td><select id="collage_location" name = "collage_location">
							<option <%if( rs.getString(2).equals("강원도"))  { out.print("selected"); }%>>강원도</option>
							<option <%if( rs.getString(2).equals("경기도"))  { out.print("selected"); }%>>경기도</option>
							<option <%if( rs.getString(2).equals("경상남도"))  { out.print("selected"); }%>>경상남도</option>
							<option <%if( rs.getString(2).equals("경상북도"))  { out.print("selected"); }%>>경상북도</option>
							<option <%if( rs.getString(2).equals("광주광역시"))  { out.print("selected"); }%>>광주광역시</option>
							<option <%if( rs.getString(2).equals("대구광역시"))  { out.print("selected"); }%>>대구광역시</option>
							<option <%if( rs.getString(2).equals("대전광역시"))  { out.print("selected"); }%>>대전광역시</option>
							<option <%if( rs.getString(2).equals("부산광역시"))  { out.print("selected"); }%>>부산광역시</option>
							<option <%if( rs.getString(2).equals("서울특별시"))  { out.print("selected"); }%>>서울특별시</option>
							<option <%if( rs.getString(2).equals("세종특별자치시"))  { out.print("selected"); }%>>세종특별자치시</option>
							<option <%if( rs.getString(2).equals("울산광역시"))  { out.print("selected"); }%>>울산광역시</option>
							<option <%if( rs.getString(2).equals("인천광역시"))  { out.print("selected"); }%>>인천광역시</option>
							<option <%if( rs.getString(2).equals("전라남도"))  { out.print("selected"); }%>>전라남도</option>
							<option <%if( rs.getString(2).equals("전라북도"))  { out.print("selected"); }%>>전라북도</option>
							<option <%if( rs.getString(2).equals("제주특별자치시도"))  { out.print("selected"); }%>>제주특별자치시도</option>
							<option <%if( rs.getString(2).equals("충청남도"))  { out.print("selected"); }%>>충청남도</option>
							<option <%if( rs.getString(2).equals("충청북도"))  { out.print("selected"); }%>>충청북도</option>
					</select></td>
				</tr>
				<tr>
					<td>계열</td>
					<td><select id="collage_division" name="collage_division">
							<option <%if( rs.getString(3).equals("인문계열"))  { out.print("selected"); }%>>인문계열</option>
							<option <%if( rs.getString(3).equals("사회계열"))  { out.print("selected"); }%>>사회계열</option>
							<option <%if( rs.getString(3).equals("예체능계열"))  { out.print("selected"); }%>>예체능계열</option>
							<option <%if( rs.getString(3).equals("자연과학계열"))  { out.print("selected"); }%>>자연과학계열</option>
							<option <%if( rs.getString(3).equals("공학계열"))  { out.print("selected"); }%>>공학계열</option>
							<option <%if( rs.getString(3).equals("농업계열"))  { out.print("selected"); }%>>농업계열</option>
							<option <%if( rs.getString(3).equals("의학계열"))  { out.print("selected"); }%>>의학계열</option>
							<option <%if( rs.getString(3).equals("기타"))  { out.print("selected"); }%>>기타</option>
					</select></td>
				</tr>
				<tr>
					<td>입학구분</td>
					<td><select id="collage_e_state" name = "collage_e_state">
							<option <%if( rs.getString(4).equals("입학"))  { out.print("selected"); }%>>입학</option>
							<option <%if( rs.getString(4).equals("편입"))  { out.print("selected"); }%>>편입</option>
					</select></td>
				</tr>
				<tr>
					<td>입학일자</td>
					<td><input type="text" id="collage_e_date" name="collage_e_date" placeholder="날짜넣기" value="<%=rs.getString(5)%>">
					<script>
						$(function(){
							$("#collage_e_date").datepicker({dateFormat: "yy-mm-dd"});
						});
					</script></td>
				</tr>
				<tr>
					<td>졸업일자</td>
					<td><input type="text" id="collage_g_date" name="collage_g_date" placeholder="날짜넣기" value="<%=rs.getString(6)%>">
					<script>
						$(function(){
							$("#collage_g_date").datepicker({dateFormat: "yy-mm-dd"});
						});
					</script></td>
				</tr>
				<tr>
					<td>졸업여부</td>
					<td><select id="collage_g_state" name = "collage_g_state">
							<option <%if( rs.getString(7).equals("졸업"))  { out.print("selected"); }%>>졸업</option>
							<option <%if( rs.getString(7).equals("졸업예정"))  { out.print("selected"); }%>>졸업예정</option>
							<option <%if( rs.getString(7).equals("중퇴"))  { out.print("selected"); }%>>중퇴</option>
							<option <%if( rs.getString(7).equals("휴학"))  { out.print("selected"); }%>>휴학</option>
							<option <%if( rs.getString(7).equals("재학"))  { out.print("selected"); }%>>재학</option>
					</select></td>
				</tr>
				<tr>
					<td>전공</td>
					<td><input type="text" id="collage_major" name="collage_major" value="<%=rs.getString(8) %>"></td>
				</tr>
				<tr>
					<td>학점</td>
					<td><input type="text" id="collage_grade" name="collage_grade" value="<%=rs.getString(9) %>"> / <select id="collage_total_grade" name = "collage_total_grade">
							<option <%if( rs.getString(10).equals("4.0"))  { out.print("selected"); }%>>4.0</option>
							<option <%if( rs.getString(10).equals("4.3"))  { out.print("selected"); }%>>4.3</option>
							<option <%if( rs.getString(10).equals("4.5"))  { out.print("selected"); }%>>4.5</option>
							<option <%if( rs.getString(10).equals("5.0"))  { out.print("selected"); }%>>5.0</option>
							<option <%if( rs.getString(10).equals("7.0"))  { out.print("selected"); }%>>7.0</option>
							<option <%if( rs.getString(10).equals("100"))  { out.print("selected"); }%>>100</option>
					</select></td>
				</tr>
				<tr>
					<td>전공학점</td>
					<td><input type="text" id="collage_major_grade" name="collage_major_grade" value="<%=rs.getString(11) %>"> / <select id="collage_total_grade" name = "collage_total_grade">
							<option <%if( rs.getString(10).equals("4.0"))  { out.print("selected"); }%>>4.0</option>
							<option <%if( rs.getString(10).equals("4.3"))  { out.print("selected"); }%>>4.3</option>
							<option <%if( rs.getString(10).equals("4.5"))  { out.print("selected"); }%>>4.5</option>
							<option <%if( rs.getString(10).equals("5.0"))  { out.print("selected"); }%>>5.0</option>
							<option <%if( rs.getString(10).equals("7.0"))  { out.print("selected"); }%>>7.0</option>
							<option <%if( rs.getString(10).equals("100"))  { out.print("selected"); }%>>100</option>
					</select></td>
				</tr>
				<tr>
					<td>이수학점</td>
					<td><input type="text" id="collage_classes" name="collage_classes" value="<%=rs.getString(12) %>"></td>
				</tr>
				<tr>
					<td>부전공 / 복수전공 명</td>
					<td><input type="text" id="collage_submajor" name="collage_submajor" value="<%=rs.getString(13) %>"></td>
				</tr>
				<tr>
					<td>메모</td>
					<td><textarea id="collage_memo" name="collage_memo" rows="3" cols="50"> <%=rs.getString(14) %></textarea></td>
				</tr>
				<tr align="right">
					<td colspan="2"><input type="button" id="confirm1" class="button_css"
						value="수정">
					</td>
					<td><input type="hidden" name="school_num" value="<%=school_num %>"></td>
				</tr>
			</table>
		</fieldset>
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
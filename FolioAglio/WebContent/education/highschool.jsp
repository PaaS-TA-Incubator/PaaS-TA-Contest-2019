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

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale ="1">
<meta charset="utf-8">
<title>고등학교</title>
<script>
	window.addEventListener('load', function() {
		var confirm = document.querySelector('#confirm');
		
		confirm.addEventListener('click', function() {
	
			var name = document.querySelector('#name'); //학교명
			var location = document.querySelector('#location'); // 학교 소재지
			var division = document.querySelector('#division'); //계열			
			var e_date = document.querySelector("#e_date"); //입학일자
			var g_date = document.querySelector('#g_date'); // 졸업일자
			var g_state = document.querySelector('#g_state'); //졸업여부
			var memo = document.querySelector('#memo'); //메모
			
			
			// 전체 검사
			if (name.value == '') {
				alert('학교명을 입력하세요.');
				name.focus();
			} else if (location.value == '') {
				alert('학교 소재지를 입력하세요.');
				location.focus();
			} else if (division == '') {
				alert("계열을 입력하세요");
				division.focus();
			} else if (e_date.value == '') {
				alert('입학일자를 입력하세요 ');
				e_date.focus();
			} else if (g_date.value == '') {
				alert('졸업일자를 입력하세요 ');
				g_date.focus();
			} else if (g_state.value == '') {
				alert('졸업여부를 입력하세요 ');
				g_state.focus();
			}else {
				 var formData = $("#form1").serialize();
	        	 $.ajax({
	                 cache : false,
	                 url : "highUpdate.jsp", // 요기에
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
</head>
<body>
	<%
	
	int school_num =  Integer.parseInt(request.getParameter("school_num"));
	String session_name = (String)session.getAttribute("signedUser");
	
	try{
		Connection conn = DBUtil.getConn();
		String sql = "select school_name, school_location, division, e_date, g_date, g_state, edu_memo from education where school_num=? and id=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, school_num);
		pstmt.setString(2, session_name);
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()){
	%>
	<form action="highUpdate.jsp" method="post" id="form1">
		<fieldset class = "field_info">
			<legend>고등학교</legend>
			<table>
				<tr>
					<td>학교명</td>
					<td><input type="text" id="name" name="name" value="<%=rs.getString(1) %>"></td>
				</tr>
				<tr>
					<td>학교 소재지</td>
					<td><select id="location" name = "location">
							<option <%if( rs.getString(2).equals("강원도"))  { out.print("selected"); }%>>강원도</option>
							<option <%if( rs.getString(2).equals("경기도"))  { out.print("selected"); }%>>경기도</option>
							<option <%if( rs.getString(2).equals("경상남도"))  { out.print("selected"); }%>>경상남도</option>
							<option <%if( rs.getString(2).equals("경상북도"))  { out.print("selected"); }%>>경상북도</option>
							<option <%if( rs.getString(2).equals("광주광역시"))  { out.print("selected"); }%>ion>광주광역시</option>
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
					<td><select id="division" name="division">
							<option <%if( rs.getString(3).equals("인문계"))  { out.print("selected"); }%>>인문계</option>
							<option <%if( rs.getString(3).equals("공업"))  { out.print("selected"); }%>>공업</option>
							<option <%if( rs.getString(3).equals("과학"))  { out.print("selected"); }%>>과학</option>
							<option <%if( rs.getString(3).equals("농업"))  { out.print("selected"); }%>>농업</option>
							<option <%if( rs.getString(3).equals("마이스터"))  { out.print("selected"); }%>>마이스터</option>
							<option <%if( rs.getString(3).equals("상업"))  { out.print("selected"); }%>>상업</option>
							<option <%if( rs.getString(3).equals("예술"))  { out.print("selected"); }%>>예술</option>
							<option <%if( rs.getString(3).equals("외국어"))  { out.print("selected"); }%>>외국어</option>
							<option <%if( rs.getString(3).equals("체육"))  { out.print("selected"); }%>>체육</option>
							<option <%if( rs.getString(3).equals("특성화"))  { out.print("selected"); }%>>특성화</option>
							<option <%if( rs.getString(3).equals("기타"))  { out.print("selected"); }%>>기타</option>
					</select></td>
				</tr>
				<tr>
					<td>입학일자</td>
					<td><input type="text" id="e_date" name="e_date" value="<%=rs.getString(4)%>">
					<script>
						$(function(){
							$("#e_date").datepicker({dateFormat: "yy-mm-dd"});
						});
					</script></td>
				</tr>
				<tr>
					<td>졸업일자</td>
					<td><input type="text" id="g_date" name="g_date" value="<%=rs.getString(5)%>">
					<script>
						$(function(){
							$("#e_date").datepicker({dateFormat: "yy-mm-dd"});
						});
					</script></td>
				</tr>
				<tr>
					<td>졸업여부</td>
					<td><select id="g_state" name = "g_state">
							<option <%if( rs.getString(6).equals("졸업"))  { out.print("selected"); }%>>졸업</option>
							<option <%if( rs.getString(6).equals("졸업예정"))  { out.print("selected"); }%>>졸업예정</option>
							<option <%if( rs.getString(6).equals("중퇴"))  { out.print("selected"); }%>>중퇴</option>
							<option <%if( rs.getString(6).equals("휴학"))  { out.print("selected"); }%>>휴학</option>
							<option <%if( rs.getString(6).equals("재학"))  { out.print("selected"); }%>>재학</option>
					</select></td>
				</tr>
				<tr>
					<td>메모</td>
					<td><textarea id="memo" name="memo" rows="3" cols="50"><%=rs.getString(7) %></textarea></td>
				</tr>
				
				<tr align="right">
					<td colspan="2"><input type="button" id="confirm"
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
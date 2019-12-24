<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="file.DBUtil"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../maincss.css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale ="1">
<title>경력</title>
<script>
	window.addEventListener('load', function() {
		var confirm = document.querySelector('#confirm');
		
		confirm.addEventListener('click', function() {

			var name = document.querySelector('#name');
			var position = document.querySelector('#position');
			var work = document.querySelector('#work');
			var salary = document.querySelector('#salary');
			var s_period = document.querySelector("#s_period");
			var e_period = document.querySelector("#e_period");
			var detail = document.querySelector('#detail');
			var picture = document.querySelector('#picture');
			var memo = document.querySelector('#memo');
			
			
			
			// 전체 검사
			// 회사명이 입력되지 않았을시
			if (name.value == '') {
				alert('회사명을 입력하세요.');
				name.focus();
				// 직위가 입력되지 않았을시
			} else if (position.value == '') {
				alert('직위를 입력하세요.');
				position.focus();
				// 담당업무가 입력되지 않았을시
			} else if (work.value == '') {
				alert('담당 업무를 입력하세요.');
				work.focus();
				// 연봉이 입력되지 않았을시
			} else if (salary.value == '') {
				alert('연봉을 입력하세요.');
				salary.focus();
			// 시작 재직기간이 입력되지 않았을시
			} else if (s_period.value == '') {
				alert('재직기간을 입력하세요.');
				s_period.focus();
				//끝 재직기간이 입력되지 않았을시
			} else if (e_period.value == '') {
				alert('재직기간을 입력하세요 ')
				e_period.focus();
			}else {
				//저장하는거 구현해야함
				var formData = $("#form1").serialize();
				var form = $('#form2')[0];
	             var formData2 = new FormData(form);
        	 $.ajax({
                 cache : false,
                 url : "careerUpdate.jsp", // 요기에
                 type : 'POST', 
                 data : formData,
                 async: false,
                 success : function(data) {
					
                 }
             });
        	 $.ajax({
                 cache : false,
                 contentType: "application/x-www-form-urlencoded; charset=utf-8",
                 enctype: 'multipart/form-data',
                 url : "upload.jsp?com="+(name.value).replace(/%/g, '%25'), // 요기에
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
	int carr_num = Integer.parseInt(request.getParameter("carr_num"));
	Connection conn = DBUtil.getConn();
	
	String sql = "select company_name, position, work, salary, s_period, e_period, detail, picture, carrier_memo from carrier where carrier_num=?;";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, carr_num);
	ResultSet rs = pstmt.executeQuery();	
	
	if(rs.next()){
	
	%>
	<form action="careerUpdate.jsp" method="post" id = "form1">
		<fieldset class="field_info">
			<legend>경력</legend>
			<table>
				<tr>
					<td>회사명</td>
					<td><input type="text" id="name" name="name" value="<%=rs.getString(1) %>"></td>
				</tr>
				<tr>
					<td>직위</td>
					<td><input type="text" id="position" name="position" value="<%=rs.getString(2) %>"></td>
				</tr>
				<tr>
					<td>담당업무</td>
					<td><input type="text" id="work" name="work" value="<%=rs.getString(3) %>"></td>
				</tr>
				<tr>
					<td>연봉</td>
					<td><input type="text" id="salary" name="salary" value="<%=rs.getString(4) %>"></td>
				</tr>
				<tr>
					<td>재직기간</td>
					<td><input type="text" id="s_period" name="s_period" placeholder="날짜넣기"  value="<%=rs.getString(5) %>">
					<script>
						$(function(){
							$("#s_period").datepicker({dateFormat: "yy-mm-dd"});
						});
					</script> ~ 
					<input type="text" id="e_period" name="e_period" placeholder="날짜넣기" value="<%=rs.getString(6) %>">
					<script>
						$(function(){
							$("#e_period").datepicker({dateFormat: "yy-mm-dd"});
						});
					</script></td>
				</tr>
				<tr>
					<td>상세설명</td>
					<td><textarea id="detail" name="detail" rows="10" cols="50"> <%=rs.getString(7) %></textarea></td>
				</tr>
				<tr>
					<td>메모</td>
					<td><textarea id="memo" name="memo" rows="3" cols="50"><%=rs.getString(9) %></textarea></td>
				</tr>
								<tr align="right">
					<td colspan="2"><input type="button" id="confirm" name="confirm" class="button_css"
						value="확인">
					</td>
					<td><input type="hidden" name="carr_num" value="<%=carr_num%>"></td>
				</tr>
			</table>
		</fieldset>
	</form>
	<form method="post" id="form2" enctype="multipart/form-data" action="upload.jsp">
			<table>
				<tr>
					<td><input type="file" value="파일 선택" id="picture" accept="image/*" name="picture" value="<%=rs.getString(8) %>"/></td>
				</tr>
				
			</table>
		</form>
	<%
	}
	rs.close();
	pstmt.close();
	conn.close();
	%>
</body>
</html>
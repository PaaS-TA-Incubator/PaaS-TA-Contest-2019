<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../maincss.css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale ="1">
<title>학력</title>
<script type="text/javascript">
	$(document).ready(function(){
		$("#high #e_date").datepicker({ dateFormat: 'yy-mm-dd' });
		$("#high #g_date").datepicker({ dateFormat: 'yy-mm-dd' });
		$("#collage #e_date").datepicker({ dateFormat: 'yy-mm-dd' });
		$("#collage #g_date").datepicker({ dateFormat: 'yy-mm-dd' });
		$("#graduated #e_date").datepicker({ dateFormat: 'yy-mm-dd' });
		$("#graduated #g_date").datepicker({ dateFormat: 'yy-mm-dd' });
	});
		
	function Rradio_OnOff(id){
		if(id == "high"){
			document.all["high"].style.display = '';
			document.all["collage"].style.display = "none";
			document.all["graduated"].style.display = "none";
		}else if(id == "collage"){
			document.all["high"].style.display = "none";
			document.all["collage"].style.display = ''
			document.all["graduated"].style.display = "none";
		}else{
			document.all["high"].style.display = "none";
			document.all["collage"].style.display = "none"
			document.all["graduated"].style.display = '';
		}
		
	}
	window.addEventListener('load', function() {
		var confirm = document.querySelector('#confirm');
		
		confirm.addEventListener('click', function() {

			var radio = document.querySelectorAll('.radio'); //구분
			var name = document.querySelector('#high_name'); //학교명
			var location = document.querySelector('#high_location'); // 학교 소재지
			var division = document.querySelector('#high_division'); //계열			
			var e_date = document.querySelector("#high_e_date"); //입학일자
			var g_date = document.querySelector('#high_g_date'); // 졸업일자
			var g_state = document.querySelector('#high_g_state'); //졸업여부
			var memo = document.querySelector('#high_memo'); //메모
			
			
			// 전체 검사
			if (high_name.value == '') {
				alert('학교명을 입력하세요.');
				high_name.focus();
			} else if (high_location.value == '') {
				alert('학교 소재지를 입력하세요.');
				high_location.focus();
			} else if (high_division == '') {
				alert("계열을 입력하세요");
				high_division.focus();
			} else if (high_e_date.value == '') {
				alert('입학일자를 입력하세요 ')
				high_e_date.focus();
			} else if (high_g_date.value == '') {
				alert('졸업일자를 입력하세요 ')
				high_g_date.focus();
			} else if (high_g_state.value == '') {
				alert('졸업여부를 입력하세요 ')
				high_g_state.focus();
			}else {
	        	 var formData = $("#form1").serialize();
	        	 $.ajax({
	                 cache : false,
	                 url : "educationAction.jsp", // 요기에
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
	                 url : "educationAction.jsp", // 요기에
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
		
		var confirm2 = document.querySelector('#confirm2');
		confirm2.addEventListener('click', function() {

			var radio = document.querySelectorAll('.radio'); //구분
			var name = document.querySelector('#graduated_name'); //학교명
			var location = document.querySelector('#graduated_location'); // 학교 소재지
			var division = document.querySelector('#graduated_division'); //계열			
			var e_date = document.querySelector("#graduated_e_date"); //입학일자
			var g_date = document.querySelector('#graduated_g_date'); // 졸업일자
			var g_state = document.querySelector('#graduated_g_state'); //졸업여부
			var major = document.querySelector('#graduated_major'); //전공
			var grade = document.querySelector('#graduated_grade'); //학점
			var total_grade = document.querySelector('#graduated_total_grade');//전체학점
			var memo = document.querySelector('#graduated_memo');
			
			
			// 전체 검사
			if (graduated_name.value == '') {
				alert('학교명을 입력하세요.');
				graduated_name.focus();
			} else if (graduated_location.value == '') {
				alert('학교 소재지를 입력하세요.');
				graduated_location.focus();
			} else if (graduated_division == '') {
				alert("계열을 입력하세요");
				graduated_division.focus();
			} else if (graduated_e_date.value == '') {
				alert('입학일자를 입력하세요 ')
				graduated_e_date.focus();
			} else if (graduated_g_date.value == '') {
				alert('졸업일자를 입력하세요 ')
				graduated_g_date.focus();
			} else if (graduated_g_state.value == '') {
				alert('졸업여부를 입력하세요 ')
				graduated_g_state.focus();
			} else if (graduated_major.value == '') {
				alert('전공을 입력하세요 ')
				graduated_major.focus();
			} else if (graduated_total_grade.value == '') {
				alert('전체 학점을 입력하세요 ')
				graduated_total_grade.focus();
			} else if (graduated_grade.value == '') {
				alert('학점을 입력하세요 ')
				graduated_grade.focus();
			}else {
	        	 var formData = $("#form1").serialize();
	        	 $.ajax({
	                 cache : false,
	                 url : "educationAction.jsp", // 요기에
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
	<form action="educationAction.jsp" method="post" id = "form1">
		<fieldset class = "field_info">
			<legend>학력</legend>
			<table>
				<tr>
					<td>구분</td>
					<td><input type="radio" id="radio" value="high" name="radio" onclick="Rradio_OnOff('high');" checked/> 고등학교
						<input type="radio" id="radio" value="collage" name="radio" onclick="Rradio_OnOff('collage');">대학교
						<input type="radio" id="radio" value="graduated" name="radio" onclick="Rradio_OnOff('graduated');"> 대학원</td>
				</tr>
			</table>
			<table  id="high" style="display:'';">
				<tr>
					<td>학교명</td>
					<td><input type="text" id="high_name" name="high_name"></td>
				</tr>
				<tr>
					<td>학교 소재지</td>
					<td><select id="high_location" name = "high_location">
							<option>강원도</option>
							<option>경기도</option>
							<option>경상남도</option>
							<option>경상북도</option>
							<option>광주광역시</option>
							<option>대구광역시</option>
							<option>대전광역시</option>
							<option>부산광역시</option>
							<option>서울특별시</option>
							<option>세종특별자치시</option>
							<option>울산광역시</option>
							<option>인천광역시</option>
							<option>전라남도</option>
							<option>전라북도</option>
							<option>제주특별자치시도</option>
							<option>충청남도</option>
							<option>충청북도</option>
					</select></td>
				</tr>
				<tr>
					<td>계열</td>
					<td><select id="high_division" name="high_division">
							<option>인문계</option>
							<option>공업</option>
							<option>과학</option>
							<option>농업</option>
							<option>마이스터</option>
							<option>상업</option>
							<option>예술</option>
							<option>외국어</option>
							<option>체육</option>
							<option>특성화</option>
							<option>기타</option>
					</select></td>
				</tr>
				<tr>
					<td>입학일자</td>
					<td><input type="text" id="high_e_date" name="high_e_date" placeholder="0000-00-00">
					<script>
						$(function(){
							$("#high_e_date").datepicker({dateFormat: "yy-mm-dd"});
						});
					</script></td>
				</tr>
				<tr>
					<td>졸업일자</td>
					<td><input type="text" id="high_g_date" name="high_g_date" placeholder="0000-00-00">
					<script>
						$(function(){
							$("#high_g_date").datepicker({dateFormat: "yy-mm-dd"});
						});
					</script></td>
				</tr>
				<tr>
					<td>졸업여부</td>
					<td><select id="high_g_state" name = "high_g_state">
							<option>졸업</option>
							<option>졸업예정</option>
							<option>중퇴</option>
							<option>휴학</option>
							<option>재학</option>
					</select></td>
				</tr>
				<tr>
					<td>메모</td>
					<td><textarea id="high_memo" name="high_memo" rows="3" cols="50"></textarea></td>
				</tr>
				<tr align="right">
					<td colspan="2"><input type="button" id="confirm" class="button_css"
						value="확인">
					</td>
				</tr>
			</table>
			
			<table  id="collage" style="display:none;">
			<tr>
					<td>학교명</td>
					<td><input type="text" id="collage_name" name="collage_name"></td>
				</tr>
				<tr>
					<td>학교 소재지</td>
					<td><select id="collage_location" name = "collage_location">
							<option>강원도</option>
							<option>경기도</option>
							<option>경상남도</option>
							<option>경상북도</option>
							<option>광주광역시</option>
							<option>대구광역시</option>
							<option>대전광역시</option>
							<option>부산광역시</option>
							<option>서울특별시</option>
							<option>세종특별자치시</option>
							<option>울산광역시</option>
							<option>인천광역시</option>
							<option>전라남도</option>
							<option>전라북도</option>
							<option>제주특별자치시도</option>
							<option>충청남도</option>
							<option>충청북도</option>
					</select></td>
				</tr>
				<tr>
					<td>계열</td>
					<td><select id="collage_division" name="collage_division">
							<option>인문계열</option>
							<option>사회계열</option>
							<option>예체능계열</option>
							<option>자연과학계열</option>
							<option>공학계열</option>
							<option>농업계열</option>
							<option>의학계열</option>
							<option>기타</option>
					</select></td>
				</tr>
				<tr>
					<td>입학구분</td>
					<td><select id="collage_e_state" name = "collage_e_state">
							<option>입학</option>
							<option>편입</option>
					</select></td>
				</tr>
				<tr>
					<td>입학일자</td>
					<td><input type="text" id="collage_e_date" name="collage_e_date" placeholder="0000-00-00">
					<script>
						$(function(){
							$("#collage_e_date").datepicker({dateFormat: "yy-mm-dd"});
						});
					</script></td>
				</tr>
				<tr>
					<td>졸업일자</td>
					<td><input type="text" id="collage_g_date" name="collage_g_date" placeholder="0000-00-00">
					<script>
						$(function(){
							$("#collage_g_date").datepicker({dateFormat: "yy-mm-dd"});
						});
					</script></td>
				</tr>
				<tr>
					<td>졸업여부</td>
					<td><select id="collage_g_state" name = "collage_g_state">
							<option>졸업</option>
							<option>졸업예정</option>
							<option>중퇴</option>
							<option>휴학</option>
							<option>재학</option>
					</select></td>
				</tr>
				<tr>
					<td>전공</td>
					<td><input type="text" id="collage_major" name="collage_major"></td>
				</tr>
				<tr>
					<td>학점</td>
					<td><input type="text" id="collage_grade" name="collage_grade"> / <select id="collage_total_grade" name = "collage_total_grade">
							<option>4.0</option>
							<option>4.3</option>
							<option>4.5</option>
							<option>5.0</option>
							<option>7.0</option>
							<option>100</option>
					</select></td>
				</tr>
				<tr>
					<td>전공학점</td>
					<td><input type="text" id="collage_major_grade" name="collage_major_grade"> / <select id="collage_total_grade" name = "collage_total_grade">
							<option>4.0</option>
							<option>4.3</option>
							<option>4.5</option>
							<option>5.0</option>
							<option>7.0</option>
							<option>100</option>
					</select></td>
				</tr>
				<tr>
					<td>이수학점</td>
					<td><input type="text" id="collage_classes" name="collage_classes"></td>
				</tr>
				<tr>
					<td>부전공/ 복수전공 명</td>
					<td><input type="text" id="collage_submajor" name="collage_submajor"></td>
				</tr>
				<tr>
					<td>메모</td>
					<td><textarea id="collage_memo" name="collage_memo" rows="3" cols="50"></textarea></td>
				</tr>
				<tr align="right">
					<td colspan="2"><input type="button" id="confirm1" class="button_css"
						value="확인">
					</td>
				</tr>
			</table>
			
			<table  id="graduated" style="display:none;">
				<tr>
					<td>학교명</td>
					<td><input type="text" id="graduated_name" name="graduated_name"></td>
				</tr>
				<tr>
					<td>학교 소재지</td>
					<td><select id="graduated_location" name = "graduated_location">
							<option>강원도</option>
							<option>경기도</option>
							<option>경상남도</option>
							<option>경상북도</option>
							<option>광주광역시</option>
							<option>대구광역시</option>
							<option>대전광역시</option>
							<option>부산광역시</option>
							<option>서울특별시</option>
							<option>세종특별자치시</option>
							<option>울산광역시</option>
							<option>인천광역시</option>
							<option>전라남도</option>
							<option>전라북도</option>
							<option>제주특별자치시도</option>
							<option>충청남도</option>
							<option>충청북도</option>
					</select></td>
				</tr>
				<tr>
					<td>계열</td>
					<td><select id="graduated_division" name="graduated_division">
							<option>인문계열</option>
							<option>사회계열</option>
							<option>예체능계열</option>
							<option>자연과학계열</option>
							<option>공학계열</option>
							<option>농업계열</option>
							<option>의학계열</option>
							<option>기타</option>
					</select></td>
				</tr>
				<tr>
					<td>입학일자</td>
					<td><input type="text" id="graduated_e_date" name="graduated_e_date" placeholder="0000-00-00">
					<script>
						$(function(){
							$("#graduated_e_date").datepicker({dateFormat: "yy-mm-dd"});
						});
					</script></td>
				</tr>
				<tr>
					<td>졸업일자</td>
					<td><input type="text" id="graduated_g_date" name="graduated_g_date" placeholder="0000-00-00">
					<script>
						$(function(){
							$("#graduated_g_date").datepicker({dateFormat: "yy-mm-dd"});
						});
					</script></td>
				</tr>
				<tr>
					<td>졸업여부</td>
					<td><select id="graduated_g_state" name = "graduated_g_state">
							<option>졸업</option>
							<option>졸업예정</option>
							<option>중퇴</option>
							<option>휴학</option>
							<option>재학</option>
					</select></td>
				</tr>
				<tr>
					<td>전공</td>
					<td><input type="text" id="graduated_major" name="graduated_major"></td>
				</tr>
				<tr>
					<td>학점</td>
					<td><input type="text" id="graduated_grade" name="graduated_grade"> / <select id="graduated_total_grade" name = "graduated_total_grade">
							<option>4.0</option>
							<option>4.3</option>
							<option>4.5</option>
							<option>5.0</option>
							<option>7.0</option>
							<option>100</option>
					</select></td>
				</tr>
				<tr>
					<td>메모</td>
					<td><textarea id="graduated_memo" name="graduated_memo" rows="3" cols="50"></textarea></td>
				</tr>
				<tr align = "right">
					<td colspan="2"><input type="button" id="confirm2" class="button_css"
						value="확인">
					</td>
				</tr>
			</table>
		</fieldset>
	</form>
	
</body>
</html>
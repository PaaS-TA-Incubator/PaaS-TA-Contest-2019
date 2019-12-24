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
<title>어학/자격증</title>
<script>

	function Rradio_OnOff(id){
		if(id == "Radio_On"){
			document.all["Radio_On"].style.display = '';
			document.all["Radio_Off"].style.display = "none";
		}else{
			document.all["Radio_On"].style.display = "none";
			document.all["Radio_Off"].style.display = '';
		}
		
	}
	window.addEventListener('load', function() {
		var confirm = document.querySelector('#confirm');
		
		confirm.addEventListener('click', function() {

			var radio = document.querySelectorAll('.radio');
			var language_name = document.querySelector('#language_name');
			var kind = document.querySelector('#kind');
			var application_num = document.querySelector('#application_number');
			var test_date = document.querySelector('#test_date');
			var score = document.querySelector('#score');
			var score_name = document.querySelector('#score_name');
			
			if (language_name.value == '') {
				alert('외국어명을 입력하세요.');
				language_name.focus();
			} else if (kind.value == '') {
				alert('어학 종류를 입력하세요 ')
				kind.focus();
			} else if (application_number.value == '') {
				alert('수험번호를 입력하세요 ')
				application_number.focus();
			} else if (test_date.value == '') {
				alert('응시일자를 입력하세요 ')
				test_date.focus();
			} else{
				var formData = $("#form1").serialize();
	        	 $.ajax({
	                 cache : false,
	                 enctype: 'multipart/form-data',
	                 url : "certificationAction.jsp", // 요기에
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
				var classfication_name = document.querySelector('#classfication_name');
				var issue_org = document.querySelector('#issue_org');
				var issue_date = document.querySelector('#issue_date');
				
				if (classfication_name.value == '') {
					alert('자격증명을 입력하세요.');
					classfication_name.focus();
				} else if (issue_org.value == '') {
					alert('발급 기관을 입력하세요 ')
					issue_org.focus();
				} else if (issue_date.value == '') {
					alert('취득일자를 입력하세요 ')
					issue_date.focus();
				} else{
					var formData = $("#form1").serialize();
		        	 $.ajax({
		                 cache : false,
		                 enctype: 'multipart/form-data',
		                 url : "certificationAction.jsp", // 요기에
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
	<form action="certificationAction.jsp" method="post" id = "form1">
		<fieldset class="field_info">
			<legend>어학/자격증</legend>
			<table>
				<tr>
					<td>구분</td>
					<td><input type="radio" id="radio" value="language" name="radio" onclick="Rradio_OnOff('Radio_On');" checked/> 어학
						<input type="radio" id="radio" value="classfication" name="radio" onclick="Rradio_OnOff('Radio_Off');">자격증</td>
				</tr>
			</table>
			<table  id="Radio_On" style="display:'';">
				<tr>
					<td>외국어명</td>
					<td><input type="text" id="language_name" name="language_name"></td>
				</tr>
				<tr>
					<td>어학종류</td>
					<td><input type="text" id="kind" name="kind"></td>
				</tr>
				<tr>
					<td>수험번호</td>
					<td><input type="text" id="application_number" name="application_number"></td>
				</tr>
				<tr>
					<td>응시일자</td>
					<td><input type="text" id="test_date" name="test_date" placeholder="0000-00-00">
					<script>
						$(function(){
							$("#test_date").datepicker({dateFormat: "yy-mm-dd"});
						});
					</script></td>
				</tr>
				<tr>
					<td>취득점수</td>
					<td><input type="text" id="score" name="score"></td>
				</tr>
				<tr>
					<td>취득급수</td>
					<td><input type="text"  id="score_name" name="score_name"></td>
				</tr>
				<tr align = "right">
					<td colspan="2"><input type="button" id="confirm" class="button_css"
						value="확인">
					</td>
				</tr>
			</table>
			<table  id="Radio_Off" style="display:none;">
				<tr>
					<td>자격증명</td>
					<td><input type="text" id="classfication_name" name="classfication_name"></td>
				</tr>
				<tr>
					<td>발급기관</td>
					<td><input type="text" id="issue_org" name="issue_org"></td>
				</tr>
				<tr>
					<td>취득일자</td>
					<td><input type="text" id="issue_date" name="issue_date" placeholder="0000-00-00">
					<script>
						$(function(){
							$("#issue_date").datepicker({dateFormat: "yy-mm-dd"});
						});
					</script></td>
				</tr>
				<tr align = "right">
					<td colspan="2"><input type="button" id="confirm1" class="button_css"
						value="확인">
					</td>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>
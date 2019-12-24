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
<title>수상</title>
<script>
	window.addEventListener('load', function() {
		var confirm = document.querySelector('#confirm');
		
		confirm.addEventListener('click', function() {

			var name = document.querySelector('#name');
			var org = document.querySelector('#org');
			var result = document.querySelector('#result');
			var attachment = document.querySelector('#attachment');
			var memo = document.querySelector('#memo');			
			
			// 전체 검사
			// 회사명이 입력되지 않았을시
			if (name.value == '') {
				alert('수상 명을 입력하세요.');
				name.focus();
			} else if (org.value == '') {
				alert('주최를 입력하세요 ')
				org.focus();
			} else if (result.value == '') {
				alert('결과를 입력하세요 ')
				result.focus();
			}else {
	            var formData = $("#form1").serialize().replace(/%/g, '%25');
                var form = $('#form2')[0];
           		 var formData2 = new FormData(form);
     
             $.ajax({
                  cache : false,
                  url : "awardsAction.jsp", // 요기에
                  type : 'POST',
                  data : formData,
                  async: false,
                  success : function(data) {
                 
                  }
              });
             $.ajax({
                  cache : false,
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
	Object session_object=session.getAttribute("signedUser");
	String session_name=(String)session_object;
	%>

	<form action="awardsAction.jsp" method="post" id = "form1">
		<fieldset class="field_info">
			<legend>수상내용</legend>
			<table>
				<tr>
					<td>수상 명</td>
					<td><input type="text" id="name" name="name"></td>
				</tr>
				<tr>
					<td>주최</td>
					<td><input type="text" id="org" name="org"></td>
				</tr>
				<tr>
					<td>결과</td>
					<td><input type="text" id="result" name="result"></td>
				</tr>
				<tr>
					<td>메모</td>
					<td><textarea id="memo" rows="3" name="memo" cols="50"></textarea></td>
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
               <td><input type="file" value="파일 선택" accept="image/*" id="picture" name="picture"/></td>
            </tr>

         </table>
      </form>
</body>
</html>
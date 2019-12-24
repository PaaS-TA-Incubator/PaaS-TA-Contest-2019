<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*" %>
<%@ page import="file.DBUtil" %>
<html>
<head>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.css" rel="stylesheet" id="bootstrap-css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>아이디 중복 체크</title>
	
	<style type="text/css">
		#wrap {
			width: 490px;
			text-align :center;
			margin: 0 auto 0 auto;
		}
		
		#chk{
			text-align :center;
		}
		
		#cancelBtn{
			visibility:visible;
		}
		
		#useBtn{
			 visibility:hidden;
		}

	</style>
	
	<script type="text/javascript">
	
		var httpRequest = null;
		
		// httpRequest 객체 생성
		function getXMLHttpRequest(){
			var httpRequest = null;
		
			if(window.ActiveXObject){
				try{
					httpRequest = new ActiveXObject("Msxml2.XMLHTTP");	
				} catch(e) {
					try{
						httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
					} catch (e2) { httpRequest = null; }
				}
			}
			else if(window.XMLHttpRequest){
				httpRequest = new window.XMLHttpRequest();
			}
			return httpRequest;	
		}
		
		
		// 회원가입창의 아이디 입력란의 값을 가져온다.
		function pValue(){
			document.getElementById("userId").value = opener.document.userInfo.id.value;
		}
		
		// 아이디 중복체크
		function idCheck(){

			var id = document.getElementById("userId").value;

			if (!id) {
				alert("아이디를 입력하지 않았습니다.");
				return false;
			} 
			else if((id < "0" || id > "9") && (id < "A" || id > "Z") && (id < "a" || id > "z")){ 
				alert("한글 및 특수문자는 아이디로 사용하실 수 없습니다.");
				return false;
			}
			else
			{
				  $.ajax({    //ajax함수 안에 객체의 형태로 실행명령을 넣는다. 
				         url:'id_check.jsp',  //가져오고자하는 서버페이지 주소를 넣는다.
				         type:'post',
				         data:{
		                      id: document.getElementById("userId").value,  
		               },
				  success : function(t){ 
                      if(t==0){
                    	alert("사용할수없는 아이디입니다.");
      					document.getElementById("cancelBtn").style.visibility='visible';
      					document.getElementById("useBtn").style.visibility='hidden';
      					document.getElementById("msg").innerHTML ="";
                      }
                      else{
                        document.getElementById("cancelBtn").style.visibility='hidden';
      					document.getElementById("useBtn").style.visibility='visible';
      					document.getElementById("msg").innerHTML = "사용 가능한 아이디입니다.";
                      }
        			} 
				    });   
			}
		}
		
		
		// 사용하기 클릭 시 부모창으로 값 전달 
		function sendCheckValue(){
			// 중복체크 결과인 idCheck 값을 전달한다.
			opener.document.userInfo.idDuplication.value ="idCheck";
			// 회원가입 화면의 ID입력란에 값을 전달
			opener.document.userInfo.id.value = document.getElementById("userId").value;
			
			if (opener != null) {
            	opener.chkForm = null;
            	self.close();
			}	
		}	
	</script>
	
</head>
<body onload="pValue()">
<div id="wrap">
	<br>
	<b><font size="4" color="gray">아이디 중복체크</font></b>
	<hr size="1" width="460">
	<br>
	<div id="chk">
		<form id="checkForm">
			<input type="text" name="idinput" id="userId">
			<input class="btn btn-light" type="button" value="중복확인" onclick="idCheck()">
		</form>
		<div id="msg" style="height:20;"></div>
		<br>
		<input class="btn btn-light" id="cancelBtn" type="button" value="취소" onclick="window.close()" style="position: relative;top:0"><br>
		<input class="btn btn-light" id="useBtn" type="button" value="사용하기" onclick="sendCheckValue()" style="position: relative;top:-35">
	</div>
</div>	
</body>
</html>
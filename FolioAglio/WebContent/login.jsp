<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.css" rel="stylesheet" id="bootstrap-css">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.css" rel="stylesheet" id="bootstrap-css-4.0.0">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.js"></script>

    
   <style>
.container {
    max-width: 1000px;
}
   body {
    padding-top: 50px;
}
.panel-login {
   border-color: #ccc;
   -webkit-box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.2);
   -moz-box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.2);
   box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.2);
}
.panel-login>.panel-heading {
   color: #00415d;
   background-color: #fff;
   border-color: #fff;
   text-align:center;
}
.panel-login>.panel-heading a{
   text-decoration: none;
   color: #666;
   font-weight: bold;
   font-size: 15px;
   -webkit-transition: all 0.1s linear;
   -moz-transition: all 0.1s linear;
   transition: all 0.1s linear;
}
.panel-login>.panel-heading a.active{
   color: #029f5b;
   font-size: 18px;
}
.panel-login>.panel-heading hr{
   margin-top: 10px;
   margin-bottom: 0px;
   clear: both;
   border: 0;
   height: 1px;
   background-image: -webkit-linear-gradient(left,rgba(0, 0, 0, 0),rgba(0, 0, 0, 0.15),rgba(0, 0, 0, 0));
   background-image: -moz-linear-gradient(left,rgba(0,0,0,0),rgba(0,0,0,0.15),rgba(0,0,0,0));
   background-image: -ms-linear-gradient(left,rgba(0,0,0,0),rgba(0,0,0,0.15),rgba(0,0,0,0));
   background-image: -o-linear-gradient(left,rgba(0,0,0,0),rgba(0,0,0,0.15),rgba(0,0,0,0));
}
.panel-login input[type="text"],.panel-login input[type="email"],.panel-login input[type="password"] {
   height: 45px;
   border: 1px solid #ddd;
   font-size: 16px;
   -webkit-transition: all 0.1s linear;
   -moz-transition: all 0.1s linear;
   transition: all 0.1s linear;
}
.panel-login input:hover,
.panel-login input:focus {
   outline:none;
   -webkit-box-shadow: none;
   -moz-box-shadow: none;
   box-shadow: none;
   border-color: #ccc;
}
.btn-login {
   background-color: #59B2E0;
   outline: none;
   color: #fff;
   font-size: 14px;
   height: auto;
   font-weight: normal;
   padding: 14px 0;
   text-transform: uppercase;
   border-color: #59B2E6;
}
.btn-login:hover,
.btn-login:focus {
   color: #fff;
   background-color: #53A3CD;
   border-color: #53A3CD;
}
.forgot-password {
   text-decoration: underline;
   color: #888;
}
.forgot-password:hover,
.forgot-password:focus {
   text-decoration: underline;
   color: #666;
}
.btn-register {
   background-color: #1CB94E;
   outline: none;
   color: #fff;
   font-size: 14px;
   height: auto;
   font-weight: normal;
   padding: 14px 0;
   text-transform: uppercase;
   border-color: #1CB94A;
}
.btn-register:hover,
.btn-register:focus {
   color: #fff;
   background-color: #1CA347;
   border-color: #1CA347;
}
.form__answer {
	display: inline-block;
	box-sizing: border-box;
	width: 23%;
	margin: -45px 1% 35px 0;
	height: 140px;
	vertical-align: top;
	font-size: 17px;
	text-align: center; 
}
.label123 {
	border: 1px solid #c9c9c9;
	box-sizing: border-box;
	display: block;
	height: 100%;
	width: 100%;
	padding: 10px 10px 30px 10px;
	cursor: pointer;
	opacity: .5;
	transition: all .5s ease-in-out;
	&:hover {
		border: 1px solid #AB321A;
	}
}
.form__button {
	height: 40px;
	border: none;
	background-color: $submit-color;
	color: $font-color;
	text-transform: uppercase;
	font-family: 'Source Sans Pro', sans-serif;
	padding: 0 20px;
	border-radius: 20px;
	font-weight: 900;
	cursor: pointer;
	margin: 40px 0;
	transition: all .25s ease-in-out;
	&:hover, &:focus {
		background-color: $submit-color-darker;
		text-shadow: 1px 1px 1px rgba(0,0,0,.25);
		outline: none;
	}
}
input[type="radio"] {
	opacity: 0;
	width: 0;
  height: 0;
}
input[type="radio"]:active ~ label {
  opacity: 1;
}
input[type="radio"]:checked ~ label {
  opacity: 1;
	border: 1px solid #000000;
}
h1, h2 {
    display: inline;
}
   </style>
<meta charset="utf-8">
<title>로그인</title>

    <script type="text/javascript">
    
        // 필수 입력정보인 아이디, 비밀번호가 입력되었는지 확인하는 함수
        function checkValue()
        {
        	if(!document.userInfo.username.value){
                alert("이름를 입력하세요.");
                return false;
            }
        	
        	if(!document.userInfo.email.value){
                alert("이메일을 입력하세요.");
                return false;
            }
        	
        	if(!document.userInfo.call_num.value){
                alert("전화번호를 입력하세요.");
                return false;
            }
        	
        	if(!document.userInfo.call_num.value){
                alert("전화번호를 입력하세요.");
                return false;
            }
        	
            if(!document.userInfo.id.value){
                alert("아이디를 입력하세요.");
                return false;
            }
            
            if(document.userInfo.idDuplication.value !="idCheck"){
                alert("아이디 중복체크를 해주세요.");
                return false;
            }
            
            if(!document.userInfo.pwd.value){
                alert("비밀번호를 입력하세요.");
                return false;
            }
            
            // 비밀번호와 비밀번호 확인에 입력된 값이 동일한지 확인
            if(document.userInfo.pwd.value != document.userInfo.pwdcheck.value ){
                alert("비밀번호를 동일하게 입력하세요.");
                return false;
            }
        }
        
        function openIdChk(){
        	window.name="parentForm";
        	window.open("IdCheckForm.jsp","chkForm","width=500,height=300,resizable=no,scrollbars=no");
        }
        
        function inputIdChk(){
        	document.userInfo.idDuplication.value="idUncheck";
        }
    </script>

</head>
<body>
<div class="text-center" style="margin-bottom:30px;">
	<img src="image/name.png" width = "450" height="150">
</div>
<div class="container">
       <div class="row">
         <div class="col-md-6 col-md-offset-3">
            <div class="panel panel-login">
               <div class="panel-heading">
                  <div class="row">
                     <div class="col-xs-6">
                        <a href="#" class="active" id="login-form-link">Login</a>
                     </div>
                     <div class="col-xs-6">
                        <a href="#" id="register-form-link">Register</a>
                     </div>
                  </div>
                  <hr>
               </div>
               <div class="panel-body">
                  <div class="row">
                     <div class="col-lg-12">
                        <form id="login-form" action="authentication.jsp"style="display: block;">
                           <div class="form-group">
                              <input class="form-control" name="id" type="text" placeholder="ID" tabindex="1" class="form-control">
                           </div>
                           <div class="form-group">
                              <input class="form-control" name="pw" type="password" placeholder="PassWord" tabindex="2" class="form-control">
                           </div>
                           <div class="form-group">
                              <div class="row">
                                 <div class="col-sm-6 col-sm-offset-3">
                                    <input type="submit" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-login" value="Log In">
                                 </div>
                              </div>
                           </div>
                           <div class="form-group">
                              <div class="row">
                                 <div class="col-lg-12">
                                    <div class="text-center">
                                       <a href="findpw.jsp" onclick="window.open(this.href,'','width=400,height=300,resizable=no,scrollbars=no');return false;" target="_blank" tabindex="5" class="forgot-password">Forgot Password?</a>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </form>
                        <form id="register-form" method="post" action="signup.jsp" name="userInfo" onsubmit="return checkValue()" role="form" style="display: none;">
                           			
                           			<div class="text-center">
		                          <p class="form__answer"> 
						<input type="radio" name="sex" id="match_1" value="남" checked> 
						<label for="match_1" class="label123">
							<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
							<title>Icon Guy</title>
							<g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
							<g id="Guy" stroke="#000000" stroke-width="2">
							<path d="M50,89 C28.4608948,89 11,71.5391052 11,50 C11,28.702089 28.8012779,11 50,11 C71.3811739,11 89,28.8647602 89,50 C89,71.5391052 71.5391052,89 50,89 Z" id="Oval"></path>
							<path d="M34.5,59 C32.0147186,59 30,56.9852814 30,54.5 C30,53.1996039 30.5532818,51.9907899 31.5049437,51.1414086 C32.3241732,50.4102265 33.3788668,50 34.5,50 C36.9852814,50 39,52.0147186 39,54.5 C39,56.9852814 36.9852814,59 34.5,59 Z" id="eye"></path>
							<path d="M65,59 C62.790861,59 61,57.209139 61,55 C61,53.844 61.4917357,52.7696523 62.3377558,52.0145589 C63.0660084,51.3645758 64.0033341,51 65,51 C67.209139,51 69,52.790861 69,55 C69,57.209139 67.209139,59 65,59 Z" id="eye"></path>
							<path d="M13,39 C13,39 18.3404984,39.6508711 28,35 C37.6595016,30.3491289 40,26 40,26 C40,26 50.99493,36.4771587 58,38 C65.00507,39.5228413 75,42 86,36" id="Path-9"></path>
							<path d="M40.0417765,73.6204199 C43.0857241,74.4024099 46.5428621,75 50,75 C53.4660267,75 57.0521869,74.3993329 60.2588177,73.6143844" id="Path-8"></path>
							</g>
							</g>
							</svg>
								Guy
							</label> 
						</p>	
						
						<p class="form__answer"> 
							<input type="radio" name="sex" id="match_2" value="여"> 
							<label for="match_2" class="label123">
								<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
						    <title>Icon Girl</title>
						    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
						        <g id="Girl" stroke="#000000" stroke-width="2">
						            <path d="M34.5,59 C32.0147186,59 30,56.9852814 30,54.5 C30,53.1996039 30.5532818,51.9907899 31.5049437,51.1414086 C32.3241732,50.4102265 33.3788668,50 34.5,50 C36.9852814,50 39,52.0147186 39,54.5 C39,56.9852814 36.9852814,59 34.5,59 Z" id="eye"></path>
						            <path d="M65,59 C62.790861,59 61,57.209139 61,55 C61,53.844 61.4917357,52.7696523 62.3377558,52.0145589 C63.0660084,51.3645758 64.0033341,51 65,51 C67.209139,51 69,52.790861 69,55 C69,57.209139 67.209139,59 65,59 Z" id="eye"></path>
						            <path d="M40.0417765,73.6204199 C43.0857241,74.4024099 46.5428621,75 50,75 C53.4660267,75 57.0521869,74.3993329 60.2588177,73.6143844" id="Path-8"></path>
						            <path d="M89,85.7475102 C88.8955878,85.9344664 88.7467384,86.1876581 88.5568273,86.4896509 C88.099056,87.2175897 87.5756991,87.9455147 86.9988116,88.620918 C86.4739467,89.2354147 85.9304177,89.775041 85.375305,90.2191312 C84.8658937,90.6266602 84.2662576,91.0180436 83.595144,91.3893912 C82.7730663,91.8442719 81.887807,92.2460964 81,92.5896591 L81,40 L81,38.8469903 L79.8585786,39.0100505 C79.6614656,39.0382095 79.2577272,39.0826578 78.6591173,39.1278359 C74.3930423,39.4498038 68.7942651,39.2189264 62.1788854,38.0161301 C57.0399578,37.0817796 52.3111466,34.9372575 48.0532571,31.9450012 C45.9977761,30.5005001 44.1879399,28.9525501 42.6417908,27.4063877 C42.1025143,26.8671065 41.6354717,26.3675518 41.2428426,25.9209461 C41.0110166,25.65725 40.857774,25.472798 40.7852536,25.3808257 L40.0214746,24.4121805 L39.2317787,25.3598156 C39.1671043,25.4374249 39.0389509,25.5878658 38.8531645,25.8006757 C38.5410991,26.1581324 38.1830018,26.5571551 37.7847578,26.9872586 C36.6466602,28.2164041 35.4176003,29.445464 34.1458501,30.5900392 C32.5231664,32.0504545 30.951344,33.2630032 29.4855042,34.1425071 C29.0304384,34.4155466 28.5310795,34.7026476 27.9916336,35.002074 C27.4450358,35.3054703 26.8605908,35.6196896 26.2435123,35.9426764 C24.8349714,36.6799246 23.3234177,37.4285751 21.8115464,38.1490329 C21.2821626,38.4013022 20.7906968,38.6319577 20.3498881,38.8361138 C20.0860774,38.958295 19.8982917,39.04426 19.7992478,39.0891363 L19.211955,39.3552353 L19.211955,40 L19.211955,92.7152178 C19.1364886,92.6917076 19.0597241,92.667071 18.9817486,92.6412798 C17.9021752,92.2841999 16.8226398,91.7852694 15.8208322,91.1247895 C15.4101539,90.8540341 15.0203834,90.5606598 14.6544853,90.2439252 C14.1170024,89.7786609 13.5401931,89.1607001 12.9460031,88.4291975 C12.4227493,87.7850238 11.9163214,87.0910824 11.4478335,86.3968037 C11.2837801,86.1536836 11.1364341,85.928256 11.0082743,85.7265874 C11.0054836,85.7221962 11.0027255,85.7178532 11,85.713559 C11,85.0832089 11,84.7118308 11,81.6747405 C11,77.349481 11,77.349481 11,72.1591696 C11,71.5103806 11,71.5103806 11,70.8632812 C11,64.359375 11,64.359375 11,60 C11,52.5915787 11.1864157,47.4651466 11.4954955,44.2198091 C11.6016611,43.1050696 11.7139336,42.3079355 11.8230104,41.7807306 C11.8772398,41.5186217 11.907738,41.4205921 11.8944272,41.4472136 L11.8944272,41.4472136 L11.9531333,41.3298014 L11.979547,41.2012154 C11.9897736,41.151431 12.0134457,41.0449892 12.0517573,40.8856927 C12.1171311,40.6138739 12.199539,40.2967548 12.3001685,39.9381396 C12.5895905,38.9067215 12.9661965,37.7545848 13.4393808,36.5121684 C14.7929142,32.9582632 16.645561,29.4037594 19.0699875,26.0905275 C25.9786458,16.6491245 36.058878,11 50,11 C63.9680262,11 73.8677356,15.9210538 80.4573453,24.1261723 C82.7631629,26.9972841 84.4914427,30.0758538 85.7229878,33.1528363 C86.1530722,34.2273906 86.4899505,35.2232906 86.743943,36.1140543 C86.8941528,36.6408474 86.9824164,37.0099991 87.0191959,37.1949955 C87.0506645,37.3173809 87.0767576,37.4156648 87.1148011,37.570556 C87.1802255,37.836927 87.25369,38.161866 87.3332396,38.5463556 C87.562761,39.6557092 87.7931539,41.0150273 88.0087721,42.6321637 C88.6278466,47.2752226 89,53.0436001 89,60 L89,85.7475102 Z" id="Path-9"></path>
						            <path d="M19,75 C19,75 30,90 50,90 C70,90 81,75 81,75" id="Path-10"></path>
								        </g>
								    </g>
								</svg>
										Girl
								</label> 
							</p>
							
							</div>
                           <div class="form-group">
                              <input type="text" name="username" id="username" tabindex="1" class="form-control" placeholder="Username" value="">
                           </div>
                           <div class="form-group">
                              <input type="email" name="email" id="email" tabindex="1" class="form-control" placeholder="Email Address" value="">
                           </div>
                           <div class="form-group">
                              <input type="text" name="call_num" id="call_num" tabindex="1" class="form-control" placeholder="call_num" value="">
                           </div>
                           <div class="form-group">
                           <select name="birthyy" class="custom-select custom-select-lg" style="width:33%;height:45px;;">
                           		<option value="">년</option>
                           		<% for(int i=1940;i<=2018;i++){ %>
                           			<option value=<%=i %>><%=i %></option>
                           		<%} %>
                           </select>
	                       <select name="birthmm" class="custom-select custom-select-lg" style="width:32%;height:45px;">
		                            <option value="">월</option>
		                            <% for(int i=1;i<=12;i++){ %>
	                           			<option value=<%=i %>><%=i %></option>
	                           		<%} %>
	                       </select>
	                       <select name="birthdd" class="custom-select custom-select-lg" style="width:33%;height:45px;">
		                            <option value="">일</option>
		                            <% for(int i=1;i<=31;i++){ %>
	                           			<option value=<%=i %>><%=i %></option>
	                           		<%} %>
	                       </select>
							</div>

                           <div class="form-group">
	                              <input type="text" name="id" id="id" tabindex="1" class="form-control" placeholder="ID" value="" onkeydown="inputIdChk()" style="width:80%;display:inline;">
								  <input type="button" value="중복확인" onclick="openIdChk()" class="btn btn-info" style="font-size: 1.3rem;width:18%;height:45px;margin-left:5px;">
								  <input type="hidden" id = "idDuplication" name="idDuplication" value="idUncheck">
							  </div>

                           <div class="form-group">
                              <input type="password" name="pwd" id="pwd" tabindex="2" class="form-control" placeholder="Password">
                           </div>
                           <div class="form-group">
                              <input type="password" name="pwdcheck" id="pwdcheck" tabindex="2" class="form-control" placeholder="Confirm Password">
                           </div>
                           <div class="form-group">
                              <div class="row">
                                 <div class="col-sm-6 col-sm-offset-3">
                                    <input type="submit" name="register-submit" id="register-submit" tabindex="4" class="form-control btn btn-register" value="Register Now">
                                 </div>
                              </div>
                           </div>
                        </form>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</body>

<script>
$(function() {
    $('#login-form-link').click(function(e) {
      $("#login-form").delay(100).fadeIn(100);	
       $("#register-form").fadeOut(100);
      $('#register-form-link').removeClass('active');
      $(this).addClass('active');
      e.preventDefault();
   });
   $('#register-form-link').click(function(e) {
      $("#register-form").delay(100).fadeIn(100);
       $("#login-form").fadeOut(100);
      $('#login-form-link').removeClass('active');
      $(this).addClass('active');
      e.preventDefault();
   });
});
</script>
</html>

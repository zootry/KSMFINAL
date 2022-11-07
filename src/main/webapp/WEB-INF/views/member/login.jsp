<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
    <title>Pet Care</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">   
    <link href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> 
    <link rel="stylesheet" href="/css/animate.css">    
    <link rel="stylesheet" href="/css/owl.carousel.min.css">
    <link rel="stylesheet" href="/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="/css/magnific-popup.css">
    <link rel="stylesheet" href="/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="/css/jquery.timepicker.css">
    <link rel="stylesheet" href="/css/flaticon.css">
    <link rel="stylesheet" href="/css/style.css">   
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
    <script src="/js/jquery.min.js"></script>
    <script type="text/javascript" language="javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
    <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
    <script>
    	var id;
    	var pwd;  	
    	var logincheck = "${loginStat}";
    	var $resultMsg;
    	$(function(){
    		$('#id').focus();
    		var form = $('form#loginForm');
    		if(logincheck == "lf"){
				alert('비밀번호가 옳지 않습니다');
			}else if(logincheck == "err"){
				alert('계정이 존재 하지 않습니다');
			}
    		$(form).submit(function(e){
    			id = $('#id').val();
    			pwd = $('#pwd').val();
    			
    			if(id == ''){
    				alert('아이디를 입력해주세요');
    				$('#id').focus();
    				return false;
    			}
    			if(pwd == ''){
    				alert('비밀번호를 입력해주세요');
    				$('#pwd').focus();
    				return false;
    			}
    			
    			$.ajax({
    				type : 'POST',
    				url : $(form).attr('action'),
    				data : {
    					id : id,
    					pwd : pwd
    				}
    			});
    		});    
    		$('#findpwd').click(function(){
    			var html = "";
    			html += '<div class="col-md-5">';
    			html += '<div class="contact-wrap w-100 p-md-5 p-4 shadow rounded" id="pwdBox"><div class="d-flex justify-content-between"><h3 class="mb-4">비밀번호 찾기</h3><button type="button" class="mb-4 close-btn btn btn-primary" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>';
        		html += '<div class="row"><div class="col-md-12"><div class="form-group">';
        		html += '<input type="text" class="form-control" name="id" id="checkid" placeholder="E-Mail"></div></div><div class="col-md-12"><div class="form-group">';
        		html += '<input type="text" class="form-control" name="id" id="checkphone" placeholder="phone"></div></div><br>';
        		html += '<div class="col-md-12"><div class="form-group"><br><span id="resultpwd">메일이 도착하면 팝업창이 뜹니다</span>';
        		html += '<input type="submit" value="find" class="btn btn-primary float-right" id="findpwd-Btn"></div></div></div></div>';
        		html += '</div>';
        		$resultMsg = $('#resultpwd');
        		$("#content").append(html);
        	});
        	$(document).on("click", ".close-btn", function(){
        		var html = "";
        		$(".col-md-5").remove();
        	});        	
        	$(document).on("click", "#findpwd-Btn", function(){
        		var checkid = $('#checkid').val();
        		var checkphone = $('#checkphone').val();
        		$.ajax({
        			type : 'POST',
    				url : "/member/resetPwd",
    				data : {
    					email : checkid,
    					phone : checkphone
    				},
    				success : function(data){
    					if(data == "wp"){
							alert("전화번호가 일치하지않습니다.");
    					}else if(data == "err"){
    						alert("그런 아이디는 없습니다.");
    					}else{ 						
							alert("이메일로 임시 비밀번호가 발급되었습니다.");
    					}
    				}
        		});
        	});
    	});    	
    </script>
	<style>
		@media only screen and (max-width: 600px) {
		div #pwdBox {
		    margin-top:10px;
		  }
		}
		@supports (display: flex) {
		  @media screen and (min-width: 600px) {
		    div #pwdBox {
		    margin-left:10px;
		  }
		}
		
		section {
			height: 100vh;
			background: linear-gradient(to bottom right, #97a3ea 20%, #a091f3 60%, #9283f2 90%) no-repeat;
		}
	</style>    
  </head>
  <body>    
    <section class="ftco-section">
		<div class="container">
			<div class="row d-flex justify-content-center" id="content">
							<div class="col-md-6">
								<div class="contact-wrap w-100 p-md-5 p-4 shadow rounded">
									<h3 class="mb-4">로그인</h3>
									<form action="loginCheck.do" method="POST" id="loginForm" name="loginForm" class="contactForm">
										<div class="row">
											<div class="col-md-6">
											</div>
											<div class="col-md-12">
												<div class="form-group">
													<label class="label" for="subject">ID</label>
													<input type="text" class="form-control" name="id" id="id" placeholder="E-Mail">
												</div>
											</div>
											<div class="col-md-12">
												<div class="form-group">
													<label class="label" for="password">Password</label>
													<input type="password" class="form-control" name="pwd" id="pwd" placeholder="password">
												</div>
											</div><br>
											<div class="col-md-12 d-flex justify-content-center">
												<div class="form-group"><br>
													<input type="submit" value="Login" class="btn btn-primary" id='login-Btn'>
													<div class="submitting"></div>
												</div>
											</div>
						                      <div class="col-md-12 d-flex justify-content-center"><br>
						                      <span><a href="goSignupM.do">회원가입</a></span>	&nbsp;&nbsp;|&nbsp;&nbsp;		                        
						                      <span><a href="#" id="findpwd">비밀번호 찾기</a></span>
						                        						                        
						                      </div>
						                    										
										</div>
									</form>
								</div>
							</div>
		</div>
    </div>
    </section>      
  
  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

  <script src="/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="/js/popper.min.js"></script>
  <script src="/js/bootstrap.min.js"></script>
  <script src="/js/jquery.easing.1.3.js"></script>
  <script src="/js/jquery.waypoints.min.js"></script>
  <script src="/js/jquery.stellar.min.js"></script>
  <script src="/js/jquery.animateNumber.min.js"></script>
  <script src="/js/owl.carousel.min.js"></script>
  <script src="/js/jquery.magnific-popup.min.js"></script>
  <script src="/js/scrollax.min.js"></script>
  <script src="/js/main.js"></script>
    
  </body>
</html>
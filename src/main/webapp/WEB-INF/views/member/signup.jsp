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
	<style>
	section {
		height: 100%;
		background: linear-gradient(to bottom right, #97a3ea 20%, #a091f3 60%, #9283f2 90%) no-repeat;
	}
	label.bi.bi-check {
		color: #a091f3;
	}
	</style>
    <script src="/js/jquery.min.js"></script>
    <script type="text/javascript" language="javascript" 
		     src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js">
    </script>
    <script>
	    var email; 
		var inputCode;
	    var pwd;   
	    var pwdCheck;
	    var nickname;
	    var name;
	    var agree;
	    var phone;
	    var gender;
	    
	    var selectedImages = [];
		var imgNum = 0;
	    $(function(){
	    	
	    	$("#userphoto").on("change", function(e){
				$("#imageList").empty();
				var images = e.target.files;
				imageArr = Array.prototype.slice.call(images); 
				preview(imageArr);
			});
	    	
	    	var $resultMsg1 = $('#mail-check-warn');
	    	$('#userEmail1').focus();
	    	$('#mail-Check-Btn').click(function() {
	    		var regExpEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*$/;
		    	email = $('#userEmail1').val();
		    	if(email == ''){
		    		alert('이메일을 입력해주세요.');
		    		return false;
		    	}else if(!regExpEmail.test($('#userEmail1').val())){
		    		alert('이메일은 영어와 숫자로만 이루어져있습니다.');
		    		return false;
		    	}
		    	email += $('#userEmail2').val();
		    	$.ajax({
		    		url: 'emailCheck.do',
		    		type: 'post',
		    		data: {email: email},
		    		async: false,
		    		success: function(data){
		    			if(data == "T"){
		    				$resultMsg1.html('중복된 이메일입니다');
							$resultMsg1.css('color','red');
							return false;
		    			}else{ 
		    				var checkInput = $('.mail-check-input'); 
		    				alert('인증번호가 전송되었습니다.');
		    				$resultMsg1.html('인증메일 가는중...');
		    				$resultMsg1.css('color','black');
		    				
		    				$.ajax({
		    					type : 'get',
		    					url :  '<c:url value ="/member/mailCheck?email="/>'+email,
		    					success : function (data) {
		    						checkInput.attr('disabled',false);
		    						code = data;
		    						$('#mail-check-input').focus();
		    						$resultMsg1.html('↑ 인증번호를 입력해주세요');
		    						$resultMsg1.css('color','blue');
		    					}			
		    				});
		    			}
		    		}	    		
		    	});
	    	});
		 		
			$('#mail-check-input').keyup(function(){	
				inputCode = $('#mail-check-input').val();
				if(inputCode.length === 6){
					if(inputCode === code && inputCode.length === 6){
						$resultMsg1.html('인증번호가 일치합니다.');
						$resultMsg1.css('color','green');
						$('#userEmail2').attr('onFocus', 'this.initialSelect = this.selectedIndex');
				        $('#userEmail2').attr('onChange', 'this.selectedIndex = this.initialSelect');
				        $('#pwd').focus();
				        return true;
					}else{
						$resultMsg1.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
						$resultMsg1.css('color','red');
						return false;		
					}
				}
			});
			
			var $resultMsg2 = $('#pwd-check-warn');
			$('#pwdCheck').keyup(function(){			
				$resultMsg2.html('비밀번호 확인란에 입력해주세요 →');
				pwd = $('#pwd').val();
				pwdCheck = $('#pwdCheck').val();
				if(8<=pwd.length && pwd.length<=16){
					if(pwd.length === pwdCheck.length){
						if(pwd != pwdCheck){
							$resultMsg2.html('비밀번호가 일치하지않습니다.');
							$resultMsg2.css('color','red');
					        return false;
						}else if(pwd.includes(' ')){
							$resultMsg2.html('공백은 포함될 수 없습니다.');
							$resultMsg2.css('color','red');
							return false;
						}else{
							$resultMsg2.html('비밀번호가 일치합니다.');
							$resultMsg2.css('color','green');
							$('#nickname').focus();
					        return false;
						}
					}
				}else{
					$resultMsg2.html('비밀번호는 8~16자로 정해주세요');
					$resultMsg2.css('color','red');
					return false;
				}
			});
			
			var $resultMsg3 = $('#nick-check-warn');
			$('#nickname').keyup(function(){
				$resultMsg3.html('');
				nickname = $('#nickname').val();
				if(nickname != null){
					if(15<nickname.length){
						$resultMsg3.html('닉네임은 15자 이내로 정해주세요');
						$resultMsg3.css('color','red');
						return false;
					}else if(nickname.includes(' ')){
						$resultMsg3.html('공백은 포함될수 없습니다');
						$resultMsg3.css('color','red');
						return false;
					}
				}
				$.ajax({
		    		url: 'nickCheck.do',
		    		type: 'post',
		    		data: {nick: nickname},
		    		success: function(data){
		    			console.log("data: "+data);
		    			if(data == "T"){
		    				$resultMsg3.html('중복된 닉네임입니다');
							$resultMsg3.css('color','red');
							return false;
		    			}
		    		}	    		
		    	});
			});						
	    });		
	    function preview(imageArr){
			var html = "";
			imageArr.forEach(function(i, idx){
				if(i.type.match('image.*')){
					var reader = new FileReader();
					selectedImages.push(i);
					reader.onload = function(e){
						html += "<img src='"+e.target.result+"' title='"+i.name+"' class='col p-3' style='width:10rem; height:10rem; border-radius:1.2rem !important' onclick='deleteClick(this,"+imgNum+");'>";
						$("#imageList").html(html);
						imgNum ++;
					}
					reader.readAsDataURL(i);
				}else{}
			});
			$("#userphoto").val(""); 
		}
	    function uploadClick(){
			$("#userphoto").click();
		}
		function deleteClick(imgObj, i){
			selectedImages.splice(i,1);
			$(imgObj).remove();
		}
		
		function submit(){
			
			var formdata = new FormData();
			
			for(var i=0; i<selectedImages.length; i++){
	    		if(selectedImages[i] != undefined){
	    			formdata.append("multipartFiles", selectedImages[i]);
	    		}
	    	}
			
			if(inputCode == null){
				alert('이메일 인증을 받아야합니다');
				$('#userEmail1').focus();
				return false;
			}
			if(pwdCheck == null){
				alert('비밀번호를 기입해주세요');
				$('#pwd').focus();
				return false;
			}
			if(nickname == ''){
				alert('닉네임을 기입해주세요');
				$('#nickname').focus();
				return false;
			}
			agree = $("input[name='agree']:checked").val();;
			if(agree == 'N'){
				alert('약관에 동의해야 가입가능합니다');
				$('#agree').focus();
				return false;
			}			
						
			var phone2 = $('#phone2').val();
			var phone3 = $('#phone3').val();
			var regExpPhone = /[0-9]*$/;
			if(phone2 != "" && phone3 != ""){
				if(regExpPhone.test(phone2) && regExpPhone.test(phone3)){
					if((phone2.length == 3 || phone2.length == 4) && phone3.length == 4){
						phone = $('#phone1').val()+phone2+phone3;
					}else{
						alert('길이를 맞춰 작성해주세요');
						return false;
					}
				}else{
					alert('전화번호에는 숫자만 써주세요');
					return false;	
				}
			}else{				
				alert('전화번호를 입력해주세요');
				return false;
			}						
			
			gender = $("input[name='gender']:checked").val();
			if(typeof(gender) == "undefined"){
				gender = "";
			}
			
			var regName = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
			name = $("#name").val();
			if(name != null){
				if(regName.test($("#name").val())){
					if(name.length<8){
						
					}else{
						alert('이름이 너무 깁니다.');
						$('#name').focus();
						return false;
					}
				}else{
					alert('이름은 한글만 입력가능합니다.');
					$('#name').focus();
					return false;
				}
			}else{
				alert('이름을 꼭 기입해주세요.');
				$('#name').focus();
				return false;
			}
			
			
			formdata.append("email", email);
			formdata.append("pwd", pwdCheck);
			formdata.append("nickname", nickname);
			formdata.append("agree", agree);
			formdata.append("phone", phone);
			formdata.append("gender", gender);
			formdata.append("name", name);	
			
			$.ajax({
				type : 'POST',
				url : "/member/signup.do",
				data : formdata,
				processData : false,
				contentType: false,
				success : function(){
					alert('회원가입 되었습니다.');
					location.href = '/member/login.do';
				}
			});
		}
    </script>    
  </head>
  <body>
    
    <section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-12">
					<div class="wrapper">
						<div class="row justify-content-center">
							<div class="col-md-6">
								<div class="contact-wrap w-100 p-md-5 p-4 shadow rounded">
									<h3 class="mb-4">#회원가입</h3>								
									<div class="row">
										<div class="col-md-12">
											<label class="bi bi-check"><small>표시는 필수정보 입력입니다. 필수정보는 모두 작성해주세요.</small></label>
										</div>						
                      					<div class="col-md-12">
											<div class="form-group">
												<div class="mb-2">
												 <label class="label bi bi-check" for="email">EMAIL</label>
													<div>
														<div class="input-group d-flex justify-content-between">
															<div class="d-flex justify-content-between">
																<input type="text" class="form-control" name="userEmail1" id="userEmail1" placeholder="E-Mail"> 
																<select class="form-control" name="userEmail2" id="userEmail2">
																	<option>@example.com</option>
																	<option>@naver.com</option>
																	<option>@daum.net</option>
																	<option>@gmail.com</option>
																	<option>@nate.com</option>
																</select>
															</div>
															<div class="d-flex input-group-addon">
																<button type="button" class="btn btn-primary" id="mail-Check-Btn">본인인증</button>
															</div>
														</div>
													</div>
												</div>
												<div class="mail-check-box">
													<input id='mail-check-input' class="form-control mail-check-input" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">
												</div>
												<span id="mail-check-warn"></span>
											</div>
										</div>										
										<div class='col-md-12'>
											<div class='row'>
												<div class="col-md-12">
													<label class="label bi bi-check" for="password">PASSWORD   <small>(※8~16자)</small></label>
													<div class="form-group d-flex justify-content-center">
														<input type="password" class="form-control mr-2" name="pwd" id="pwd" placeholder="Password">
														<input type="password" class="form-control" name="pwdCheck" id="pwdCheck" placeholder="Password Check">
													</div>
													<span id="pwd-check-warn"></span>
												</div>
												<div class="col-md-6">
													<div class="form-group">
														<label class="label bi bi-check" for="subject">NICKNAME</label> 
														<input type="text" class="form-control" name="nickname" id="nickname" placeholder="Nickname">
													</div>
													<div><span id="nick-check-warn"></span></div>
												</div>
												<div class="col-md-6">
													<div class="form-group">
														<label class="label bi bi-check" for="subject">NAME</label> 
														<input type="text" class="form-control" id="name" placeholder="Name">
													</div>
												</div>
												<div class="col-md-12">
													<label class="label bi bi-check" for="subject">PHONENUMBER</label> 
													<div class="form-group">
														<div class="d-flex justify-content-center">
															<select class="form-control mr-1" name="phone1" id="phone1">
																<option value='010'>010</option>
																<option value='011'>011</option>
																<option value='016'>016</option>
																<option value='019'>019</option>
															</select>
															<input type="text" class="form-control mr-1" name="phone2" id="phone2">
															<input type="text" class="form-control mr-1" name="phone3" id="phone3">
														</div>
													</div>
												</div>
												<div class="col-md-12">
													<div class="form-group">
														<label class="label bi bi-check mr-2" for="subject"><b>AGREE?</b></label>
														<label>YES!;)</label>
														<input type="radio" class="mr-2" name="agree" value="Y" checked="checked">
														<label>NOPE</label>
														<input type="radio" class="mr-2" name="agree" value="N">
													</div>
												</div>
										 		
											</div>
											<div class="row">
												<div class="col-md-6"></div>
												<br>
												<div class="col-md-12">
													<div class="form-group">
														<hr>
														<label class="label" for="subject">선택정보 입력</label><br>
													</div>
												</div>
												<div class="col-md-12">
													<div class="form-group">
														<label class="label bi bi-caret-right-fill" for="subject">GENDER</label>&nbsp;&nbsp;&nbsp;&nbsp;
														<label>Man</label>
														<input type="radio" name="gender" value="M">&nbsp;&nbsp; 
														<label>Woman</label>
														<input type="radio" name="gender" value="W">
													</div>
												</div>
												<div class="col-md-12">
													<div class="form-group">
														<label class="label bi bi-caret-right-fill">PROFILE PHOTO</label> 
														<input type="button" class="btn btn-light p-0 m-0" value="➕" onClick="uploadClick();" /> 
														<input class="form-control" type="file" id="userphoto" style="display: none" multiple accept="" />
														<div class="row-cols-4 card-body mb-3 border rounded bg-white" id=imageList></div>
													</div>
												</div>
												<div class="col-md-12">
													<div class="form-group d-flex justify-content-center">
														<input onClick="submit();" type="button" value="Sign Up" class="btn btn-primary float-right"> 
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

  <script src="/js/trim.js"></script>
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
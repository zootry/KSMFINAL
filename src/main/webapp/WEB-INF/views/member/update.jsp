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
    <script src="/js/jquery.min.js"></script>
    <script type="text/javascript" language="javascript" 
		     src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js">
    </script>
    <script>
   	var m_seq = "${memberone.m_seq}";
    var pwd;   
    var pwdCheck;
    var nickname = "${memberone.nickname}";
    var phone = "${memberone.phone}";
    var pnum2 = phone.substring(phone.length-4, phone.length);
    var pnum1 = phone.substring(3, phone.length-4);
    var pnum0 = phone.substring(0,3);
    
    var selectedImages = [];
	var savedImages = [];
	var imgNum = 0;
	$(function(){
    	$("#userEmail").val("${memberone.email}");
    	$("#pwd").val("${memberone.pwd}");    
    	$("#nickname").val("${memberone.nickname}");
    	$("#name").val("${memberone.name}");
    	$("#agree").val("${memberone.agree}");    	
    	$("#gender").val("${memberone.gender}");
    	$("#phone2").val(pnum1);
    	$("#phone3").val(pnum2);
    	$("#phone1").val(pnum0).attr("selected", "selected");
    	
    	<c:forEach var="i" items="${profile}">
			savedImages.push({fname: '${i.fname}', ofname: '${i.ofname}'});
		</c:forEach>
		
		if(savedImages != null){
			var html = "";
			savedImages.forEach(function(i, idx){
				html += "<img src='/member/display?imgName="+i.fname+"' title='"+i.ofname+"' class='col p-3 saved' style='width:10rem; height:10rem; border-radius:1.2rem !important' onclick='deleteClick(this,"+idx+");'>";
			});
			$("#imageList").append(html);
		}
		$("#userphoto").on("change", function(e){
			var images = e.target.files;
			imageArr = Array.prototype.slice.call(images);
			preview(imageArr);
		});
		
		var $resultMsg2 = $('#pwd-check-warn');
		$('#pwdCheck').keyup(function(){			
			$resultMsg2.html('비밀번호 확인란에 입력해주세요.');
			pwd = $('#pwd').val();
			pwdCheck = $('#pwdCheck').val();
			if(8<=pwd.length && pwd.length<=16){
				if(pwd.length === pwdCheck.length){
					if(pwd != pwdCheck){
						$resultMsg2.html('비밀번호가 일치하지않습니다.');
						$resultMsg2.css('color','red');
				        return;
					}else if(pwd.includes(' ')){
						$resultMsg2.html('공백은 포함될 수 없습니다.');
						$resultMsg2.css('color','red');
						return;
					}else{
						$resultMsg2.html('비밀번호가 일치합니다.');
						$resultMsg2.css('color','green');
				        return;
					}
				}
			}else{
				$resultMsg2.html('비밀번호는 8~16자로 정해주세요');
				$resultMsg2.css('color','red');
				return;
			}
		});
		
		var $resultMsg3 = $('#nick-check-warn');
		$('#nickname').keyup(function(){
			$resultMsg3.html('');
			newnickname = $('#nickname').val();
			if(newnickname != nickname){
				if(nickname != null){
					if(15<nickname.length){
						$resultMsg3.html('닉네임은 15자 이내로 정해주세요');
						$resultMsg3.css('color','red');
						return;
					}else if(nickname.includes(' ')){
						$resultMsg3.html('공백은 포함될수 없습니다');
						$resultMsg3.css('color','red');
						return;
					}
				}
				$.ajax({
		    		url: 'nickCheck.do',
		    		type: 'post',
		    		data: {nick: newnickname},
		    		success: function(data){
		    			if(data == "T"){
		    				$resultMsg3.html('중복된 닉네임입니다');
							$resultMsg3.css('color','red');
							return;
		    			}else{
		    				nickname = newnickname;
		    			}
		    		}	    		
		    	});
			}
		});		
		
		var form1 = $('form#contactForm');
		$(form1).submit(function(e){
			e.preventDefault();
			
			var formData = new FormData();
			
			for(var i=0; i<selectedImages.length; i++){
				if(selectedImages[i] != null){
					formData.append("multipartFiles", selectedImages[i]);
				}
				else{
					formData.append("multipartFiles", null);
				}
			}
			for(var i=0, j=0; i<savedImages.length; i++){
				if(savedImages[i].ofname == null){
					formData.append("fnames["+j+"]", savedImages[i].fname);
					j++;
				}else{
					formData.append("fnames[0]", null);
				}
			}
			
			if(pwdCheck == null){
				alert('비밀번호를 기입해주세요');
				$('#pwd').focus();
				return false;
			}
			if(nickname == ""){
				alert('닉네임을 기입해주세요');
				console.log('#nick: '+nickname);
				$('#nickname').focus();
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
						alert('형식에 맞춰 작성해주세요');
					}
				}else{
					alert('전화번호에는 숫자만 써주세요');
				}
			}
			
			formData.append("m_seq", m_seq);
			formData.append("pwd", pwdCheck);
			formData.append("nickname", nickname);
			formData.append("phone", phone);
			
			$.ajax({
				type : 'POST',
				url : $(form1).attr('action'),
				data : formData,
				processData : false,
				contentType : false,
				success : function(){
					alert('수정 되었습니다.');
					location.href = '/member/mypage.do?m_seq=${sessionScope.member.m_seq}';
				}
			});
		});		
    });
	function preview(imageArr){
		imageArr.forEach(function(i, idx){
			if(i.type.match('image.*')){
				var reader = new FileReader();
				console.log("i: "+i);
				selectedImages.push(i);
				console.log("se: "+selectedImages[0]);
				reader.onload = function(e){
					var html = "";
					html += "<img src='"+e.target.result+"' title='"+i.name+"' class='col p-3 selected' style='width:10rem; height:10rem; border-radius:1.2rem !important' onclick='deleteClick(this, "+imgNum+");'>";
					imgNum ++;
					$("#imageList").append(html);
				}
				reader.readAsDataURL(i);
			}else{
				
			}
		});
		$("#userphoto").val("");
	}
	function uploadClick(){
		$("#userphoto").click();
	}
	function deleteClick(imgObj, i){
		if($(imgObj).attr("class").includes("selected")){
			selectedImages.splice(i, 1);
		}else if($(imgObj).attr("class").includes("saved")){
			delete savedImages[i].ofname;
		}
		$(imgObj).remove();
	}
    </script>    
  </head>
  <body>
	<%@include file="../header.jsp" %>
    
    <section class="ftco-section bg-light">
    <div class="container">
		<div class="row justify-content-center">
			<div class="col-md-12">
				<div class="wrapper">
					<div class="row justify-content-center">
						<div class="col-md-7">
							<div class="contact-wrap w-100 p-md-5 p-4">
								<h3 class="mb-4">회원정보수정</h3>
								<form action="updateM.do" method="POST" id="contactForm" name="contactForm" class="contactForm">
									<div class="row">
										<div class="col-md-12">
											<label class="label">필수정보</label>
										</div>					
                      					<div class="col-md-6">
											<div class="form-group">
												 <label class="label" for="email">EMAIL</label>
												 <div class="input-group">												 	
													<input type="text" class="form-control" id="userEmail" disabled>
												</div>
											</div>													                      					
                     					 </div>
                     					 <div class="col-md-6">
                        					<div class="form-group">                        						
												<label class="label" for="subject">NICKNAME</label>
												<input type="text" class="form-control" id="nickname">
											</div>
											<small><span id="nick-check-warn"></span></small>
                      					</div>
										<div class="col-md-6">
											<div class="form-group">
												<label class="label" for="password">PASSWORD</label>
												<input type="password" class="form-control" id="pwd">
											</div>
                     					 </div>
					                      <div class="col-md-6">
					                        <div class="form-group">
												<label class="label" for="password" style="margin-bottom: 8px;"></label>
												<input type="password" class="form-control" id="pwdCheck" placeholder="Password Check">
											</div>
                      					</div>
                      					<div class="col-md-12 mx-1"><span id="pwd-check-warn"><small>비밀번호 확인을 기입해주세요</small></span></div>            					
									</div>																			
									<div class="row">					                      
					                      <div class="col-md-12">
                        					<div class="form-group">
                        						<hr>
                        						<label class="label" for="subject">선택정보</label><br>
											</div>
                      					</div>
				                        	<div class='col-md-4'>
					                          <div class="form-group">
					                            <label class="label" for="subject">PHONE NUMBER</label>					                            
					                            <select class="form-control" name="phone1" id="phone1">
												<option value='010'>010</option>
												<option value='011'>011</option>
												<option value='016'>016</option>
												<option value='019'>019</option>												
												</select>
											  </div>
					                        </div>
					                        <div class='col-md-4 my-2'>
					                        	<div class='form-group'>
					                        		<label class="label" style="margin-bottom: 8px;"> </label>
													<input type="text" class="form-control" name="phone2" id="phone2">
												</div>
					                        </div>
					                        <div class='col-md-4 my-2'>
					                        	<div class='form-group'>
					                        		<label class="label" style="margin-bottom: 8px;"> </label>
													<input type="text" class="form-control" name="phone3" id="phone3">
												</div>
					                        </div>					                        
					                        <div class="col-md-4">
					                          <div class="form-group">
					                            <label class="label" for="subject">GENDER</label>
					                            <input type="text" class="form-control" id="gender" disabled>
					                          </div>
					                        </div>
					                        <div class="col-md-4">
		                        					<div class="form-group">                        						
														<label class="label">NAME</label>
														<input type="text" class="form-control" id="name" disabled>
													</div>
		                      					</div>
					                        <div class="col-md-12">
												<div class="form-group">
													<label class="label" for="big">PHOTO</label>
													<input type="button" class="btn btn-light p-0 m-0" value="➕" onClick="uploadClick();" />
													<input class="form-control" type="file" id="userphoto" style="display:none" multiple accept=""/>
													<div class="row-cols-4 card-body mb-3 border rounded bg-white" id=imageList></div>
												</div>
	                    					 </div>
											<div class="col-md-12">
												<div class="form-group d-flex justify-content-center">
													<input type="submit" value="Update" class="btn btn-primary">
													<div class="submitting"></div>
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
    </section>   
  <%@include file="../footer.jsp" %>

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
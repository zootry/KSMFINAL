<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
    <title>Sign Up Pet</title>
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
    
    <script type="text/javascript" language="javascript" 
		     src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js">
    </script>    
    <script>
    	var pname;
    	var petkind;
    	var petbreed;
    
	    var selectedImages = [];
		var imgNum = 0;
    	$(function(){
    		$('#petname').focus();
    		$("#petphoto").on("change", function(e){
    			$("#imageList").empty();
    			var images = e.target.files;
    			imageArr = Array.prototype.slice.call(images);
    			preview(imageArr);
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
    		$("#petphoto").val("");
    	}
    	function uploadClick(){
    		$("#petphoto").click();
    	}
    	function deleteClick(imgObj, i){
    		selectedImages.splice(i,1);
    		$(imgObj).remove();
    	}
    	
	    const email = "${sessionScope.member.email}";
	    function submit(){
	    	var formData = new FormData();
	    	
	    	pname = $('#petname').val();
	    	if(pname != ""){
				if(pname.length<10){
					
				}else{
					alert('이름은 10자 이내로 써주세요');
					$('#petname').focus();
					return false;
				}
			}else{
				alert('이름을 기입해주세요');
				$('#petname').focus();
				return false;
			}
	    	
	    	for(var i=0; i<selectedImages.length; i++){
	    		if(selectedImages[i] != undefined){
	    			formData.append("multipartFiles", selectedImages[i]);
	    		}else{
	    			alert('반려동물의 사진을 등록해야합니다');
					return false;
	    		}
	    	}	    	
	    	petkind = $('#petkind').val();
	    	if(petkind == ""){
				alert('반려동물의 종류를 골라주세요');
				$('#petkind').focus();
				return false;
			}
	    	
	    	petbreed = $('#petbreed').val();
	    	if(petbreed == ""){
				alert('반려동물의 품종을 골라주세요');
				$('#petbreed').focus();
				return false;
			}
	    	var byear = $('#byear').val();
	    	if(byear != ""){
				if(byear.length == 4){
					
				}else{
					alert('년도는 4자리로 써주세요');
					$('#byear').focus();
					return false;
				}
			}else{
				alert('출생년도를 기입해주세요');
				$('#byear').focus();
				return false;
			}
			
			var petxxx = $("input[name='petxxx']:checked").val();
			if(petxxx == null){
				alert('반려동물의 성별을 골라주세요');
				return false;
			}
			var petcut = $("input[name='petcut']:checked").val();
			if(petcut == null){
				alert('중성화 수술여부를 입력해주세요');
				return false;
			}
			var petbig = $("input[name='petbig']:checked").val();
			if(petbig == null){
				alert('반려동물의 크기를 골라주세요');
				return false;
			}
			
			formData.append("email", email);
	    	formData.append("name", pname);
	    	formData.append("kind", petkind);
	    	formData.append("breed", petbreed);
	    	formData.append("byear", byear);
	    	formData.append("sex", petxxx);
	    	formData.append("cut", petcut);
	    	formData.append("big", petbig);
	    	formData.append("memo", $('#memo').val());
	    	
	    	$.ajax({
				type : 'POST',
				url : "/member/signupPet.do",
				data : formData,
				processData : false,
				contentType: false,
				success : function(){
					alert('등록 되었습니다.');
					location.href="/member/mypage.do?m_seq=${sessionScope.member.m_seq}";
				}
			});	    	
	    }
    </script>
    <style>
    	textarea{
    		resize: none;
    	}
    </style>
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
								<h3 class="mb-4">마이펫 등록</h3>								
								<div class="row">									
                   					<div class="col-md-12">
										<div class="input-group">
											<span class="input-group-text">NAME</span>
											<input type="text" class="form-control" name="petname" id="petname" placeholder="이름">
											<span class="input-group-text">출생년도</span>
											<input type="text" class="form-control" id="byear" placeholder="YYYY">											
										</div>
                  					 </div>	
                  					 <div class="col-md-12 mt-3">
										<label class="label">PHOTO</label>
										<input type="button" class="btn btn-light p-0 m-0" value="➕" onClick="uploadClick();" />
										<input class="form-control" type="file" id="petphoto" style="display:none" multiple accept=""/>
										<div class="row-cols-4 card-body mb-3 border rounded bg-white" id=imageList></div>
									</div>			                      
									<div class="col-md-6">
										<label class="label" for="kind">KIND</label>
										<select class="form-control" name="petkind" id="petkind">
											<option value="" selected='selected'>분류</option>
											<option value="개">개</option><option value="고양이">고양이</option><option value="조류">조류</option><option value="설치류">설치류</option>
											<option value="어류">어류</option><option value="파충류">파충류</option><option value="양서류">양서류</option><option value="곤충">곤충</option>
											<option value="기타">기타</option>
										</select>
                   					 </div>
				                      <div class="col-md-6">
										<div class="form-group">
											<label class="label" for="breed">BREED</label>
											<input type="text" class="form-control" name="petbreed" id="petbreed" placeholder="품종">
										</div>
                    					 </div>
                    					 <div class="col-md-4">
                    					 	<label class="label">성별</label>
	                       					<div class="form-group">
												<label>암</label>&nbsp;&nbsp;<input type="radio" name="petxxx" value="F">&nbsp;&nbsp;
					                            <label>수</label>&nbsp;&nbsp;<input type="radio" name="petxxx" value="M">
											</div>
                     					</div>
                     					<div class="col-md-4">
                     						<label class="label" for="cut">중성화 하셨나요?</label>
	                       					<div class="form-group">  
												<label>O</label>&nbsp;&nbsp;<input type="radio" name="petcut" value="Y">&nbsp;&nbsp;
					                            <label>X</label>&nbsp;&nbsp;<input type="radio" name="petcut" value="N">
											</div>
                     					</div>
                     					<div class="col-md-4">
                     						<label class="label" for="big">SIZE</label>
					                        <div class="form-group">
												<label>S</label>&nbsp;&nbsp;<input type="radio" name="petbig" value="소형">&nbsp;&nbsp;
					                            <label>M</label>&nbsp;&nbsp;<input type="radio" name="petbig" value="중형">&nbsp;&nbsp;
					                            <label>L</label>&nbsp;&nbsp;<input type="radio" name="petbig" value="대형">
											</div>
                     					</div>
                     					<div class="col-md-4">
				                        <div class="form-group">
											<label class="label" for="big">MEMO</label>
											<span id="length-check"><small>최대 200자까지</small></span>
											<textarea rows="6" cols="65" id="memo" name="memo" placeholder="메모" maxlength="200"></textarea>
										</div>
                     					</div>
                     					<div class="col-md-12">
										<div class="form-group d-flex justify-content-center">												
											<input onClick="submit();" type="button" value="Sign Up" class="btn btn-primary">
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
  
  <%@include file="../footer.jsp" %>

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

  <script src="/js/trim.js"></script>
  <script src="/js/jquery.min.js"></script>
  <script src="/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="/js/popper.min.js"></script>
  <script src="/js/bootstrap.min.js"></script>
  <script src="/js/jquery.easing.1.3.js"></script>
  <script src="/js/jquery.waypoints.min.js"></script>
  <script src="/js/jquery.stellar.min.js"></script>
  <script src="/js/jquery.animateNumber.min.js"></script>
  <script src="/js/bootstrap-datepicker.js"></script>
  <script src="/js/jquery.timepicker.min.js"></script>
  <script src="/js/owl.carousel.min.js"></script>
  <script src="/js/jquery.magnific-popup.min.js"></script>
  <script src="/js/scrollax.min.js"></script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="/js/google-map.js"></script>
  <script src="/js/main.js"></script>
    
  </body>
</html>
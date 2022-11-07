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
	    var selectedImages = [];
		var savedImages = [];
		var imgNum = 0;
		
    	$(function(){
    		$("#petname").val("${petone.name}");
    		$("#petkind").val("${petone.kind}");
    		$("#petbreed").val("${petone.breed}");
    		$(":radio[name='petxxx'][value='${petone.sex}']").attr('checked', true);
    		$(":radio[name='petcut'][value='${petone.cut}']").attr('checked', true);
    		$(":radio[name='petbig'][value='${petone.big}']").attr('checked', true);
    		$("#memo").val("${petone.memo}");
    		var today = new Date();
			var age = today.getFullYear() - "${petone.byear}";
    		$("#petage").val(age);
    		
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
			$("#petphoto").on("change", function(e){    			
    			var images = e.target.files;
    			imageArr = Array.prototype.slice.call(images);
    			preview(imageArr);
    		});
    	});
    	function preview(imageArr){
    		imageArr.forEach(function(i, idx){
    			if(i.type.match('image.*')){
    				var reader = new FileReader();
    				selectedImages.push(i);
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
    		$("#petphoto").val("");
    	}
    	function uploadClick(){
    		$("#petphoto").click();
    	}
    	function deleteClick(imgObj, i){
    		if($(imgObj).attr("class").includes("selected")){
    			selectedImages.splice(i, 1);
    		}else if($(imgObj).attr("class").includes("saved")){
    			delete savedImages[i].ofname;
    		}
    		$(imgObj).remove();
    	}	    
	    function submit(){
	    	var formData = new FormData();
	    	
	    	for(var i=0; i<selectedImages.length; i++){
				if(selectedImages[i] != null){
					formData.append("multipartFiles", selectedImages[i]);
				}else{
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
			
			var pname = $('#petname').val();
	    	if(pname != null){
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
	    	
	    	var age = $('#petage').val();
	    	var regExpage = /[0-9]*$/;
	    	if(age != null){
	    		if(regExpage.test(age)){
	    			
	    		}else{
	    			alert('숫자만 기입해주세요');
					$('#petage').focus();
					return false;
	    		}
	    	}else{
	    		alert('나이를 기입해주세요');
				$('#petage').focus();
				return false;
	    	}
	    		  
			formData.append("name", pname);
			formData.append("breed", $('#petbreed').val());
			formData.append("age", age);
			formData.append("cut", $("input[name='petcut']:checked").val());
	    	formData.append("big", $("input[name='petbig']:checked").val());
			formData.append("memo", $('#memo').val());
			formData.append("petseq", "${petone.petseq}");
			
	    	$.ajax({
				type : 'POST',
				url : "/member/updateP.do",
				data : formData,
				processData : false,
				contentType : false,
				success : function(){
					alert('수정 되었습니다.');
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
								<h3 class="mb-4">마이펫 수정</h3>								
								<div class="row">								
									<div class="col-md-6">
										<label class="label" for="name">NAME</label>
										 <div class="input-group">
											<input type="text" class="form-control" id="petname">
										</div>
									</div>
									<div class="col-md-4">
				                        <div class="form-group">
											<label class="label" for="age">AGE</label>
											<input type="text" class="form-control" id="petage" maxlength='2'>
										</div>
                   					</div>
                  					<div class="col-md-12">
										<div class="form-group">											
											<label class="label" for="big">PHOTO</label>
											<input type="button" class="btn btn-light p-0 m-0" value="➕" onClick="uploadClick();" />
											<input class="form-control" type="file" id="petphoto" style="display:none" multiple accept=""/>
											<div class="row-cols-4 card-body mb-3 border rounded bg-white" id=imageList></div>
										</div>
                 					 </div>                     									                     
									<div class="col-md-6">
										<div class="form-group">
											<label class="label" for="kind">KIND</label>
											<input type="text" class="form-control" id="petkind" disabled>
										</div>
                   					 </div>
				                      <div class="col-md-6">
										<div class="form-group">
											<label class="label" for="breed">BREED</label>
											<input type="text" class="form-control" id="petbreed">
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
											<textarea rows="6" cols="65" id="memo" maxlength="200"></textarea>
										</div>
                   					</div>
                   					<div class="col-md-12">
										<div class="form-group d-flex justify-content-center">										
											<input onClick="submit();" type="button" value="Update" class="btn btn-primary">
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
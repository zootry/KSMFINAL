<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html lang="en">
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
<style>
   	.files{
   		height:3rem;
   	}
   	.box-wrap{
   		padding:1.5%;
   	}
   	.box{
   		position:relative;
   		width:100%;
   	}
   	.box::after{
   		display:block;
   		content:"";
   		padding-bottom:100%;
   	}
   	.img{
   		position: absolute;
   		margin: 0 auto;
   		width: 100%;
   		height: 100%;
   		object-fit:cover;
   	}
   	#imageList{
   		position:relative;
   		padding:1.5%;
   	}
   	.plus{
   		cursor:pointer;
   	}
   	#plus:hover, .selectedImg:hover{
   		opacity:0.5;
   	}
   	.btn:hover{
   		filter:brightness(1.5) !important;
   	}
   	#category, #title, #content, #price {
   		border-color: #dee2e6;
   	}
   	#content{
   		padding:3rem;
   	}
   	.headtitle{
		margin:auto;
		text-align:center;
		font-weight:bold;
	}
	.headtitle h3{
		opacity: .8;
		background: linear-gradient(to bottom right, #97a3ea 20%, #a091f3 60%, #9283f2 90%) no-repeat;
		color:white;
		border-radius:5px;	
	}
</style>
 </head>
  
  <body>
<%@include file="../header.jsp" %>
    
    <section class="ftco-section bg-light">    
    <div class="container">
    	<div class="headtitle"><h3>갤러리 글 등록</h3></div>
    	<div class="rounded shadow bg-white p-5">
	    	<input type="hidden" id="g_seq" value="${galleryList.g_seq}">
			<div class="row row-md-12 mb-3">
				<div class="col-12 col-md-12 input-group p-0">
					<label for="fileDiv" class="form-label m-0">파일 등록</label>
					<button type="button" class="btn btn-outline-primary btn-sm" onClick="uploadClick();"><i class="fa fa-file-image-o" aria-hidden="true"></i></button>
					<input class="form-control" type="file" id="upload" style="display:none" multiple accept=""/>
				</div>
				<div class="col-12 col-md-12">
					<div class="row row-md-12 border rounded bg-white" id="imageList"></div>
				</div>
			</div>
			<div class="row row-md-12 mb-3">
				<label for="content" class="col-12 col-md-12 form-label m-0 p-0">내용</label>
				<textarea class="col-12 col-md-12 form-control" id="content" rows="15"></textarea>
			</div>
			<div class="col-12 col-md-12 mb-3 text-center">
				<input type="button" class="btn text-black rounded-pill px-4 text-white" id="saveButton" style="background-color:#a091f3;border:none;" value="등록" onclick="submit();">
			</div>
		</div>
	</div>
    </section>
<%@include file="../footer.jsp" %>

<!-- loader -->
<div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

<script src="/js/jquery-migrate-3.0.1.min.js"></script>
<script src="/js/popper.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/jquery.easing.1.3.js"></script>
<script src="/js/jquery.stellar.min.js"></script>
<script src="/js/jquery.animateNumber.min.js"></script>
<script src="/js/bootstrap-datepicker.js"></script>
<script src="/js/jquery.timepicker.min.js"></script>
<script src="/js/owl.carousel.min.js"></script>
<script src="/js/jquery.magnific-popup.min.js"></script>
<script src="/js/scrollax.min.js"></script>
<script src="/js/main.js"></script>
<script>
  //이미지 업로드
	var selectedImages = [];
	var imgNum = 0;
	
	$(function(){
		$("#upload").on("change", function(e){
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
					html += "<div class='col-3 col-md-3 align-self-center' onclick='deleteClick(this,"+imgNum+");'>";
					html += "<img src='"+e.target.result+"' title='"+i.name+"' class='img-fluid'>";
					html += "</div>"
					$("#imageList").html(html);
					imgNum ++;
				}
				reader.readAsDataURL(i);
			}else{
				
			}
		});
		$("#upload").val("");
	}
	function uploadClick(){
		$("#upload").click();
}
	function deleteClick(imgObj, i){
		selectedImages.splice(i, 1);
		console.log(selectedImages[0]);
		console.log(selectedImages[1]);
		console.log(selectedImages[2]);
		console.log(selectedImages[3]);
		console.log(imgObj);
		$(imgObj).remove();
	}
	function submit(){
	var formData = new FormData();
	
	for(var i=0; i<selectedImages.length; i++){
		if(selectedImages[i] != undefined){
			formData.append("multipartFiles", selectedImages[i]);
			console.log(formData);
		}
	}
	formData.append("content", $("#content").val());
	// 나중에 로그인한 멤버 email 추가
	$.ajax({
		type : "POST",
		url : "/freeboard/galleryWrite.json",
		data : formData,
		processData : false,
		contentType : false,
		success : function(data){
			if(data){
				location.href="/freeboard/galleryList";
			}else{
				alert("안들어감");
			}
		}
	});
	//사진파일이 없을때 alret
 	/*var fileCheck = document.getElementById("upload").value;
	     if(!fileCheck){
	        alert("이미지가 없습니다. 이미지 파일을 첨부해 주세요.");
	 	}
	    return false;*/
}
</script>
</body>
</html>
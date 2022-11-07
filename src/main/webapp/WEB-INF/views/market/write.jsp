<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
	<head>
    <title>Pet Care</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=yes">
    <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">	
    <link rel="stylesheet" href="/css/animate.css">
    <link rel="stylesheet" href="/css/owl.carousel.min.css">
    <link rel="stylesheet" href="/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="/css/magnific-popup.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="/css/jquery.timepicker.css">
    <link rel="stylesheet" href="/css/flaticon.css">
    <link rel="stylesheet" href="/css/style.css">
    <script src="/js/jquery.min.js"></script>
    <script>
	    <% session.removeAttribute("key"); %>
	    <% session.removeAttribute("word"); %>
	    <% session.removeAttribute("pageNum"); %>
	    
    	var selectedImages = [];
    	var imgNum = 0;
    	var number = 0;
    	
    	$(function(){
    		$(".check").on("click", function(){
				if($(".bi-gift-fill").length){
    				$(".bi-gift-fill").removeClass("bi-gift-fill").addClass("bi-gift");
    				$(".bi-gift").next().css("color", "lightgray");
    				$("#price").prop("readonly", false);
    				$("#price").val("");
    			}else if($(".bi-gift").length){
    				$(".bi-gift").removeClass("bi-gift").addClass("bi-gift-fill");
    				$(".bi-gift-fill").next().css("color", "gray");
    				$("#price").prop("readonly", true);
    				$("#price").val(0);
    			}
    		})
    		$("#price").on("keyup", function(e){
    			number = e.target.value;
    			while(number.includes(",")){
    				number = number.replace(",", "");
    			}
    			
    			number = Number(number);
    			
    			if(isNaN(number)){
    				$(this).val("");
    			}else if(number >= 100000000){
    				$(this).val("");
    			}else{
    				$(this).val(number.toLocaleString('ko-KR'));
    			}
    			

    		})
    		$("#upload").on("change", function(e){
    			var images = e.target.files;
    			
    			if((images.length+imgNum)>10 || imgNum>=10){
    				showModal("사진은 최대 10장까지 업로드가 가능합니다 !");
    				$("#upload").val(null);
    				return false;
    			}
   				imageArr = Array.prototype.slice.call(images);
       			for(var i=0; i<images.length; i++){
       				if(!checkExtension(images[i].name)){
       					showModal("이미지 파일만 업로드가 가능합니다 !");
       					$("#upload").val(null);
       					return false;
       				}
       			}
       			preview(imageArr);
       			$("#upload").val(null);
    		});
    		
    		$("#plus").on("click", function(){
    			$("#upload").click();	
    		});
    		
    	});
    	function checkExtension(fileName){
    		var regex = new RegExp("\.(bmp|gif|jpg|jpeg|png)$");
    		if(!(regex.test(fileName))){
    			return false;
    		}else{
    			return true;	
    		}
    	}
    	function attachX(imgObj, imgNum){
    		$(imgObj).append("<div id='X' class='img bi bi-dash-circle-fill text-danger text-right px-1' onclick='deleteClick(this, "+ imgNum +");'></div>");
    	}
    	function ditachX(){
    		$("#X").remove();
    	}
    	function deleteClick(imgObj, i){
    		$(imgObj).parents('.selectedImg').remove();
    		selectedImages.splice(i, 1);
    		imgNum --;
    		$("#imgNum").html(" ( "+imgNum+" / 10 )");
    	}
    	function preview(imageArr){
    		imageArr.forEach(function(i, idx){
    			if(i.type.match('image.*')){
    				var reader = new FileReader();
    				selectedImages.push(i);
    				reader.onload = function(e){
    					var html = "";
    					html += "<div class='selectedImg box-wrap col-md-2 col-3'>";
    					html += "<div class='box' onmouseenter='attachX(this,"+imgNum+");' onmouseleave='ditachX();'>";
    					html += "<img class='img rounded' src='"+e.target.result+"' title='"+i.name+"'>";
    					html += "</div>";
    					html += "</div>";
    					imgNum ++;
    					$("#imgNum").html(" ( "+imgNum+" / 10 )");
    					$("#imageList").append(html);
    				}
    				reader.readAsDataURL(i);
    			}
    		});
    	}
    	function showModal(text){
    		$(".modal-body").html("<span class='text-center'>"+text+"</span>");
			$("#modal").modal("show");
    	}
    	function validate(){
    		if(imgNum==0){
    			showModal("사진을 한 장 이상 등록해 주세요 !");
    		}else if($("#content").val() == ""){
    			showModal("내용을 입력해 주세요 !");
    			$("#content").focus();
    		}else if($("#title").val() == ""){
    			showModal("제목을 입력해 주세요 !");
    			$("#title").focus();
    		}else{
    			submit();
    		}
    	}
    	function submit(){
			var formData = new FormData();
			
			for(var i=0; i<selectedImages.length; i++){
				if(selectedImages[i] != undefined){
					formData.append("multipartFiles", selectedImages[i]);
				}
			}
			formData.append("category", $("#category").val());
			formData.append("title", $("#title").val());
			formData.append("content", $("#content").val());
			if($("#price").val() == ""){
				showModal("판매 금액을 입력해 주세요 !");
				$("#price").focus();
				return false;
			}
			formData.append("price", number);
			
			$.ajax({
				type : "POST",
				url : "/market/write.json",
				data : formData,
				processData : false,
				contentType : false,
				success : function(data){
					if(data){
						location.href="/market";
					}
				}
			});
    	}
    </script>
    <style>
    	.img.row.text-center{
    		margin:0 auto;
    	}
    	.check{
    		line-height:1.2rem;
    	}
    	.bi-gift, .bi-gift-fill{
    		font-size:16px;
    	}
    	.bi-gift-fill{
    		color:lightcoral !important;
    	}
    	.bi-gift, #won{
    		color:lightgray !important;
    	}
    	.nanoom .text-center{
    		color:lightgray;
    		font-size:12px;
    	}
    	
    	select{
    		text-align:center;
    		padding-left: 0rem !important;
    		padding-right: 1rem !important;
    	}
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
    <section class="ftco-section bg-light pt-5">
	    <div class="container">
	    <!-- 모달 테스트 -->
	    
		<div class="modal fade" id="modal" tabindex="-1" aria-labelledby=modalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered justify-content-center">
				<div class="modal-content" style="width:80%; border: 2px solid #91bfa5">
					<div class="modal-header text-end border-0">
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="font-size:0.8rem"></button>
					</div>
					<div class="modal-body text-center pt-4 pb-5">
					</div>
				</div>
			</div>
		</div>
	    
		<!-- share market write -->
	      	<div class="headtitle"><h3>나눔마켓 글 등록</h3></div>
	      	<div class="row rounded shadow bg-white py-5 px-3 px-md-4">
      			<div class="col-12 mb-md-4 mb-2">
	      			<div class="row">
	      				<div class="col-12 col-md-6 p-0">
			      			<div>카테고리 / 제목</div>
							<div class="input-group p-0 mb-2 mb-md-0 border rounded">
								<select id="category" class="col-4 col-md-4 form-select border-0" aria-label="Default select example">
									<option value="식품">식품</option>
									<option value="의류">의류</option>
									<option value="장난감">장난감</option>
    								<option value='가전제품'>가전제품</option>
    								<option value='가구'>가구</option>
    								<option value='티켓/쿠폰'>티켓/쿠폰</option>
								</select>
								<input id="title" type="text" class="form-control border-0" aria-label="Text input with dropdown button">
							</div>
						</div>
						<div class="col-12 col-md-6 pr-md-0 pl-md-2 p-0">
			      			<div id="dealType">판매 금액</div>
			      			<div class="input-group p-0 border rounded">
								<div id="won" class="align-self-center px-3" style="color:gray !important">&#65510;</div>
			      				<input id="price" type="text" class="form-control border-0" placeholder="금액을 입력해 주세요 !">
			      				<div class="check align-self-center">
			      					<div class="nanoom pt-1">
				      					<div class="bi bi-gift px-3"></div>
				      					<div class="nanoom text-center">나눔</div>
			      					</div>
			      				</div>
			      			</div>
			      		</div>
			      	</div>
				</div>
	      		<div class="col-12 form-label m-0 p-0">파일<span id="imgNum"> ( 0 / 10 )</span></div>
	      		<div class="col-12 mb-md-4 mb-2">
			      	<div id="imageList" class="row rounded border bg-white">
			      		<div id="plus" class="plus box-wrap col-md-2 col-3"><div class="plus box border rounded"><div class="img row text-center"><span class="plus col-12 bi bi-plus-lg align-self-center p-0 fs-5"></span></div></div></div>
			      		<input class="form-control" type="file" id="upload" style="display:none" multiple accept=""/>
			      	</div>
			    </div>
			    <div class="col-12 form-label m-0 p-0">내용</div>
			    <div class="col-12 mb-md-4 mb-2">
				    <div class="row">
					<textarea class="col-12 form-control" id="content" rows="10" style="resize:none"></textarea>
					</div>	
			    </div>
			    <div class="col-6 px-1 text-right">
		    		<input type="button" class="btn btn-light rounded-pill px-4 text-secondary" value="취소"/>
		    	</div>
		    	<div class="col-6 px-1">
		    		<input type="button" class="btn text-black rounded-pill px-4 text-white" style="background-color:#a091f3" value="등록" onClick="validate();"/>
		    	</div>
		    </div>
		<!-- share market write-->
		</div>
    </section>
    
  <%@include file="../footer.jsp" %>
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>
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
  <script src="/js/main.js"></script>
  </body>
</html>
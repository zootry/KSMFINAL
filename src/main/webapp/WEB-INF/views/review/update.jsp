<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<%@include file="../header.jsp" %>
<html lang="ko">
	<head>
    <title>Pet Care</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous">
	</script>
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

<style>

.star-input{
	padding: 25px 15px;
}

.star-input>.input{
text-align: center;
    margin-top: 10px;
}

.star-input>.input,
.star-input>.input>label:hover,
.star-input>.input>input:focus+label,
.star-input>.input>input:checked+label{display: inline-block;vertical-align:middle;background:url('../images/grade_img.png')no-repeat;}
.star-input {
    width: 100%;
}

.score{font-size:18px; line-height:25px; #fc4c4e; font-weight:bold; text-align:center;}
/* .star-input{display:inline-block; white-space:nowrap;width:225px;height:40px;padding:25px;line-height:30px;} */
.star-input>.input{display:inline-block;width:150px;background-size:150px;height:28px;white-space:nowrap;overflow:hidden;position:relative;}
.star-input>.input>input{position:absolute;width:1px;height:1px;opacity:0;}
star-input>.input.focus{outline:1px dotted #ddd;}
.star-input>.input>label{width:30px;height:0;padding:28px 0 0 0;overflow: hidden;float:left;cursor: pointer;position: absolute;top: 0;left: 0;}
.star-input>.input>label:hover,
.star-input>.input>input:focus+label,
.star-input>.input>input:checked+label{background-size: 150px;background-position: 0 bottom;}
.star-input>.input>label:hover~label{background-image: none;}
.star-input>.input>label[for="p1_2"]{width:15px;z-index:10;}
.star-input>.input>label[for="p1"]{width:30px;z-index:9;}
.star-input>.input>label[for="p2_2"]{width:45px;z-index:8;}
.star-input>.input>label[for="p2"]{width:60px;z-index:7;}
.star-input>.input>label[for="p3_2"]{width:75px;z-index:6;}
.star-input>.input>label[for="p3"]{width:90px;z-index:5;}
.star-input>.input>label[for="p4_2"]{width:105px;z-index:4;}
.star-input>.input>label[for="p4"]{width:120px;z-index:3;}
.star-input>.input>label[for="p5_2"]{width:135px;z-index:2;}
.star-input>.input>label[for="p5"]{width:150px;z-index:1;}
.star-input>output{display:inline-block;width:60px; font-size:18px;text-align:right; vertical-align:middle;}
.headtitle{
	margin:auto;
	padding:5% 0 0 0;
	text-align:center;
	font-weight:bold;
}
.headtitle h3{
	opacity: .8; /*색상연하게 0.0~1.0*/
	background: linear-gradient(to bottom right, #97a3ea 20%, #a091f3 60%, #9283f2 90%) no-repeat;
	color:white;
	border-radius:5px;	
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
</style>
</head>
<body>
	<section class="ftco-section bg-light pt-5">
		<div class="container">          
            <!-- 돌보미 후기 폼 시작 -->
            <div class="headtitle"><h3>돌보미 후기 수정</h3></div>
            <div class="rounded shadow bg-white p-5">
            <div class="row">     	
	            <div class="col-md-6 mb-3">
	            <div class="col-12 form-label m-0 p-0">후기를 작성할 돌보미는?</div>
		            <div class="block-21 d-flex" style="margin:10px;">
		            <a class="blog-img mr-4" style="border-radius:50%;background-image: url(/images/altimg_puppy.png)"></a>
		            <div class="text">
		            	<h3 class="heading m-0">
		            		<span id="dolbomy">${dolbomy.nickname}</span>&nbsp;|&nbsp;${dolbomy.addr}
		            	</h3>
		            	<div class="recentContents">
		            		<div><i class="bi bi-star-fill" style="color:#f2b313"></i>${dolbomy.sat}&nbsp;(후기 ${dolbomy.reviews}건)</div>
		            		<div>GIVE ${dolbomy.give} | TAKE ${dolbomy.take}</div>
		            	</div>
		            </div>
		            </div>
		        </div>
		        <div class="col-md-6 mb-3">
		        <div class="col-12 form-label m-0 p-0">별점을 등록해주세요</div>
			        <div class="star-input">
						<span class="input">
							<input type="radio" name="star" value="1.0" id="p1">
							<label for="p1">1</label>
							<input type="radio" name="star" value="0.5" id="p1_2">
							<label for="p1_2">0.5</label>
							<input type="radio" name="star" value="2.0" id="p2">
							<label for="p2">2</label>
							<input type="radio" name="star" value="1.5" id="p2_2">
							<label for="p2_2">1.5</label>
							<input type="radio" name="star" value="3.0" id="p3">
							<label for="p3">3</label>
							<input type="radio" name="star" value="2.5" id="p3_2">
							<label for="p3_2">2.5</label>
							<input type="radio" name="star" value="4.0" id="p4">
							<label for="p4">4</label>
							<input type="radio" name="star" value="3.5" id="p4_2">
							<label for="p4_2">3.5</label>
							<input type="radio" name="star" value="5.0" id="p5">
							<label for="p5">5</label>
							<input type="radio" name="star" value="4.5" id="p5_2">
							<label for="p5_2">4.5</label>
						</span>
					</div>
				</div>
			</div>
			
				<div class="col-12 form-label m-0 p-0">자세한 후기를 작성해주세요</div>
				<div class="col-12 mb-md-4 mb-2">
				    <div class="row">
					<textarea class="col-12 form-control" id="content" placeholder="내용을 입력해주세요" rows="10" style="resize:none">${fn:replace(carereview.content,"<br/>","&#10;")}</textarea>
					</div>	
			    </div>
			    <div class="col-12 form-label m-0 p-0">사진을 등록해주세요</div>
				<div class="col-12 mb-4">
				<div id="imageList" class="row rounded border bg-white">
		      		<div id="plus" class="plus box-wrap col-md-2 col-2"><div class="plus box border rounded"><div class="img row text-center"><span class="plus col-12 bi bi-plus-lg align-self-center"></span></div></div></div>
		      		<input class="form-control" type="file" id="upload" style="display:none" multiple accept=""/>
	      		</div>
	      		</div>			
				<div class="d-flex justify-content-center">
					<input type="button" id="btnSave" class="btn text-black rounded-pill px-4 text-white" style="background-color:#a091f3;border:none;" value="저장" onclick="submit()">
				</div>
				<input type="hidden" id="cr_seq" name="cr_seq" value="${carereview.cr_seq}">
				<input type="hidden" id="dolbomyEmail" name="dolbomyEmail" value="${carereview.dolbomyEmail}">
			</div>
		</div>
	</section>





	<%@include file="../footer.jsp"%>
	
	<script>
	var selectedImages = [];
	var savedImages = [];
	var imgNum = 0;
	var cr_seq = $("#cr_seq").val();

	$(function(){
		var star = '${carereview.star}';
		$("input:radio[name='star']:radio[value='"+star+"']").prop('checked', true);
		console.log("star"+star);
  		 	<c:forEach var="i" items="${files}">
			savedImages.push({fname: '${i.fname}', ofname: '${i.ofname}'});
		</c:forEach>
	
		if(savedImages != null){
 			var html = "";
 			savedImages.forEach(function(i, idx){
 				html += "<div class='savedImg box-wrap col-2'>";
 					html += "<div class='box' onmouseenter='attachX(this,"+imgNum+");' onmouseleave='ditachX();'>";
 					html += "<img class='img rounded' src='/market/display?imgName="+i.fname+"' title='"+i.ofname+"'>";
 					html += "</div>";
 					html += "</div>";
 					imgNum ++;
   			});
   			$("#imageList").append(html);
  	 		}
		$("#plus").on("click", function(){
  			$("#upload").click();	
  			});
		$("#upload").on("change", function(e){
			var images = e.target.files;
			if((images.length+imgNum)>5 || imgNum>=5){
				alert("사진은 최대 5장까지 업로드가 가능합니다 !");
				$("#upload").val(null);
				return false;
			}
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
 					html += "<div class='selectedImg box-wrap col-2'>";
 					html += "<div class='box' onmouseenter='attachX(this,"+imgNum+");' onmouseleave='ditachX();'>";
 					html += "<img class='img rounded' src='"+e.target.result+"' title='"+i.name+"'>";
 					html += "</div>";
 					html += "</div>";
 					imgNum ++;
 					$("#imageList").append(html);
   				}
   				reader.readAsDataURL(i);
   			}else{
   				
   			}
   		});
   		$("#upload").val("");
     }
	function attachX(imgObj, imgNum){
   		$(imgObj).append("<div id='X' class='img bi bi-dash-circle-fill text-danger text-right px-1' onclick='deleteClick(this, "+ imgNum +");'></div>");
   	}
   	
   	function ditachX(){
   		$("#X").remove();
   	}
  	
  	function deleteClick(imgObj, i){
  		var parent = $(imgObj).parent().parent();
   		if(parent.attr("class").includes("saved")){
   			//savedImages.splice(i, 1);
   			console.log(savedImages);
   			delete savedImages[i].ofname;
   			$(parent).remove();
   			console.log(savedImages[i].ofname);
   			console.log(savedImages);
   		}else if(parent.attr("class").includes("selected")){
			selectedImages.splice(i, 1);
			$(parent).remove();
			console.log(selectedImages);
   		}
  	}
  	function submit(){
  		var formData = new FormData();
  		
		for(var i=0; i<selectedImages.length; i++){
			if(selectedImages[i] != null){
				formData.append("multipartFiles", selectedImages[i]);
			}
		}
		for(var i=0, j=0; i<savedImages.length; i++){
			if(savedImages[i].ofname == null){
				formData.append("fnames["+j+"]", savedImages[i].fname);
				j++;
			}
		}
		formData.append("content", $("#content").val());
		formData.append("star",$("input[name='star']:checked").val());
		formData.append("dolbomyEmail",$("#dolbomyEmail").val());
		formData.append("cr_seq", cr_seq);
		$.ajax({
			type : "POST",
			url : "/review/update.json",
			data : formData,
			processData : false,
			contentType : false,
			success : function(data){
				if(data){
					location.href="/review/content.do?cr_seq="+cr_seq;
				}
			}
		});
  	}
	</script>
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
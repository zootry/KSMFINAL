<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@include file="../header.jsp" %>
<html lang="ko">
	<head>
    <title>Pet Care</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">    
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/css/animate.css">   
    <link rel="stylesheet" href="/css/owl.carousel.min.css">
    <link rel="stylesheet" href="/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="/css/magnific-popup.css">
    <link rel="stylesheet" href="/css/jquery.timepicker.css">
    <link rel="stylesheet" href="/css/flaticon.css">
    <link rel="stylesheet" href="/css/style.css">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous">
	</script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
    <script>
    var selectedImages = [];
	var imgNum = 0;
	$(function(){
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
		
		$("#plus").on("click", function(){
			$("#upload").click();	
		});
		
	});
	function attachX(imgObj, imgNum){
		$(imgObj).append("<div id='X' class='img bi bi-dash-circle-fill text-danger text-right px-1' onclick='deleteClick(this, "+ imgNum +");'></div>");
	}
	function ditachX(){
		$("#X").remove();
	}
	function deleteClick(imgObj, i){
		$(imgObj).parents('.selectedImg').remove();
		selectedImages.splice(i, 1);
	}
	function preview(imageArr){
		var html = "";
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
	function submit(){
		var formData = new FormData();
		var dl_seq = $("#dl_seq").val();
		for(var i=0; i<selectedImages.length; i++){
			if(selectedImages[i] != undefined){
				formData.append("multipartFiles", selectedImages[i]);
			}
		}
		formData.append("content", $("#content").val());
		formData.append("star",$("input[name='star']:checked").val());
		formData.append("dolbomyEmail",$("#dolbomyEmail").val());
		formData.append("dolbomy",$("#dolbomy").text());
		formData.append("dl_seq",dl_seq);
		$.ajax({
			type : "POST",
			url : "/review/write.json",
			data : formData,
			processData : false,
			contentType : false,
			success : function(data){
				if(data){
					location.href="/review/content.do?cr_seq=CR"+dl_seq;
				}
			}
		});
	}
    
    </script>
    
    <style>
 .star-input{
	padding: 25px 15px;
}

.star-input>.input{
/*text-align: center;*/
    margin-top: 10px;
}

.star-input>.input,
.star-input>.input>label:hover,
.star-input>.input>input:focus+label,
.star-input>.input>input:checked+label{display: inline-block;vertical-align:middle;background:url('../images/grade_img.png')no-repeat;}
.star-input {
    width: 100%;
    /*text-align: center;*/
}

.score{font-size:18px; line-height:25px; #fc4c4e; font-weight:bold; text-align:center;}

.star-input>.input{display:inline-block;width:150px;background-size:150px;height:28px;white-space:nowrap;overflow:hidden;position:relative;}
.star-input>.input>input{position:absolute;width:1px;height:1px;opacity:0;}
.star-input>.input.focus{outline:1px dotted #ddd;}
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
	opacity: .8;
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
            <div class="headtitle"><h3>돌보미 후기 등록</h3></div>
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
							<input type="radio" name="star" value="1" id="p1">
							<label for="p1">1</label>
							<input type="radio" name="star" value="0.5" id="p1_2">
							<label for="p1_2">0.5</label>
							<input type="radio" name="star" value="2" id="p2">
							<label for="p2">2</label>
							<input type="radio" name="star" value="1.5" id="p2_2">
							<label for="p2_2">1.5</label>
							<input type="radio" name="star" value="3" id="p3">
							<label for="p3">3</label>
							<input type="radio" name="star" value="2.5" id="p3_2">
							<label for="p3_2">2.5</label>
							<input type="radio" name="star" value="4" id="p4">
							<label for="p4">4</label>
							<input type="radio" name="star" value="3.5" id="p4_2">
							<label for="p4_2">3.5</label>
							<input type="radio" name="star" value="5" id="p5">
							<label for="p5">5</label>
							<input type="radio" name="star" value="4.5" id="p5_2">
							<label for="p5_2">4.5</label>
						</span>
					</div>
		        </div>
		    </div>	
				<input type="hidden" id="dolbomyEmail" name="dolbomyEmail" value="${dlist.dolbomy}">
				<!-- <input type="hidden" id="dolbomy" name="dolbomy" value="${dolbomyNick}"> -->
				<input type="hidden" id="dl_seq" name="dl_seq" value="${dlist.dl_seq}">
				<!-- 
				<div class="col-12 form-label m-0 p-0">후기를 작성할 돌보미는?</div>
					<input type="text" id="dolbomy" name="dolbomy" value="${dolbomyNick}" readonly>
				<div class="col-12 form-label m-0 p-0">돌봄 시간을 확인해주세요</div>
					<p>${dlist.workdate}</p>
				 -->
				<div class="col-12 form-label m-0 p-0">자세한 후기를 작성해주세요</div>
				<div class="col-12 mb-md-4 mb-2">
				    <div class="row">
					<textarea class="col-12 form-control" id="content" placeholder="내용을 입력해주세요" rows="10" style="resize:none"></textarea>
					</div>	
			    </div>
				<!-- 
				<div class="mb-3">
				<label for="content"></label><!-- <label> input 태그를 제어하여 상태를 변경하게 도와줌 
				<textarea class="form-control" rows="10" name="content"
					id="content" style="resize: none" placeholder="내용을 입력해 주세요"></textarea>
				</div>
				 -->
				<div class="col-12 form-label m-0 p-0">사진을 등록해주세요</div>
				<div class="col-12 mb-4">
				<div id="imageList" class="row rounded border bg-white">
		      		<div id="plus" class="plus box-wrap col-md-2 col-3"><div class="plus box border rounded"><div class="img row text-center"><span class="plus col-12 bi bi-plus-lg align-self-center"></span></div></div></div>
		      		<input class="form-control" type="file" id="upload" style="display:none" multiple accept=""/>
	      		</div>
	      		</div>			
				<div class="d-flex justify-content-center">
					<input type="button" id="btnSave" class="btn text-black rounded-pill px-4 text-white" style="background-color:#a091f3;border:none;" value="저장" onclick="submit()">
				</div>
			</div>
		</div>
	</section>
		<%@include file="../footer.jsp"%>
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
  <script src="/js/owl.carousel.min.js"></script>
  <script src="/js/jquery.magnific-popup.min.js"></script>
  <script src="/js/scrollax.min.js"></script>
  <script src="/js/main.js"></script>
</body>
</html>
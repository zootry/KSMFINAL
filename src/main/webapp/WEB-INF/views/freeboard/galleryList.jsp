<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Pet Care</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.8.1/baguetteBox.min.css">
<link rel="stylesheet" href="/css/animate.css">
<link rel="stylesheet" href="/css/owl.carousel.min.css">
<link rel="stylesheet" href="/css/owl.theme.default.min.css">
<link rel="stylesheet" href="/css/magnific-popup.css">
<link rel="stylesheet" href="/css/jquery.timepicker.css">
<link rel="stylesheet" href="/css/flaticon.css">
<link rel="stylesheet" href="/css/style.css">
<!-- 부트스트랩 아이콘 스타일시트 추가-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<script src="/js/jquery.min.js"></script>
<style>
#page-title {
	padding-bottom:30px;
}
.col-sm-6.col-md-4 {
	margin-bottom:25px;
	display:none;
}
.card {
	box-shadow: 0 4px 6px 0 rgba(22, 22, 26, 0.18);
	border-radius: 0;
	border: 0;
	transition: transform 0.2s ease;
}
.card-img.scale {
  height: 300px;
  object-fit: cover;
  
}
.card:hover {
   transform: scale(1.05);
   transition: transform 0.3s;
   filter: brightness(0.7);
}
#contentTitle {
      display: -webkit-box;
      display: -ms-flexbox; 
      display: box;
      max-height:90px;
      overflow:hidden; /*오버되는 글 숨기기 */
      text-overflow:ellipsis; /*ellipsis=생략  */
      word-break:break-all; /*텍스트가 내용 상자를 넘칠 때마다 줄 바꿈을 표시할지 여부를 설정  */
      -webkit-box-orient:vertical;
      -webkit-line-clamp:1 /* 2줄 이상은 ... 처리 */
 }
/*Content Modal*/
.modal-body{
	margin:0;
	padding:0;
}
.modal-body-text{
	margin:0;
	padding:15px;
	/*overflow:hidden;*/
}
.modal-body p {
    word-wrap: break-word;
}
.rounded-circle{
	width:35px;
	height:35px;
	margin-right:10px;
}
.realtime-text{
	color:light-gray;
}
/*Write Modal*/
.modal-body#writeModalBody{
	padding:10px;
}
#heart{
	color:#ff2b53;
}

</style>

</head>
<body>
<%@include file="../header.jsp"%>
<section class="hero-wrap hero-wrap-2">
	<div class="container text-center d-flex justify-content-center">
		<div class="no-gutters align-items-end" style="margin-top:100px; border-bottom:solid 3px #c1b8f2;">
			<h1 class="mb-0 bread text-dark">갤러리</h1>
			<p class="breadcrumbs mb-2"><span class="text-dark">Gallery</span></p>
		</div>
	</div>
</section>

<section class="ftco-section">
	<div class="container">
		<c:choose>
			<c:when test="${sessionScope.email != null}">
				<div align="right">
					<button class="btn btn-primary btn-outline-primary btn-sm mb-3" onClick="location.href='/freeboard/galleryMyList'">내가 쓴 게시물</button>
					<button class="btn btn-primary btn-outline-primary btn-sm mb-3" onClick="location.href='/freeboard/galleryWrite'">게시물 작성</button> 
				</div>
			</c:when>	
			<c:otherwise>
			</c:otherwise>
		</c:choose>
		<!--갤러리 썸네일 시작-->
		<div class="row">
			<c:choose>
				<c:when test="${empty galleryList}">
					<div class="col-12 mt-5 mb-5">
						<h2 class="bi bi-exclamation-triangle-fill text-center" style="font-size:120px; color:#c1b8f2;"></h2>
						<h5 class="text-center">등록된 게시물이 없습니다. 첫 게시물을 <a href="/freeboard/galleryWrite" style="color:#a091f3">등록</a>해주세요!</h5>
					</div>
				</c:when>
				<c:otherwise>
					<c:forEach items="${galleryList}" var="gallery" varStatus="status">
						<div class="col-sm-6 col-md-4" id="imgThumnail">
							<div class="card text-white">
								<img src="/freeboard/display?imgNames=${imgNames[status.index]}" class="card-img scale" alt="${imgNames[status.index]}">
								<div class="card-img-overlay">
									<!-- Modal 클릭링크-->
									<a href="#myModal" class="modal-link" data-toggle="modal" 
									data-gseq="${gallery.g_seq}" data-email="${gallery.email}" data-cont="${gallery.content}" 
									data-likes="${gallery.likes}" data-wdate="${gallery.wdate}" data-imgs="${imgNames[status.index]}">
									<span class="card-text">
										<i class="bi bi-clock"></i>${gallery.wdate}
										<i class="bi bi-heart-fill"></i><span id="heart_Data${gallery.g_seq}">${gallery.likes}</span>
										<h5 class="card-title text-white" id="contentTitle"><b>${gallery.content}</b></h5>
									</span> 
									</a>
								</div>
							</div>	
						</div>
					</c:forEach>
					<button type="button" class="btn btn-primary btn-block bi bi-plus mt-3" id="readMore">더보기</button>
				</c:otherwise>
			</c:choose>
			<!--갤러리 썸네일 끝-->

			<!-- Modal 시작 -->
			<div class="modal fade" id="myModal">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
					<input type="hidden" id="gseq" value="gseq">
						<!-- Modal 헤더 -->
						<div class="modal-header">
							<img src="https://source.unsplash.com/user/erondu/400x300" class="rounded-circle" alt="img1" width="35px;" height="35px;">
							<h5><span class="modal-email" id="email"></span></h5> 
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<!-- Modal 바디 -->
						<div class="modal-body">
							<img src="" class="card-img" alt="imgs" id="imgs">
							<div class="modal-body-text">
								<div class="d-flex justify-content-between">
									<div class="modal-contentDate">
										<i class="bi bi-clock mr-1"></i><span class="modal-wdate" id="wdate"></span>
									</div>
									<c:choose>
										<c:when test="${sessionScope.email != null}">
											<div class="modal-contentLikes">
												<i id="heart" class="bi bi-heart mr-1" aria-hidden="true"></i><span class="modal-likes" id="likes"></span>
											</div>
										</c:when>
										<c:otherwise>
											<div class="modal-contentLikes">
												<i id="heart" class="bi bi-heart mr-1" onClick="AfterLogin();"></i><span class="modal-likes" id="likes"></span>
											</div>
										</c:otherwise>
									</c:choose>
									</div>
									<p class="modal-cont" id="cont"></p>
							</div>
						</div>
					</div>
				</div>
			</div>
		<!-- Modal 끝 -->
		</div>
	</div>
</section>
<%@include file="../footer.jsp"%>

<!-- loader -->
<div id="ftco-loader" class="show fullscreen">
	<svg class="circular" width="48px" height="48px">
		<circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee" />
		<circle class="path" cx="24" cy="24" r="22" fill="none"	stroke-width="4" stroke-miterlimit="10" stroke="#F96D00" /></svg>
</div>
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
<script>
function AfterLogin(){
	alert("기능을 사용할 권한이 없습니다. 로그인 후 이용해주세요.");	
	window.location.href = "/member/login.do";
}
var likesSwitch = false;
var b_seq ="";
/* .modal-link에서 데이터 뽑아서 각 태그에 뿌려줌 */
$(".modal-link").click(function(){
	var gseq = $(this).data('gseq');
	var email = $(this).data('email');
	var cont = $(this).data('cont');
	var likes = $(this).data('likes');
	var wdate = $(this).data('wdate');
	var imgs = $(this).data('imgs'); 
	var imgSrc = "/freeboard/display?imgNames="+imgs;
	console.log("gseq:"+gseq+" email:"+email+" cont:"+cont+" wdate:"+wdate+" imgs:"+imgs+" likes:"+likes);
	
	/* 하트가 바뀌는곳 */
	$.ajax({
		url: "/freeboard/hasLike.json",
		data:{
			b_seq: gseq
		},
		success: function(data){
			console.log("@hasLike:"+data.hasLike);
			if(data.hasLike) {
				console.log("하트 색깔 바뀜");
				$("#heart").removeClass("bi-heart").addClass("bi-heart-fill");
			}else{
				$("#heart").removeClass("bi-heart-fill").addClass("bi-heart");
			}
			likesSwitch = data.hasLike;
			b_seq = gseq;
			$(".modal-likes#likes").html(data.likesone);
		}
	});
	
	$(".modal-gseq#gseq").html(gseq);
	$(".modal-email#email").html(email);
	$(".modal-cont#cont").html(cont);
    //$(".modal-likes#likes").html(likes);
    $(".modal-wdate#wdate").html(wdate);
    $(".card-img#imgs").attr("src", imgSrc);
    
});
$("#heart").on("click", function(){
	var type = "";
	if(!likesSwitch){
		console.log("+1");
		type = "plus";
		likesSwitch = true;
	}else if(likesSwitch){
		console.log("-1");
		type = "minus";
		likesSwitch = false;
	}
	console.log("@@b_seq: "+b_seq);
	console.log("@@likesSwitch: "+likesSwitch);
	$.ajax({
			url: "/freeboard/likes.json",
			type: "POST",
			data:{
				b_seq: b_seq,
				type:type,
				email: "${sessionScope.email}"
			},
			success: function(data){
				//console.log("likes"+datalikes+"개");
				if(!likesSwitch){
					$("#heart").removeClass("bi-heart-fill").addClass("bi-heart");
				}else{
					$("#heart").removeClass("bi-heart").addClass("bi-heart-fill");
				}
				$(".modal-likes#likes").html(data.likesone);
				$("#heart_Data"+data.gseq).html(data.likesone);
			}
	})
});
/* 더보기 버튼 */
$(function(){
    $(".col-sm-6.col-md-4").slice(0, 9).show();
    $("#readMore").click(function(e){
        e.preventDefault();
        $(".col-sm-6.col-md-4:hidden").slice(0, 9).show();
        if($(".col-sm-6.col-md-4:hidden").length == 0){
        	$("#readMore").css('display','none');
        }
    });
});
</script>
</body>
</html>
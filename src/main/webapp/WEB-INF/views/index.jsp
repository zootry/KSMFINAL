<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Pet Care</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>   
<link href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> 
<link rel="stylesheet" href="/css/animate.css">    
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>   
<link rel="stylesheet" href="/css/owl.carousel.min.css">
<link rel="stylesheet" href="/css/owl.theme.default.min.css">
<link rel="stylesheet" href="/css/magnific-popup.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">   
<link rel="stylesheet" href="/css/bootstrap-datepicker.css">
<link rel="stylesheet" href="/css/jquery.timepicker.css">
<link rel="stylesheet" href="/css/flaticon.css">
<link rel="stylesheet" href="/css/style.css">
<script src="/js/jquery.min.js"></script>
<style>
	.rating .star {
	width: 0;
	overflow: hidden;
	}
	.rating .star-wrap {
	width: 18px;
	display: inline-block;
	}
	.bi-star-fill {
	color: red;
	}
	.outer {
	 text-align: center;
	}
	.text-dark {
      display: -webkit-box;
      display: -ms-flexbox;
      display: box;
      max-height:90px;
      overflow:hidden;
      text-overflow:ellipsis;
      word-break:break-all;
      -webkit-box-orient:vertical;
      -webkit-line-clamp:2
	 }
	a.blog-img{
	border-radius:50%;
	}
	.hero-wrap hero-wrap-2{
	background-color:green;
	}
	a.text-dark:hover, a.text-dark:focus{
		color: purple !important;
	}
	#my_img {filter: brightness(1);}
	#my_img:hover { filter: brightness(0.5);}
</style>
</head>
<body>

	<%@include file="header.jsp"%>
	<div class="hero-wrap js-fullheight" style="background-image: linear-gradient(rgba(23, 17, 46, 0.5), rgba(23, 17, 46, 0.5)), url('/images/bg_1.jpg');" data-stellar-background-ratio="0.5">
		<div class="container">
			<div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center"	data-scrollax-parent="true">
				<div class="col-md-11 ftco-animate text-center">
					<h3 class="mb-2 text-white">믿음직한 이웃 돌봄메이트,</h3>
					<h1 class="mb-4"><span style="color:#a091f3"><b>우리동네돌보미</b></span>에서 찾아보세요!</h1>
				</div>
			</div>
		</div>
	</div>

	<section class="ftco-section bg-light ftco-no-pt ftco-intro">
		<div class="container">
			<div class="row">
				<div class="col-md-4 d-flex align-self-stretch px-4 ftco-animate">
					<div class="d-block services text-center">
						<div class="icon d-flex align-items-center justify-content-center">
							<span class="flaticon-blind"></span>
						</div>
						<div class="media-body">
							<h3 class="heading">우리동네돌보미</h3>
							<p>
								<span class="text mb-3">
									<small>우리동네 주변에는 어떤 돌보미가 있을까?</small><br>
								</span>
								<b>돌봄을 주고받을 이웃 반려가족을 찾아<br>도움을 요청해보세요!</b>
							</p>
						</div>
					</div>
				</div>
				<div class="col-md-4 d-flex align-self-stretch px-4 ftco-animate">
					<div class="d-block services text-center">
						<div class="icon d-flex align-items-center justify-content-center">
							<span class="flaticon-dog-eating"></span>
						</div>
						<div class="media-body">
							<h3 class="heading">갤러리</h3>
							<p>
								<span class="text mb-3">
									<small>우리동네 반려동물들은 어떨까?</small><br>
								</span>
								<b>언제, 어디서나 이웃과의 활발한 교류를 즐기세요!</b>
							</p>
						</div>
					</div>
				</div>
				<div class="col-md-4 d-flex align-self-stretch px-4 ftco-animate">
					<div class="d-block services text-center">
						<div class="icon d-flex align-items-center justify-content-center">
							<span class="flaticon-grooming"></span>
						</div>
						<div class="media-body">
							<h3 class="heading mb-3">나눔 마켓</h3>
							<p>
								<span class="text">
									<small>도움이 필요할 때 받고, 줄 수 있을 때 베풀자!</small><br>
								</span>
								<b>이웃과 서로의 든든한 돌보미가 <br>되어보세요!</b>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center pb-5 mb-3">
				<div class="col-md-7 heading-section text-center ftco-animate">
					<h3>
						<b><span style="color:#a091f3">우리동네돌보미</span></b>의 후기가 궁금하신가요?
					</h3>
				</div>
			</div>
			<div class="row" id="reviewRow">
				<c:forEach items="${list}" var="carereview" varStatus="status" begin="0" end="2" step="1">
					<div class="col-12 col-md-4 ftco-animate">
						<div class="blog-entry align-self-center p-2">
				   	 		<c:choose>
	    						<c:when test="${empty fnames[status.index]}">
	    							<a href="content.do?cr_seq=${carereview.cr_seq}" class="block-20 rounded"
										style="background-image: url('/images/img.jpg');">
									</a>
	    						</c:when>
	    						<c:otherwise>
	    							<a href="/review/content.do?cr_seq=${carereview.cr_seq}" class="block-20 rounded mb-3"
										style="background-image: url('/review/display?imgName=${fnames[status.index]}');">
									</a>
    							</c:otherwise>
    						</c:choose> 
							<div class="d-flex justify-content-between">
								<h5 class="m-0 align-self-center fw-bold">${carereview.writer}님의 후기</h5>
								<div class="review" style="text-align:center">
									<div class="rating" data-rate="${carereview.star}">									  
									      <div class='star-wrap'><div class="star"><i class="bi bi-star-fill"></i></div></div>
									      <div class='star-wrap'><div class="star"><i class="bi bi-star-fill"></i></div></div>
									      <div class='star-wrap'><div class="star"><i class="bi bi-star-fill"></i></div></div>
									      <div class='star-wrap'><div class="star"><i class="bi bi-star-fill"></i></div></div>
									      <div class='star-wrap'><div class="star"><i class="bi bi-star-fill"></i></div></div>
									</div>
								</div>
							</div>
							<div><a class="text-dark" href="/review/content.do?cr_seq=${carereview.cr_seq}"  style="height:90px;">${carereview.content}</a></div>
							<div class="d-flex justify-content-end">${carereview.wdate}</div>
						</div>
					</div>
				 </c:forEach>
			</div>
		</div>
	</section>

	<%@include file="footer.jsp"%>

	<!-- loader -->
	<div id="ftco-loader" class="show fullscreen">
		<svg class="circular" width="48px" height="48px">
			<circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee" />
			<circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00" /></svg>
	</div>
	<script>
		   $(function(){
			      var rating = $('.rating');
			      
			      rating.each(function(){
			         var $this = $(this);
			         var targetScore = $this.attr('data-rate');
			         var firstdigit = targetScore.split('.');
			         console.log(firstdigit);
			         if(firstdigit.length>1){
			            for(var i=0;i<firstdigit[0];i++){
			               $this.find('.star').eq(i).css({width:'100%'});
			            }
			            $this.find('.star').eq(firstdigit[0]).css({width:firstdigit[1]+'0%'});
			         }else{
			            for(var i=0;i<targetScore;i++){
			               $this.find('.star').eq(i).css({width:'100%'});
			            }
			         }
			      });
			   });
	</script>
	
	
	<script src="js/jquery-migrate-3.0.1.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.easing.1.3.js"></script>
	<script src="js/jquery.waypoints.min.js"></script>
	<script src="js/jquery.stellar.min.js"></script>
	<script src="js/jquery.animateNumber.min.js"></script>
	<script src="js/owl.carousel.min.js"></script>
	<script src="js/jquery.magnific-popup.min.js"></script>
	<script src="js/scrollax.min.js"></script>
	<script src="js/main.js"></script>

</body>
</html>

<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	/*.ftco-animate{
		display:none;
	}*/
	</style>
</head>

	<body>
		<%@include file="../header.jsp"%>
	
	<section class="hero-wrap hero-wrap-2 bg-light">
      <div class="container text-center d-flex justify-content-center">
        <div class="no-gutters align-items-end" style="margin-top:100px; border-bottom:solid 3px #c1b8f2;">
      		<h1 class="mb-0 bread text-dark">돌보미 후기</h1>
      		<p class="breadcrumbs mb-2"><span class="text-dark">Review</span></p>
        </div>
      </div>
    </section>
		
		<section class="ftco-section bg-light">
			<div class="container">
			<div class="shadow bg-white p-5">
			<form action="/review/list.do" method="get">
			<div class="outer d-flex justify-content-between pb-2">
				<div id="searchSelect" class="d-flex col-12 col-md-2 key-box align-self-center pr-1">
					<select name="category" class="form-select border-0 p-0" aria-label="Default select example" style="font-size:14px;height:52px;">
						<option value="content" ${category eq 'content' ? 'selected' : ''}>내용</option>
						<option value="dolbomy" ${category eq 'dolbomy' ? 'selected' : ''}>돌보미</option>
						<option value="all" ${category eq 'all' ? 'selected' : ''}>내용+돌보미</option>
					</select>
				</div>
				<div class="d-flex col-12 col-md-4 pt-3">
				
					<input type="text" class="word form-control border-0 p-0 align-self-center" placeholder="검색어를 입력해주세요" name="keyword" size="40" required="required" id="keyword" value="${keyword}" />			
					<button id="searchBtn" type="submit" class="btn bi bi-search-heart fs-5 text-secondary px-2 py-0"></button>
					<button type="button" id="write" class="btn bi bi-pencil fs-5 text-secondary px-2 py-0" onclick="location.href='/review/writeList';"></button>
					<button type="button" id="resetBtn" class="btn bi bi-arrow-clockwise fs-5 text-secondary px-2 py-0"></button>
				</div>
				<div class="col-12 col-md-4">
				<div class="text-end">
					<a href="#none" onclick="searchOrder(this)">최신순</a>&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp
					<a href="#none" onclick="searchOrder(this)">별점순</a>&nbsp&nbsp&nbsp
				</div>
				</div>	
			</div>
			</form>
				<div class="row" id="reviewRow">
					<c:forEach items="${list}" var="carereview" varStatus="status">
						<div class="col-12 col-md-4 ftco-animate">
							<div class="blog-entry align-self-center p-2">
					   	 		<c:choose>
		    						<c:when test="${empty fnames[status.index]}">
		    							<a href="content.do?cr_seq=${carereview.cr_seq}" class="block-20 rounded"
											style="background-image: url('/images/img.jpg');">
										</a>
		    						</c:when>
		    						<c:otherwise>
		    							<a href="content.do?cr_seq=${carereview.cr_seq}" class="block-20 rounded mb-3"
											id="my_img" style="background-image: url('/review/display?imgName=${fnames[status.index]}');">
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
								<div><a class="text-dark" href="content.do?cr_seq=${carereview.cr_seq}" style="height:90px;">${carereview.content}</a></div>
								<div class="d-flex justify-content-end">${carereview.wdate}</div>
								<div class="col-12 border-top my-2"></div>
								<div class="align-self-center">
									<div>이 후기의 돌보미가 궁금하신가요?</div>
									<div class="bg-light">
										<div class="block-21 d-flex" style="margin:10px;">
								            <c:choose>
						    				<c:when test="${empty dprofile[status.index]}">
						    					<a class="blog-img mr-4" style="background-image: url(/images/profile160.png)"></a>
					    					</c:when>
					    					<c:otherwise>
					    						<a class="blog-img mr-4" style="background-image: url(/review/display?imgName=${dprofile[status.index]})"></a>
					    					</c:otherwise>
					    					</c:choose>
								            <div class="text">
								            	<h3 class="heading m-0">
								            		<span id="dolbomy">${carereview.dolbomy}</span>&nbsp;|&nbsp;${carereview.addr}
								            	</h3>
								            	<div class="recentContents">
								            		<div><i class="bi bi-star-fill" style="color:#f2b313"></i>${carereview.sat}&nbsp;(후기 ${carereview.reviews}건)</div>
								            		<div>GIVE ${carereview.give} | TAKE ${carereview.take}</div>
								            	</div>
								            </div>
								        </div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			</div>
		</section>

		<%@include file="../footer.jsp"%>

		<!-- loader -->
		<div id="ftco-loader" class="show fullscreen">
			<svg class="circular" width="48px" height="48px">
			<circle class="path-bg" cx="24" cy="24" r="22" fill="none"
					stroke-width="4" stroke="#eeeeee" />
			
			<circle class="path" cx="24" cy="24" r="22" fill="none"
					stroke-width="4" stroke-miterlimit="10" stroke="#F96D00" /></svg>
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
			   $(function(){//리셋버튼 기능 구현 
				 	$("#resetBtn").on("click", function(){
				 		location.href="list.do?cp=1&searchModeStr=F";
				 	});
				});
		</script>
		<script>

	function searchOrder(ord){
		var order = $(ord).text();
		$.ajax({
			type: 'get',
			url: "../review/searchOrder.json",
			data: {order:order},
			success: function(results) {
				var html="";
				$.each(results.list, function(idx, review){				
					html+="<div class='col-4 ftco-animate fadeInUp ftco-animated'>";
					html+="<div class='blog-entry align-self-center p-2'>";
					html+="<a href='content.do?cr_seq="+review.cr_seq+"' class='block-20 rounded mb-3' id='my_img' style='background-image: url(\"/review/display?imgName="+results.fnames[idx]+"\")';></a>";
					html+="<div class='d-flex justify-content-between'>";
					html+="<h5 class='m-0 align-self-center fw-bold'>"+review.writer+"님의 후기</h5>";
					html+="<div class='review' style='text-align:center'>";
					html+="<div class='rating' data-rate="+review.star+">";
					
					if(review.star==0){
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
						
					}else if(review.star==0.5){
						html+="<div class='star-wrap'><div class='star' style='width: 50%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
					}else if(review.star==1){
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
						
					}else if(review.star==1.5){
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star' style='width: 50%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
						
					}else if(review.star==2){
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
						
					}else if(review.star==2.5){
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star' style='width: 50%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
					}else if(review.star==3){
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
						
					}else if(review.star==3.5){
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star' style='width: 50%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
					}else if(review.star==4){
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star'><i class='bi bi-star-fill'></i></div></div>";
					}else if(review.star==4.5){
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star' style='width: 50%;'><i class='bi bi-star-fill'></i></div></div>";
						
					}else if(review.star==5){
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
						html+="<div class='star-wrap'><div class='star' style='width: 100%;'><i class='bi bi-star-fill'></i></div></div>";
					}

					html+="</div>";
					html+="</div>";
					html+="</div>";
					html+="<div><a class='text-dark' href='content.do?cr_seq="+review.cr_seq+"'>"+review.content+"</a></div>";
					html+="<div class='d-flex justify-content-end'>"+review.wdate+"</div>"; //Date타입은 ajax에서 읽을 수 없음! String타입으로 형태 변환해서 읽어야함 domain에 있는 vo dto에 date타입 바로 위에 한줄코드 추가 
					//한줄코드=@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
					html+="<div class='col-12 border-top my-2'></div>";
					html+="<div class='align-self-center'>";
					html+="<div>이 후기의 돌보미가 궁금하신가요?</div>";
					html+="<div class='bg-light'>";
					html+="<div class='block-21 d-flex' style='margin:10px;''>";
					if(results.dprofile[idx] == null){
						html+="<a class='blog-img mr-4' style='border-radius:50%;background-image: url(/images/profile160.png)'></a>";
					}else{
						html+="<a class='blog-img mr-4' style='border-radius:50%;background-image: url(/review/display?imgName="+results.dprofile[idx]+"')'></a>";
					}
					html+="<div class='text'>";
					html+="<h3 class='heading m-0'>";
 					html+="<span id='dolbomy'>"+review.dolbomy+"</span>&nbsp;|&nbsp;"+review.addr;
 					html+="</h3>";
 					html+="<div class='recentContents'>";
 					html+="<div><i class='bi bi-star-fill' style='color:#f2b313'></i>"+review.sat+" (후기 "+review.reviews+"건)</div>";
 					html+="<div>GIVE "+review.give+" | TAKE "+review.take+"</div>";
					html+="</div>";
					html+="</div>";
					html+="</div>";
					html+="</div>";
					html+="</div>";
					html+="</div>";
					html+="</div>";
				});
				//html += '<button type="button" class="btn btn-primary btn-block bi bi-plus mt-3" id="readMore">더보기</button>';
				

				$('#reviewRow').html(html);
				
			},
			error: function(request, status, error) {
				alert(error);
			}
		});
	}
	/* 더보기 버튼 */
	/*$(function(){
	    $(".ftco-animate").slice(0, 6).show();
	    $("#readMore").click(function(e){
	        e.preventDefault();
	        $(".ftco-animate:hidden").slice(0, 6).show();
	        if($(".ftco-animate:hidden").length == 0){
	        	$("#readMore").css('display','none');
	        }
	    });
	});*/
	</script>
		
		
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
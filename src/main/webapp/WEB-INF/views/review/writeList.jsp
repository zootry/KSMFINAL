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

	<!-- jQuery --> 
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous">
	</script>
	<!-- 부트스트렙에서 아이콘 끌어올 때 필요한 코드 -->	 
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
    <style>
    .reviewTable{
    margin-top:50px;
    margin-bottom:50px;
    width: 100%;
	height: 400px;
	overflow: auto;
	/*margin:auto;*/
    }
	.reviewTable::-webkit-scrollbar {
	width: 10px;
	}
	.reviewTable::-webkit-scrollbar-thumb {
	background-color: #e4ebf5;
	border-radius: 10px;
	background-clip: padding-box;
	border: 2px solid transparent;
	}
    </style>
</head>

<body>
	<section class="hero-wrap hero-wrap-2">;
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-end">
          <div class="col-md-9 ftco-animate pb-5">
          	<p class="breadcrumbs mb-2"><span>Review List<i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-0 bread">돌봄 후기 리스트</h1>
          </div>
        </div>
      </div>
    </section>
	<section class="ftco-section ftco-no-pt ftco-no-pb">
    	<div class="container">
    		<div class="reviewTable">
	            <table class="table table-hover">
	               	<thead style="background: linear-gradient(to bottom right, #97a3ea 20%, #a091f3 60%, #9283f2 90%) no-repeat; opacity:0.8;color:white;">
		               	<tr>
		               		<th>돌보미</th>
		               		<th>돌봄시간</th>
		               		<th>돌봄유형</th>
		               		<th>등록/보기</th>
		               	</tr>
	               	</thead>
	               	<tbody id="reviewTbody">
	               	<c:if test="${empty reviewList}">
	               		<tr><td colspan="5" align="center">작성할 후기가 없어요</td></tr>
	               	</c:if>
	               	<c:forEach items="${reviewList}" var="review">
	               		<tr>
		               		<td>${review.nickname}</td>
		               		<td>${review.workdate}</td>
		               		<td>${review.kind}</td>
		               		<c:choose>
			               		<c:when test="${review.state ne '후기등록'}">
			               			<td><a href="/review/write.do?dl_seq=${review.dl_seq}">후기 등록 ></a></td>
			               		</c:when>
			               		<c:otherwise>
			               			<td><a href="/review/content.do?cr_seq=CR${review.dl_seq}">후기 보기 ></a></td>
			               		</c:otherwise>
		               		</c:choose>
		               	</tr>
	               	</c:forEach>
		            </tbody>
		        </table>
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
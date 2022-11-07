<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
	<head>
    <title>Pet Care</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=yes">
    <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>   
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b19c96904445e8a8df0b446bb87c90bc"></script>
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
    <style>
    	.contenttop{
    		border-bottom: 1px solid #a091f3;
    	}
    	.contenttop h2{
    		margin-bottom: 20px;
    	}
    	.contenttop li{
    		list-style-type: none;
    		display: inline;
    	}
    	.contenttop li::before{
        	content: "|";
    	}
    	.contenttop li:first-child::before {
        	content: none
    	}
    	.contenttop ul{
    		list-style-type: none;
    	}
    	.contentfile{
		    text-align:right;
    	}
    	summary{
    		font-weight:700;
    	}
    	summary::marker{
    		content:"+";
    	}
    	.contentcenter{
    		padding:20px;
    	}
    	.btn{
    		float:right;
    	}
    	.btn:hover{
    		filter:brightness(0.9) !important;
    	}
    	.contentview{
    		white-space:pre-wrap;
    	}
    	#wdate{
    		text-align:right;
    	}
    	.bi-file-earmark-text{
    		border:none;
    	}
    	.dropdown-menu{
    		min-width:4rem;
    	}
    </style>
  </head>
  <body>
<%@include file="../header.jsp" %>
    
    <section class="hero-wrap hero-wrap-2 bg-light">
      <div class="container text-center d-flex justify-content-center">
        <div class="no-gutters align-items-end" style="margin-top:100px; border-bottom:solid 3px #c1b8f2;">
      		<h1 class="mb-0 bread text-dark">공지사항</h1>
      		<p class="breadcrumbs mb-2"><span class="text-dark">Notice</span></p>
        </div>
      </div>
	</section>
    
    <section class="ftco-section bg-light">
    <div class="container">

    <div class="contents shadow p-3 mb-3 bg-white">
    	<div class="contenttop">
    	<div class="d-flex justify-content-between">
    		<h2>${infolist.title}</h2>
    		<c:if test="${fn:contains(sessionScope.member.m_seq,'ADMIN') }">
	    		<div class="mt-2">
					<a class="text-primary mr-2" id="updateButton" onclick="location.href='/info/infoupdate.do?n_seq=${infolist.n_seq}'">
					수정</a>
					<a class="text-primary" id="deletebtn" onclick="location.href='/info/infodelete.do?n_seq=${infolist.n_seq}'">
					삭제</a>
				</div>
			</c:if>
		</div>
    		<div id="wdate">
    		${infolist.wdate}</div>
    	</div>
    	<c:choose>
    	<c:when test="${empty filelist}">
    	</c:when>
    	<c:otherwise>
    	<div class="contentfile">
	    		<button class="bi bi-file-earmark-text" type="button" data-bs-toggle="dropdown" aria-expanded="false">
	    		첨부파일
	    		</button>
	    		<ul class="dropdown-menu">
	    		<c:forEach var="filelist" items="${filelist}">
					<li><a href="download.do?fname=${filelist.fname}&ofname=${filelist.ofname}">${filelist.ofname}</a></li>
				</c:forEach>
				</ul>
    	</div>
    	</c:otherwise>
    	</c:choose>
    	<div class="contentcenter" style="height:300px;">
    		<div class="contentview">${infolist.content}</div>
    	</div>
		</div>
		<div class="d-flex justify-content-center">
			<button type="button" class="btn btn-primary rounded-pill px-4 text-white" id="listButton" onclick="location.href='/info/list.do'">
			목록</button>
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
<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <script type="text/javascript" language="javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  </head>
  <style>
	.px-4{
	padding:1.5rem;
	}
  </style>
<body>
<%@include file="../header.jsp" %>
	<section class="hero-wrap hero-wrap-2 bg-light">
      <div class="container text-center d-flex justify-content-center">
        <div class="no-gutters align-items-end" style="margin-top:100px; border-bottom:solid 3px #c1b8f2;">
      		<h1 class="mb-0 bread text-dark">돌보미 신청</h1>
      		<p class="breadcrumbs mb-2"><span class="text-dark">Apply Dolbom</span></p>
        </div>
      </div>
    </section>	
	<section class="ftco-section bg-light">
    	<div class="container">
    		<div class="row mb-5 pb-5">
          <div class="col-md-6 d-flex align-self-stretch px-4 ftco-animate">
            <div class="d-block services text-center">
              <div class="icon d-flex align-items-center justify-content-center">
            		<span class="flaticon-blind"></span>
              </div>
              <div class="media-body p-4 border-gray shadow-sm">
                <h3 class="heading">돌봄이 필요해요!</h3>
                <p>출장, 여행, 약속... 우리아이는 어떡하지?<br>
                	우리동네 돌보미에게 부탁해볼까요?</p>
                
                <c:choose>
        			<c:when test="${sessionScope.member.email != null}">
        				<c:choose>
        				<c:when test="${empty mydong}">
        					<a href="javascript:goSettingAddr();" class="btn-custom d-flex align-items-center justify-content-center"><span class="fa fa-chevron-right"></span><i class="sr-only">Read more</i></a>
        				</c:when>
        				<c:otherwise>
        					<a href="javascript:void(0);" onclick="check(this);" id="form_receiver.do" class="btn-custom d-flex align-items-center justify-content-center"><span class="fa fa-chevron-right"></span><i class="sr-only">Read more</i></a>
        				</c:otherwise>
        				</c:choose>
        			</c:when>
        			<c:otherwise>
        				<a href="javascript:alert('로그인 후 이용해주세요!')" class="btn-custom d-flex align-items-center justify-content-center"><span class="fa fa-chevron-right"></span><i class="sr-only">Read more</i></a>
        			</c:otherwise>
        		</c:choose>
                
              </div>
            </div>      
          </div>
          <div class="col-md-6 d-flex align-self-stretch px-4 ftco-animate">
            <div class="d-block services text-center">
              <div class="icon d-flex align-items-center justify-content-center">
            		<span class="flaticon-dog-eating"></span>
              </div>
              <div class="media-body p-4 border-gray shadow-sm">
                <h3 class="heading">돌보미가 될게요!</h3>
                <p>우리동네의 사랑스러운 아이들과 함께 <br>
                	행복한 여가시간을 보내 보시겠어요?</p>
                <c:choose>
        			<c:when test="${sessionScope.member.email != null}">
        			<c:choose>
        				<c:when test="${empty mydong}">
        					<a href="javascript:goSettingAddr();" class="btn-custom d-flex align-items-center justify-content-center"><span class="fa fa-chevron-right"></span><i class="sr-only">Read more</i></a>
        				</c:when>
        				<c:otherwise>
        					<a href="javascript:void(0);" onclick="check(this);" id="form_helper.do" class="btn-custom d-flex align-items-center justify-content-center"><span class="fa fa-chevron-right"></span><i class="sr-only">Read more</i></a>
        				</c:otherwise>
        			</c:choose>
        			</c:when>
        			<c:otherwise>
        				<a href="javascript:alert('로그인 후 이용해주세요!')" class="btn-custom d-flex align-items-center justify-content-center"><span class="fa fa-chevron-right"></span><i class="sr-only">Read more</i></a>
        			</c:otherwise>
        		</c:choose>
              </div>
            </div>    
          </div>
        </div>
        
    	</div>
    </section>
    
    <%@include file="../footer.jsp" %>
    <script>
    	function goSettingAddr(){
    		alert("돌보미 신청은 동네 설정 후 작성할 수 있어요.");
    		location.href="/address/setting";
    	}
    	function check(category){
    		var formUrl = category.id;
    		var count = "${count}";
    		if(formUrl=="form_receiver.do" && count == 0){
    			alert("반려동물 등록 후 작성할 수 있어요.");
    			location.href="/member/goSignupP.do";
    		}else{
    			location.href="/dolbom/"+formUrl;
    		}
    	}
    </script>

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

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
  <script src="/js/main.js"></script>  
  </body>
</html>
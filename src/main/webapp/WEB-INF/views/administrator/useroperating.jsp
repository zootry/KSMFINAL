<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
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
	
	<style>
/* 	.operating{ */
/* 		width:100%; */
/* 		text-align:left; */
/* 		margin:auto; */
/* 	} */
	.operating{
		display:flex;
		flex-direction:row;
		flex-wrap:wrap;
		margin-bottom:1rem;
	}
	input[type="text"]{
		width:100%;
		border:none;
		border-bottom: 1px solid rgba(0, 0, 0, 0.1);
	}
	.updatebtn{
		text-align:center;
	}
	.label {
	    color: #a091f3 !important;
	    text-transform: uppercase;
	    font-size: 12px;
	    font-weight: 600;
	}
	.col-md-6{
		margin-bottom:1rem;
	}
	.btn{
		border: 1px solid #dee2e6;
	}
	.btn:hover{
		filter:brightness(0.9) !important;
    	border: 1px solid #dee2e6;
	}
	</style>
  </head>
  <body>
<%@include file="../header.jsp" %>

<section class="ftco-section bg-light">
<c:if test="${fn:contains(sessionScope.member.m_seq,'ADMIN') }">
    <div class="container bg-white shadow py-3 px-5">
    	<form method="post" name="input" action="update.do">
    		<input type="hidden" id="m_seq" name="m_seq" value="${member.m_seq}">
			<div class="operating col-md-12">
				<div class="operating col-md-12">
					<h3>회원관리</h3>
				</div>
				<div class="col-md-6">
					<label class="label" for="name">NAME</label>
					<div class="input-group"><input type="text" class="form-control" name="name" id="name" value="${member.name}"></div>
				</div>
				<div class="col-md-6">
					<label class="label" for="gender">GENDER</label>
					<div class="input-group">
						<c:choose>
							<c:when test="${member.gender eq 'W'}">
								<input type="text" class="form-control" name="gender" id="gender" value="여성" disabled>
							</c:when>
							<c:otherwise>
								<input type="text" class="form-control" name="gender" id="gender" value="남성" disabled>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="col-md-6">
					<label class="label" for="email">EMAIL</label>
					<div class="input-group"><input type="text" class="form-control" name="email" id="email" value="${member.email}"></div>
				</div>
				<div class="col-md-6">
					<label class="label" for="nickname">NICKNAME</label>
					<div class="input-group"><input type="text" class="form-control" name="nickname" id="nickname" value="${member.nickname}"></div>
				</div>
				<div class="col-md-6">
					<label class="label" for="phone">PHONE</label>
					<div class="input-group"><input type="text" class="form-control" name="phone" id="phone" value="${member.phone}"></div>
				</div>
				<div class="col-md-6">
					<label class="label" for="addr">ADDRESS</label>
					<div class="input-group"><input type="text" class="form-control" name="addr" id="addr" value="${member.addr}"></div>
				</div>
				<div class="col-md-6">
					<label class="label" for="joindate">가입일</label>
					<div class="input-group"><input type="text" class="form-control" name="joindate" id="joindate" value="${member.joindate}" disabled></div>
				</div>
				<div class="col-md-6">
					<label class="label" for="sat">만족도</label>
					<div class="input-group"><input type="text" class="form-control" name="sat" id="sat" value="${member.sat}"></div>
				</div>
			</div>
			<div class="updatebtn">
				<button type="submit" class="btn text-black rounded-pill px-4 text-white" style="background-color:#a091f3">수정</button>
				<input type="button" class="btn text-black rounded-pill px-4 text-white" style="background-color:#a091f3" value="회원탈퇴" onClick="location.href='/admin/delete.do?m_seq=${member.m_seq}'">
				<input type="button" class="btn btn-light rounded-pill px-4 text-secondary" value="목록" onClick="location.href='/admin/userlist.do'">
			</div>
		</form>
	</div>
	</c:if>
</section>
<%@include file="../footer.jsp" %>


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
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="/js/google-map.js"></script>
  <script src="/js/main.js"></script>
  
  <script>
  $(document).ready(function(){
		var m_seq = "${sessionScope.member.m_seq}";
		if(!m_seq.includes("ADMIN")){
			alert("관리자만 볼 수 있습니다.");
			location.href="/";
		}
	});
  </script>
  
</body>
</html>
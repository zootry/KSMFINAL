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
	.report{
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
		    <form method="post" name="table input" action="content.do">
			<div class="report col-md-12">
				<div class="report col-md-12">
					<h3>신고 관리</h3>
				</div>
				<div class="col-md-6">
					<label class="label" for="rep_remail">신고자</label>
					<div class="input-group"><input type="text" class="form-control" name="rep_remail" id="rep_remail" value="${report.rep_remail}"></div>
				</div>
				<div class="col-md-6">
					<label class="label" for="rep_wemail">작성자</label>
					<div class="input-group"><input type="text" class="form-control" name="rep_wemail" id="rep_wemail" value="${report.rep_wemail}"></div>
				</div>
				<div class="col-md-4">
					<label class="label" for="rep_date">신고날짜</label>
					<div class="input-group"><input type="text" class="form-control" name="rep_date" id="rep_date" value="${report.rep_date}"></div>
				</div>
				<div class="col-md-4">
					<label class="label" for="rep_state">신고처리상태</label>
					<div class="input-group">
						<select id="rep_state" name="rep_state">
						<option value="미처리">미처리</option>
						<option value="처리중">처리중</option>
						<option value="처리완료">처리완료</option>
						</select>
						<input type="hidden" name="rep_seq" id="rep_seq" value="${report.rep_seq}">
					</div>
				</div>
				<div class="col-md-4">
					<label class="label" for="rep_state">처리날짜</label>
					<div class="input-group"><input type="text" class="form-control" name="rep_pdate" id="rep_pdate" value="${report.rep_pdate}"></div>
				</div>
				<div class="col-md-12">
					<label class="label" for="rep_pdate">신고이유</label>
					<div class="input-group"><input type="text" class="form-control" name="rep_reason" id="rep_reason" value="${report.rep_reason}"></div>
				</div>
				<div class="col-md-12">
					<label class="label" for="rep_pdate">신고내용</label>
					<div class="input-group"><input type="text" class="form-control" name="rep_content" id="rep_content" value="${report.rep_content}"></div>
				</div>
				<div class="col-md-12">
					<label class="label" for="rep_pdate">게시글</label>
					<div class="input-group"><a href="/dolbom/content.do?dol_seq=${report.rep_wseq}"  target='_blank'>${report.rep_wseq}</a></div>
				</div>
				<div class="col-md-12 d-flex justify-content-center pt-2">
						<button type="submit" class="btn btn-primary rounded-pill px-3 text-white">등록</button>
						<!-- <input type="button" class="btn btn-primary rounded-pill px-3 text-white" value="삭제" onClick="location.href='/report/delete.do?rep_seq=${report.rep_seq}'"> -->
						<input type="button" class="btn btn-light rounded-pill px-4 text-secondary" value="목록으로" onClick="location.href='/report/list.do'">
				</div>
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
		$("#rep_state").val("${report.rep_state}").prop("selected", true);
	});
	$(document).ready(function(){
		var m_seq = "${sessionScope.member.m_seq}";
		if(!m_seq.includes("ADMIN")){
			alert("관리자만 볼 수 있습니다.");
			history.back();
		}
	});
</script>
  
</body>
</html>
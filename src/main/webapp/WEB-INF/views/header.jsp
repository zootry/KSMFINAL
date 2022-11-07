<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.8.1/baguetteBox.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
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
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
 	<div class="wrap p-2">
		<div class="container">
			<div class="row">
				<c:choose>
					<%--로그인 상태 --%>
		  			<c:when test="${sessionScope.member.email != null || sessionScope.member.nickname != null}">
		  			<div class="col-6 d-flex justify-content-start text-white">
		  				<span><i class="fa fa-paw mr-2 pt-2" aria-hidden="true"></i>${sessionScope.member.nickname}님, 안녕하세요!</span>
		  			</div>
		  			<div class="col-6 d-flex justify-content-end text-white">
		    			<span class="d-flex align-items-center justify-content-center mr-3" id="logout-Btn" onclick="location.href = '/member/logout.do'" style="font-size:17px;cursor:pointer;">Logout</span>
		    			<span class="bi bi-chat-heart d-flex align-items-center justify-content-center mr-3" onClick="openChat();" style="font-size:24px;cursor:pointer;"></span>
		    			<span class="bi bi-person-fill d-flex align-items-center justify-content-center" id="mypage-Btn" onclick="location.href = '/member/mypage.do?m_seq=${sessionScope.member.m_seq}'" style="font-size:24px;cursor:pointer;"></span>
					</div>
		  			</c:when>
		  			<%--로그인 상태가 아닐 경우--%>
		  			<c:otherwise>
		  				<div class="col-6 d-flex justify-content-start text-white">
			  				<span class="mr-2"><i class="fa fa-paw mr-2"></i>우리동네돌보미</span>
			  			</div>
			  			<div class="col-6 d-flex justify-content-end text-white">
			  				<span class="mr-2" type="submit" id="login-Btn" onclick="location.href = '/member/login.do'" style="font-size:17px;cursor:pointer;">Login</span>
			  			</div>
		  			</c:otherwise>
			  	</c:choose>
			</div>
		</div>
	</div>
	<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light " id="ftco-navbar">
    <div class="container">
	    <div class="logo">
	    	<a href="/" class="imgLogoHref"><img src="/images/logo.png" class="imgLogo" style="width:200px;"></a>
	    	<!-- <a href="/" class="imgLogoHref"><img src="/images/logo2.png" class="imgLogo" style="width:200px;"></a> -->
	    </div>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
      	<span class="bi bi-list mr-3"></span>
      </button>
	<div class="collapse navbar-collapse" id="ftco-nav">
        <ul class="navbar-nav ml-auto">
        	<li class="nav-item dropdown">
			    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">우리동네돌보미</a>
			    <div class="dropdown-menu">
			      <a class="dropdown-item" href="/dolbom" id="dolbom">돌보미 찾기</a>
			      <a class="dropdown-item" href="/dolbom/form" id="dolbom">돌보미 신청</a>
			      <c:choose>
				      <c:when test="${empty sessionScope.email}">
				      <a class="dropdown-item" onclick="alert('로그인 후 이용해주세요!');return false;" href="void(0);" id="dolbom">돌보미 리스트</a>
				      </c:when>
				      <c:otherwise>
				      <a class="dropdown-item" href="/dolbom/list.do" id="dolbom">돌보미 리스트</a>
				      </c:otherwise>
			      </c:choose>
			    </div>
			</li>
        	<li class="nav-item"><a href="/review/list.do" class="nav-link" id="review">돌보미 후기</a></li>
        	<li class="nav-item"><a class="nav-link" id="market" style="cursor: pointer;">나눔 마켓</a></li>
          	<li class="nav-item"><a href="/freeboard/galleryList" class="nav-link" id="freeboard">갤러리</a></li>
			<li class="nav-item"><a href="/info/list.do" class="nav-link" id="info">공지사항</a></li>         	
          	<c:if test="${fn:contains(sessionScope.member.m_seq,'ADMIN') }">
          	<li class="nav-item"><a href="/admin/main.do" class="nav-link" id="admin">관리자</a></li> 
          	</c:if>   	
        </ul>
      </div>
    </div>
  </nav>
  <!-- END nav -->
  <script type="text/javascript">
  		const sessionAttrs = ["key", "word", "pageNum"];
        $(function () {
        	var url = $(location).attr("href").split('/')[3];
        	console.log("url"+url);
        	if(url=='dolbom'){
        		$('#'+url).parent().parent().toggleClass('active');
        	}else{
        		$('#'+url).parent().toggleClass('active');
        	}
           	$("#market").on("click", function(){
           		if($(location).attr("href").includes("market")) removeSession();
       			location.href="/market";
           	})
            if(!$(location).attr("href").includes("market")){
            	removeSession();
            }
        });     
        function removeSession(){
        	$.ajax({
    			url : "/market/removeSession.json",
    			type : "DELETE",
    			data : {
    				sessionAttrs : sessionAttrs
    			},
    			success : function(data){
    			}
    		});
        }
        function openChat(){
        	window.open("/room", '우리동네 돌보미 채팅', 'width=450px,height=515px,scrollbars=yes,location=no');
        }
  </script>
  
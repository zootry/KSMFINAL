<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
    <title>My Page</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <script src="/js/jquery.min.js"></script>
    <script type="text/javascript" language="javascript" 
		     src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js">
    </script>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> 
    <link rel="stylesheet" href="/css/animate.css">    
    <link rel="stylesheet" href="/css/owl.carousel.min.css">
    <link rel="stylesheet" href="/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="/css/magnific-popup.css">
    <link rel="stylesheet" href="/css/flaticon.css">
    <link rel="stylesheet" href="/css/style.css">
    

    <script>
    $(function(){
		var email = "${sessionScope.member.email}";
		$.ajax({
			url: "../member/checkPet.do",
			type: "GET",
			data: {email: email},
			dataType: "json",
			success: function(data){
				print(data);
			}
		});			
		
		
		var info = "${memberone}";
		$('#myinfo-Btn').click(function(){
			$.ajax({
				url: "myinfo.do",
				type: "post", 
				data: {info: info},
				success: function(data){
				}
			});
		});
		var imgsrc = $('#profile-image').attr('src');
		console.log('imgsrc: '+imgsrc.length);
		if(imgsrc.length == 24){
			$('#profile-image').attr('src', '/images/profile160.png');
		}
	});
    function print(results){
		var html="";
		if(results.lists.length == 0){
			//html += "<h5>등록된 펫이 없습니다</h5>";
			html += '<div class="testimony-wrap mb-3 py-4 col-md-4">'
			html += '<div class="d-flex justify-content-center px-3" style="border-style: dotted; border-color:#bdbdbd;">'
			html += '<a class="bi bi-plus-circle-fill" style="font-size:50px; color:#bdbdbd;" onclick="location.href = \'/member/goSignupP.do\'"></a>'
			html += '</div></div>';
			$("#container").html(html);
		}else{
			var today = new Date();
				
			$.each(results.lists, function(idx, list){
				html += '<div class="col-sm-6 col-md-4 mb-3">';
				html += '<div class="testimony-wrap py-3"><div class="d-flex align-items-center">';
				html += '<div class="user-img" style="background-image: url(/member/display?imgName='+list.fname+')" style="width:30rem; height:30rem;"></div>';
				html += '<div class="pl-3"><span class="name">'+list.pet.name+'</span>';
				html += '<span class="position">( '+list.pet.breed+' )  </span>';
				html += '<a class="bi bi-gear-fill" onclick="'+"location.href = '/member/updatePinfo.do?petseq="+list.pet.petseq+"'"+'"style="width:35px;"></span>';
				html += '<a class="bi bi-file-x" id="'+list.pet.petseq+'" name="deleteP")></a>';
				var age = today.getFullYear() - list.pet.byear;
				html += '<div><span class="position"> '+age+'살  | </span>';
				html += '<span class="position"> '+list.pet.big+' | </span>';	
				if(list.pet.sex == 'M'){
					html += '<span class="bi bi-gender-male"></span>';
				}else{
					html += '<span class="bi bi-gender-female"></span>';
				}
				html += '</div></div></div><p>* memo) '+list.pet.memo+'</p>';
				html += '</div></div></div>';
			});
			html += '<div class="testimony-wrap mb-3 py-4 col-md-4">'
			html += '<div class="d-flex justify-content-center px-3" style="border-style: dotted; border-color:#bdbdbd;">'
			html += '<a class="bi bi-plus-circle-fill" style="font-size:50px; color:#bdbdbd;" onclick="location.href = \'/member/goSignupP.do\'"></a>'
			html += '</div></div>';
			$("#container").html(html);
			$('a[name=deleteP]').on("click", function(){
    			var petseq = $(this).attr('id');
    			console.log("#seq: "+petseq);
    			$.ajax({
    				url: "deleteP.do?petseq="+petseq,
    				type: "GET",
    				success: function(){
    					alert("정보가 삭제 되었습니다");
    					document.location.reload();
    				}
    			});
    		});
		}			
	}    	
    </script>   
    <style>
    section.hero-wrap.hero-wrap-2 {
		margin-top: 100px;
		z-index: 1;
	}
	
	#timesDiv {
		width: 60%;
		margin: 0px auto;
	}
	
	.card {
		width: 5rem;
	}
	
	#profile-image {
		width: 150px;
		height: 150px;
	}
	
	#name h4 {
		margin-right: 10px;
	}
	
	.table .bg-white {
		padding: 10px;
	}
	
	.myPageDiv {
		margin-bottom: 80px;
	}
	.bi .bi-gear-fill {
		padding-left:2px;
		font-size:15px;
		font-color:dbdbdb;
	}
	.custom-table {
  	min-width: 900px; 
  	}
    </style> 
  </head>
  <body>
	<%@include file="../header.jsp" %>
  <!-- 회원정보수정 -->
  <div class="hero-wrap">
	<div class="container" style="height:700px">
		<div class="overlay"></div>
			<div class="row no-gutters slider-text align-items-center justify-content-center" data-scrollax-parent="true" style="height:800px">
				<div class="col-md-12 ftco-animate text-center">
					<div class="d-flex flex-column">
					<img src="/member/display?imgName=${profile[0].fname}" class="rounded-circle mx-auto d-block" id="profile-image" alt="">
						<div class="p-2">
							<div class="d-flex justify-content-center" id="greetDiv">
								<span class="name text-white"><h4>${memberone.nickname}님,반가워요!</h4></span>
								<span class="bi bi-gear-fill" id="myinfo-Btn" onclick="location.href = '/member/myinfo.do?m_seq=${sessionScope.member.m_seq}'"></span>
							</div>
							<c:choose>
				    			<c:when test="${empty mydong}">
				    				<span><a href="/address/setting" style="text-decoration:none;background-color:white;"><i class="bi bi-arrow-right-circle" aria-hidden="true"></i>&nbsp;내 동네 등록하기</a></span>
					    		</c:when>
				    			<c:otherwise><a href="/address/setting" style="text-decoration:none;background-color:white;"><span><i class="fa fa-map-marker" aria-hidden="true"></i>&nbsp;${mydong}</span></a></c:otherwise>
				    		</c:choose>
							<p><i class="fa fa-star text-gray" aria-hidden="true"></i>&nbsp;${memberone.sat}</p>
						</div>
						<div class="p-2 text-white rounded border border-white shadow" id="timesDiv">
							<div class="fa fa-hashtag" aria-hidden="true" id="diveDiv">GIVE	| 돌봄제공 : ${memberone.give}회</div>
							<div class="fa fa-hashtag" aria-hidden="true" id="takeDiv">Take | 돌봄요청 : ${memberone.take}회</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
  <!-- -->
  <section class="ftco-section bg-light">
		<div class="container">
			<!--반려동물정보/carousel사용-->
			<div class="myPageDiv">
				<div class="d-flex justify-content-between mb-3 border-bottom">
					<span><h4>마이펫정보</h4></span>
				</div>
				<div class="ftco-animate mb-5">
						<div class="row d-flex" id="container"></div>					
				</div>
				<!-- 
				<div class="pet-carousel">
					<div class="row ftco-animate">
						<div class="col-md-12">
							<div class="carousel-testimony owl-carousel ftco-owl">
								<div id="container"></div>
								
								<div class="item">
									<div class="testimony-wrap py-4">
										<div class="d-flex align-items-center">
											<div class="user-img" style="background-image: url(/images/brandy.jpeg)"></div>
											<div class="pl-3">
												<span class="name">브랜디</span>
												<a class="bi bi-gear-fill" onclick="location.href = '/member/goSignupP.do'"></a>
												<div>
													<span class="position">3살&nbsp;|&nbsp;</span>
													<span class="position">중형&nbsp;|&nbsp;</span> 
													<span class="position">수컷</span>
													<span class="bi bi-gender-female"></span>
												</div>
											</div>
										</div>
										<p>(memo) 견과류알러지 있음</p>
									</div>
								</div>
								<div class="item">
									<div class="testimony-wrap py-4">
										<div class="d-flex align-items-center">
											<div class="user-img" style="background-image: url(/images/pepper.jpeg)"></div>
											<div class="pl-3">
												<span class="name">페퍼</span>
												<a class="bi bi-gear-fill" onclick="location.href = '/member/goSignupP.do'"></a>
												<div>
													<span class="position">1살&nbsp;|&nbsp;</span>
													<span class="position">중형&nbsp;|&nbsp;</span> 
													<span class="position">수컷</span>
													<span class="bi bi-gender-male"></span>
												</div>
											</div> 
										</div>
										<p>(memo) 아무거나 잘먹음</p>
									</div>
								</div>
								
								<div class="item">
									<div class="testimony-wrap py-4">
										<div class="d-flex justify-content-center px-3" style="border-style: dotted;">
											<a class="bi bi-plus-circle-fill" aria-hidden="true" style="font-size:50px;" onclick="location.href = '/member/goSignupP.do'"></a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				 -->
			</div>
			<span id="deleteM" class="btn btn-link text-secondary p-0 ">> 회원탈퇴</span>
		</div>
	</section>
  
  <%@include file="../footer.jsp" %>

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px">
      <circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee" />
      <circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10"
        stroke="#F96D00" /></svg></div>
  <script>
	  $('#deleteM').click(function(){
			if(confirm("정말 탈퇴를 하시나요?") == true){
				$.ajax({
					url: "deleteM.do?m_seq=${sessionScope.member.m_seq}",
					type: "GET",
					success: function(){
						alert('그동안 우리동네돌보미를 이용해주셔서 감사합니다!');
						location.href='/';
					}
				});
		    }
		    else{
		        return ;
		    }	
		});
  </script>

  <script src="/js/trim.js"></script>
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
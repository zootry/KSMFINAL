<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
	<head>
    <title>Pet Care</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=yes">  
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
  
    <script>
    	$(function(){
    		if("${key}".length && "${word}".length){
    			if("${pageNum}".length){
    				getList("${pageNum}", 6, "${key}", "${word}");
    			}else{
					getList(1, 6, "${key}", "${word}");
    			}
        		if(!$("#searchRefreshBtn").length){
        			$("#searchDiv").prepend("<div id='searchRefreshBtn' class='col-12 col-md-12 align-self-center p-0 px-md-3 text-start'><button class='btn bi bi-arrow-clockwise fs-5 text-secondary p-0' onclick='clickMarket();'></button></div>");
    				$("#searchSelect").removeClass("col-12");
    				$("#searchSelect").addClass("col-10");
        		}
    		}else{
    			if("${pageNum}".length){
    				getList("${pageNum}", 6);
    			}else{
    				getList(1, 6);
    			}
    		}
    		$("#search").on("click", function(){
    			$(this).val("");
    		})
    		$(".bi-pencil").on("mouseenter", function(){
    			$(this).removeClass("bi-pencil");
    			$(this).addClass("bi-pencil-fill");
    			$(this).css("opacity", "0.5");
    		})
    		$(".bi-pencil").on("mouseleave", function(){
    			$(this).removeClass("bi-pencil-fill");
    			$(this).addClass("bi-pencil");
    			$(this).css("opacity", "1");
    			$(this).css("transform", "scale(1)");
    		})
    		$(".bi-search-heart").on("mouseenter", function(){
    			$(this).removeClass("bi-serch-heart");
    			$(this).addClass("bi-search-heart-fill");
    			$(this).css("opacity", "0.5");
    		})
    		$(".bi-search-heart").on("mouseleave", function(){
    			$(this).removeClass("bi-serch-heart-fill");
    			$(this).addClass("bi-search-heart");
    			$(this).css("opacity", "1");
    		})
    		$(".bi-arrow-clockwise").on("mouseenter", function(){
    			$(this).css("opacity", "0.5");
    		})
    		$(".bi-arrow-clockwise").on("mouseleave", function(){
    			$(this).css("opacity", "1");
    		})
    		$("#search, .bi-search-heart").on("keyup click", function(key){
    			if(key.keyCode == 13 || key.target.id == "searchBtn"){
    				getList(1, 6, $("#key").val(), $(".word").val());
    				if(!$("#searchRefreshBtn").length){
    					$("#searchDiv").prepend("<div id='searchRefreshBtn' class='col-12 col-md-12 align-self-center px-md-3 p-0 text-start'><button class='btn bi bi-arrow-clockwise fs-5 text-secondary p-0' onclick='clickMarket();'></button></div>");
	        			$("#searchSelect").removeClass("col-12");
	        			$("#searchSelect").addClass("col-10");
    				}
    			}
    		})
    		$("#setMyDong, #myDong").on("click", function(){
    			var msg="";
    			if("${member}".length){
    				location.href='/address/setting';	
    			}else{
					msg += "<div class='mb-3'>로그인 후 이용해 주세요 !</div>";
					msg += "<button type='button' class='badge text-white' style='background-color:#a091f3; onClick=location.href='/member/login.do'>로그인</button>";
    				showModal(msg);
    			}
    		})
    		$("#key").on("change", function(){
    			var html = "";
    			if($(this).val() == "category"){
    				$(".word").remove();
    				html += "<select class='word search form-select border-0 p-0' onChange='controlWord();' style='font-size:14px'>";
    				html += "<option value='식품'>식품</option>";
    				html += "<option value='의류'>의류</option>";
    				html += "<option value='장난감'>장난감</option>";
    				html += "<option value='가전제품'>가전제품</option>";
    				html += "<option value='가구'>가구</option>";
    				html += "<option value='티켓/쿠폰'>티켓/쿠폰</option>";
    				html += "</select>";
    				$(".key-box").next().append(html);
    			}else if(!$("#search").length){
    				$(".word").remove();
    				$(".key-box").next().append("<input type='text' class='word form-control border-0 p-0' id='search' placeholder='원하시는 물품을 검색해 보세요!' style='width:100%' onkeyup='controlWord(this);'>")
    			}
    		})
    		$("#write").on("click", function(){
    			if("${email}".length){
    				if("${myDong}".length == 0){
    					var msg = "";
    					msg += "<div class='mb-3'>동네 설정을 먼저 완료해 주세요 !</div>";
    					msg += "<button type='button' class='badge text-white' style='background-color:#a091f3' onClick=location.href='/address/setting'>동네 설정하기</button>";
    					showModal(msg);
    					return false;
    				}
    				location.href="/market/write";
    			}else{
    				showModal("로그인 후 이용해 주세요");
    			}
    		})
    	})
    	function controlWord(){
    		if(event.keyCode==13||event.type=="change"){
    			getList(1, 6, $("#key").val(), $(".word").val());
    			if(!$("#searchRefreshBtn").length){
    				$("#searchDiv").prepend("<div id='searchRefreshBtn' class='col-12 col-md-12 align-self-center px-md-3 p-0 text-start'><button class='btn bi bi-arrow-clockwise fs-5 text-secondary p-0' onclick='clickMarket();'></button></div>");
        			$("#searchSelect").removeClass("col-12");
        			$("#searchSelect").addClass("col-10");
    			}	
    		}else{
    			return false;
    		}
    	}
    	function clickMarket(){
    		$("#market").click();
    	}
    	function intoContent(cardObj){
    		location.href="/market/content?sm_seq="+$(cardObj).attr("id");
    	}
    	function getList(pageNum, pageSize, key, word){
    		$.ajax({
    			url : "/market/list.json",
    			type : "GET",
    			data : {
    				pageNum : pageNum,
    				pageSize : pageSize,
    				key : key,
    				word : word,
    				myDong : "${myDong}"
    			},
    			success : function(data){
    				updateList(data);
    			}
    		});
    	}
    	function getNumber(pageNum){
			getList(pageNum, 6);
		}
    	function showModal(text){
    		$(".modal-body").html("<span class='text-center'>"+text+"</span>");
			$("#modal").modal("show");
    	}
    	function updateList(results){
    		var html = "";
    		$("#list").empty();
    		$("#prevBtn").html("");
    		$("#nextBtn").html("");
    		$("#searchResultInfo").remove();
    		$("li").remove("#pageBtn");
    		
    		if(results.lists.length == 0){
    			if(("${key}".length && "${word}".length) || $(".bi-arrow-clockwise").length){
    				$("#list").append("<div class='py-5 text-center text-secondary'>검색된 결과가 없습니다.</div>");	
    			}else{
    				$("#list").append("<div class='py-5 text-center text-secondary'>새로운 게시글을 작성해 보세요.</div>");
    			}
    		}else{
    			if(("${key}".length && "${word}".length) || $(".bi-arrow-clockwise").length){
    				$("#key").val("${key}").prop("selected", true);
    				$("#search").val("${word}");
    				$("#searchResultInfo").remove();
					$("#searchDiv").append("<div id='searchResultInfo'class='col-12 px-3'>"+$("option").html()+" '"+results.word+"' 에 대한 검색 결과 (총 "+results.pagination.totalRowCounts+" 건)</div>");
				}
    			$.each(results.lists, function(idx, list){
    				html += "<div class='col-md-4 col-sm-6 px-md-2 px-0'>";
    				html += "<div id='"+list.sm_seq+"' class='border-0 shadow-sm card' onClick='intoContent(this);'>";
    				if(results.fnames[idx] == null){
    					html += "<div class='imgFrame bg-light p-5 text-center'><div class='bi bi-image px-5 pt-5 fs-5'></div><div>No Image Available</div></div>";
    				}else{    					
    					html += "<div class='imgFrame rounded-top'>";
    					html += "<img src='/market/display?imgName="+results.fnames[idx]+"' class='card-img-top'></div>";
    				}
    				html += "<div class='row row-md-12 card-body'>";
    				html += "<div class='card-title pl-1 pb-1 mb-3'><span class='card-title shadow-sm rounded-pill px-3 py-1' style='background-color:#d8d0ff75; color:darkslategray'>"+list.category+"</span></div>";
    				html += "<div class='card-subtitle'>"+list.title+"</div>";
    				html += "<div class='card-text align-self-center mb-3'><span class='nick card-text my-0'>"+list.nickname+"&nbsp;&nbsp;·&nbsp;&nbsp;</span><span class='loc card-text my-0'>"+list.location+"</span></div>";				
    				html += "<div class='card-text d-flex align-self-end justify-content-between'>";
    				if(list.price==0){
    					html += "<span id='nanoom' class='badge bi bi-gift-fill py-1 pl-2 pr-1 align-self-center shadow-sm'>나눔</span>";
    				}else{
    					html += "<span class='badge align-self-center py-1 px-2 shadow-sm'>&#65510;"+(list.price.toLocaleString("ko-KR"))+"</span>";
    				}
    				html += "<span><span>&nbsp;&nbsp;<i class='bi bi-heart-fill text-danger'>&nbsp;&nbsp;</i>"+list.likes+"</span><span>&nbsp;&nbsp;<i class='bi bi-eye text-black'>&nbsp;&nbsp;</i>"+list.views+"&nbsp;&nbsp;</span></div></div>";			
    				html += "</span></div></div>";			
    			})
    			$("#list").html(html);
    			html="";
    			
    			//이전 버튼
    			if(results.pagination.prev == false){
    				$("#prevBtn").html("<button class='page-link border-0 bi bi-chevron-left shadow-sm' style='color:lightgray' type='button' disabled></button>");
    			}else{
    				$("#prevBtn").html("<button class='page-link border-0 text-dark bi bi-chevron-left shadow-sm' type='button' onClick='getNumber("+results.pagination.firstPageScope+")'></button>");
    			}
    			//페이지 번호 버튼
    			html="";
    			for(var i=results.pagination.firstPageScope; i<=results.pagination.lastPageScope; i++){
    				html += "<li id='pageBtn' class='page-item'><button class='page-link border-0 shadow-sm ";
    				if(i == results.pagination.pageNum){
    					html += "text-dark' style='background-color:#f7f7f7'";
    				}else{
    					html += "text-secondary'";	
    				}
    				html += " type='button' onClick=getNumber("+i+")>"+i+"</button></li>";
    			}
    			$("#prevBtn").after(html);
    			//다음 버튼
    			if(results.pagination.next == false){
    				$("#nextBtn").html("<button class='page-link border-0 bi bi-chevron-right shadow-sm' style='color:lightgray' type='button' disabled></button>")
    			}else{
    				$("#nextBtn").html("<button class='page-link border-0 text-dark bi bi-chevron-right shadow-sm' type='button' onClick='getNumber("+(results.pagination.pageNum+1)+")'></button>")
    			}
    		}
    	}
    </script>
    <style>
    	#setMyDong:hover, #myDong:hover{
    		opacity:0.5;
    		cursor:pointer;
    	}
    	#setMyDong, #myDong{
    		font-size:15px;
    	}
    	.card-subtitle{
    		color:black;
    		font-weight:bolder;
    		font-size:1rem;
    	}
    	.badge{
    		background-color:#a091f3;
    		font-size:0.9rem;
    		letter-spacing:2px;
    		font-weight:600;
    	}
    	.loc, .nick{
    		font-size: 0.84rem;
    	}
    	.col-md-4.col-sm-6.pb-5{
    		font-size:14px;
    	}
    	@media(max-width:800px){
    		.imgFrame {
	    		width: 100%;
	    		height: 267px;
    		}
    	}
    	@media(min-width:800px){
    		.imgFrame {
    			width: 100%;
    			height: 305px;
    		}
    	}
    	.card-img-top{
    		width:100%;
    		height:100%;
    		object-fit:cover;
    	}
    	.bi-eye{
    		font-size:1.05rem;
    	}
    	.card{
    		cursor:pointer;
    		
    	}
    	.card:hover{
    		opacity:0.5;
    	}
    </style>
  </head>
  <body>
	<div class="modal fade" id="modal" tabindex="-1" aria-labelledby=modalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered justify-content-center">
			<div class="modal-content" style="width:80%; border: 2px solid #91bfa5">
				<div class="modal-header text-end border-0">
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="font-size:0.8rem"></button>
				</div>
				<div class="modal-body text-center pt-4 pb-5">
				</div>
			</div>
		</div>
	</div>
<%@include file="../header.jsp" %>
    <section class="hero-wrap hero-wrap-2 bg-light">
      <div class="container text-center d-flex justify-content-center">
        <div class="no-gutters align-items-end" style="margin-top:100px; border-bottom:solid 3px #c1b8f2;">
      		<h1 class="mb-0 bread text-dark">나눔 마켓</h1>
      		<p class="breadcrumbs mb-2"><span class="text-dark">Market</span></p>
        </div>
      </div>
    </section>
    <section class="ftco-section bg-light">
	    <div class="container bg-white shadow-sm py-3 px-5">
			<div id="searchDiv" class="row my-3 justify-content-end">
				<div class="col-12 col-md align-self-center p-0 px-md-3 mb-3 mb-md-0">
				<c:choose>
				<c:when test="${myDong != null}">
					<div id="myDong" class="bi bi-geo-alt-fill w-50" style="color:#a091f3"><span style="color:gray"> ${myDong}</span></div>
				</c:when>
				<c:otherwise>
					<div id="setMyDong" class="bi bi-geo-alt-fill w-50" style="color:#a091f3"><span style="color:gray"> 동네 설정</span></div>
				</c:otherwise>
				</c:choose>
				</div>
				<div id="searchSelect" class="d-flex col-12 col-md-2 key-box align-self-center pr-1">
					<select id="key" class="form-select border-0 p-0" aria-label="Default select example" style="font-size:14px">
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="tc">제목+내용</option>
						<option value="nickname">닉네임</option>
						<option value="category">카테고리</option>
					</select>
				</div>
				<div class="d-flex col-12 col-md-4 p-0">
					<input type="text" class="word form-control border-0 p-0 align-self-center" id="search" placeholder="원하시는 물품을 검색해 보세요 !" style="width:100%;">
					<button id="searchBtn" type="button" class="btn bi bi-search-heart fs-5 text-secondary px-2 py-0" onClick="controlWord();"></button>
					<button type="button" id="write" class="btn bi bi-pencil fs-5 text-secondary px-2 py-0"></button>
				</div>
			</div>
			<div id="list" class="row g-4">
			</div>
			<nav class="row" aria-label="Page navigation example">
				<ul id="pagination" class="pagination pagination justify-content-center mt-4 mb-3">
					<li id="prevBtn" class="page-item">
					</li>
					<li id="nextBtn" class="page-item">
					</li>
				</ul>
			</nav>
		</div>
    </section>  
		<%@include file="../footer.jsp" %>
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
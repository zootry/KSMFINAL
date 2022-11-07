<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
    <script>
	    const b_seq = "${shareMarketContents.sm_seq}";
		 $(function(){
			var likesSwitch = ${hasLike};
			if(likesSwitch) $("#heart").removeClass("bi-heart").addClass("bi-heart-fill");
			
			getList(${lastPage}, 5);
			if("${shareMarketContents.price}" == 0){
				$("#price").addClass("bi bi-gift-fill").append(" 나눔");
			}else{
				var price = ${shareMarketContents.price};
				$("#price").append("&#65510; "+price.toLocaleString("ko-KR"));
			}
    		
    		$(".container").on("click", "#update, #delete, #recomnt, #coUpdate", function(){
    			var crudId = $(this).attr("id");
    			switch(crudId){
	    			case "update": location.href="/market/update?sm_seq=${shareMarketContents.sm_seq}"; break;
	    			case "delete":
	    				$.ajax({
	    					url: "/market/delete.json",
	    					type: "DELETE",
	    					data: {
	    						sm_seq: b_seq	
	    					},
	    					success: function(data){
	    						location.href="/market";
	    					}
	    				})
	    				break;
	    			case "recomnt": case "coUpdate":
	    				var parentDiv = $("div#"+$(this).parent().attr("id"));
	    				if($("#"+crudId+"Frame").length){
		    				$("#recomntFrame").remove();
		    				$("#coUpdateFrame").remove();
	    				}else{
	    					$("#recomntFrame").remove();
		    				$("#coUpdateFrame").remove();
		    				createComntFrame(parentDiv, crudId);
	    				}
    			}
    		})
    		$("#heart").on("click", function(){
    			if("${member}".length){
	    			var type = "";
	    			if(!likesSwitch){
	    				type = "POST";
	    				likesSwitch = true;
	    			}else if(likesSwitch){
	    				type = "DELETE"
	    				likesSwitch = false;
	    			}
	    			
	    			$.ajax({
	    				url: "/market/likes.json",
	    				type: type,
	    				data:{
	    					b_seq: b_seq,
	    					email: "${email}"
	    				},
	    				success: function(likes){
	    					if(!likesSwitch){
	    						$("#heart").removeClass("bi-heart-fill").addClass("bi-heart");
	    					}else{
	    						$("#heart").removeClass("bi-heart").addClass("bi-heart-fill");
	    					}
	    					$("#heart_Data").html("&nbsp;"+likes);
	    				}
	    			})
    			}else{
    				var msg="";
    				msg += "<div class='mb-3'>로그인 후 이용해 주세요 !</div>";
					msg += "<button type='button' class='badge text-white' style='background-color:#8dc5a6; border:1px solid #8dc5a6;font-size:14px' onClick=location.href='/member/login.do'>로그인</button>";
    				showModal(msg);
    			}
    			
    		})
    		//지도
			var latLng = new kakao.maps.LatLng(${latLng[0].y}, ${latLng[0].x});
			var mapContainer = document.getElementById('map'),
				mapOption = {
					center: latLng,
					level: 4
				};
			var map = new kakao.maps.Map(mapContainer, mapOption);
			
			var content = "";
			if("${writerProfile[0].fname}".length){
				content += "<div class='markerDiv rounded-circle border'>" + 
				"<img class='markerImg' src='/market/display?imgName=${writerProfile[0].fname}'>" +
				"</div>";	
			}else{
				content += "<div class='markerDiv rounded-circle border'>"+
				"<div class='markerImg bi bi-person-fill bg-white fs-3 text-center'></div>";
			}
			
			var customOverlay =	new kakao.maps.CustomOverlay({
				map:map,
				position:latLng,
				content: content,
				yAnchor: 1
			})
			
			var zoomControl = new kakao.maps.ZoomControl();
			map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
			
    	})

    	// 답글 / 댓글 수정창 띄우기
		function createComntFrame(parentDiv, crudId){
			var html = "";
	 		html += "<div id='"+crudId+"Frame"+"' class='border rounded mb-3'><textarea id='"+crudId+"Area' class='form-control border-0' style='resize:none'></textarea>";
			html += "<div class='text-end'><span id='"+parentDiv.attr('id')+"' name='"+crudId+"Submit' class='coSubmit btn btn-sm px-2 py-1 m-1 fw-bold shadow-sm rounded-pill text-white' onclick='submit(this);'>";
			html += "</span></div></div>";
			$(parentDiv).after(html);
			
			if(crudId == "coUpdate"){
				$("#"+crudId+"Area").val($(parentDiv).children(".comntContents").children("#coContent").text());
				$("span[name="+crudId+"Submit]").text("수정");
			}else{
				$("span[name="+crudId+"Submit]").text("등록");
			}
			$("#"+crudId+"Area").focus();
 		}
				
    	 function submit(submitBtn){
    			var submitBtnName = $(submitBtn).attr("name");
    			var cmt_seq = parseInt($(submitBtn).attr("id"));
    			var url, area, type, data = ""; 
    			
 			if(!"${email}".length){
 				var msg="";
 				msg += "<div class='mb-3'>로그인 후 이용해 주세요 !</div>";
 				msg += "<button type='button' class='badge text-white' style='background-color:#8dc5a6; border:1px solid #8dc5a6;font-size:14px' onClick=location.href='/member/login.do'>로그인</button>";
 				showModal(msg);
 				return false;
 			}
   			
			if(submitBtnName == "comntSubmit"){ // 일반 댓글			
				url = "/market/comment.json";
				area = "#comntArea";
				type = "POST";
				data = {
					b_seq: b_seq,
					content: $(area).val(),
				};

			}else if(submitBtnName == "recomntSubmit"){ // 답댓글
   				url = "/market/recomment.json";
   				area = "#recomntArea";
   				type = "POST";
 				data = {
 	   				b_seq: b_seq,
 	   				content: $(area).val(),
 	   				gnum: cmt_seq
 	   			};
 				
   			}else if(submitBtnName == "coUpdateSubmit"){ // 수정 버튼
   				url = "/market/comment.json";
   				area = "#coUpdateArea";
   				type = "PUT";
   				data = {
 	   				b_seq: b_seq,
 	   				content: $(area).val(),
 	   				cmt_seq: cmt_seq, 
 	   			};
   			}else if(submitBtnName == "coDeleteSubmit"){
   				url = "/market/comment.json";
   				type = "DELETE";
   				data = {
   					b_seq: b_seq,
   					cmt_seq: cmt_seq
   				}
   			}
			if(area != null){ 
   				if($(area).val().length != 0){
	    			$.ajax({
	    				url: url,
	    				type: type,
	    				data: data,
	    				success: function(data){
	    					getList(data, 5);
	    				}
	    			})
   				}else{
   	   			}
   				$(area).val("");
   	   			$(area).blur();
   			}else{
   				$.ajax({
   					url: url,
   					type: type,
   					data: data,
   					success: function(data){
   						if(data){
   							getList(data, 5);
   						}
   					}
   				})
    		}
    	}
    	function showModal(text){
    		$(".modal-body").html("<span class='text-center'>"+text+"</span>");
			$("#modal").modal("show");
    	}
    	/* 페이지 번호 받아서 댓글창 보여주기==========================================================================================================  */
    	function getNumber(pageNum){
    		getList(pageNum, 5);
    	}
    	function getList(pageNum, pageSize){
    		$.ajax({
    			url: "/market/comment.json",
    			type: "GET",
    			data: {
    				pageNum: pageNum,
    				pageSize: pageSize,
    				b_seq: "${shareMarketContents.sm_seq}"
    			},
    			success: function(data){
    				updateList(data);
    			}
    		});
    	}
    	function updateList(results){
    		var html;
    		$("#comntFrame").empty(); // 초기화
    		html = "";
    		if(results.lists.length == 0){ // 댓글이 없으면
    			html += "<div class='block-21 d-flex py-5 justify-content-center'> 새로운 댓글을 작성해 보세요 </div>";
    			$("#comntFrame").append(html);
    		}else{
    			$.each(results.lists, function(idx, list){
    				var depth = list.comnt.depth*2;
    				if(list.comnt.depth == 0 && idx != 0){
    					html += "<div class='border-top mt-3' style='width:97%; margin:0 auto'></div>";
    				}
        			html += "<div id='"+list.comnt.cmt_seq+"' class='block-21 d-flex mt-3 mb-1' style='padding-left:"+depth+"rem'>";
        			html += "<div class='comntWriterFrame align-self-top'>";
        			if(list.comnt.depth != 0){
        				html += "<div class='bi bi-arrow-return-right position-absolute translate-middle'></div>"
        			}
        			if(list.fname == null){
        				html += "<div class='comntProfile bi bi-person-fill rounded-circle border fs-4'></div>";
        			}else{
        				html += "<img class='comntProfile rounded-circle' src='/market/display?imgName="+list.fname+"'>";
    				}
        			html += "</div><div class='col comntContents align-self-top'>";
        			html += "<div>" + list.comnt.nickname;
        			if("${email}" == list.comnt.email){
        				html += "<span class='badge text-wrap rounded-pill ml-2 pt-1' style='background-color:#a091f3'>작성자</span>";
        			}
        			html += "</div>";
        			html += "<div id='coContent'>" + list.comnt.content + "</div>";
        			html += "<div class='text-end' style='font-size:80%'>" + list.comnt.wdate + "</div></div>";
        			if("${email}".length){
        				html += "<div class='comntOption btn-group'>";
        				html += "<button class='btn p-0' type='button' data-bs-toggle='dropdown' aria-expanded='false'>";
        				html += "<span class='bi bi-three-dots'></span></button>";
        				html += "<ul id='"+list.comnt.cmt_seq+"' class='dropdown-menu'>";
        				html += "<li id='recomnt' class='btn text-secondary p-0'><a class='dropdown-item bi bi-chat-heart'> 답글</a></li>";
        				if("${email}" == list.comnt.email){
        					html += "<li id='coUpdate' class='btn text-secondary p-0'><a class='dropdown-item bi bi-eraser-fill'> 수정</a></li>";
        					html += "<li name='coDeleteSubmit' id='"+list.comnt.cmt_seq+"' class='btn text-secondary p-0' onclick='submit(this);'><a class='dropdown-item bi bi-x-lg' onclick='submit(this);'> 삭제</a></li>";
        				}
        			}
        			html += "</ul></div></div>";
    			})
    			if(!$(".totalRowCounts").length) $("#comntFrame").before("<div class='totalRowCounts'><span class='bi bi-chat-heart px-1' style='font-size:0.93rem; cursor:pointer' onClick='location.reload();'> 댓글 "+ results.pagination.totalRowCounts + "</span></div>")
    			$("#comntFrame").append(html);
    			$("#prevBtn").html("");
    			if(results.pagination.prev == false){
    				$("#prevBtn").html("<button class='page-link border-0 bi bi-chevron-left shadow-sm' style='color:lightgray' type='button' disabled></button>");
    			}else{
    				$("#prevBtn").html("<button class='page-link border-0 text-dark bi bi-chevron-left shadow-sm' type='button' onClick='getNumber("+results.pagination.firstPageScope+")'></button>");
    			}
    			
    			html = "";
    			$("li").remove("#pageBtn");
    			for(var i=results.pagination.firstPageScope; i<=results.pagination.lastPageScope; i++){
    				html += "<li id='pageBtn' class='page-item'><button class='page-link border-0 shadow-sm ";
    				if(i == results.pagination.pageNum){
    					html += "text-dark' style='background-color:#f7f7f7'";	
    				}else{
    					html += "text-dark'";
    				}
    				html += " type='button' onClick='getNumber("+i+");'>"+i+"</li>";
    			}
    			$("#prevBtn").after(html);
    			
    			$("#nextBtn").html("");
    			if(results.pagination.next == false){
    				$("#nextBtn").html("<button class='page-link border-0 bi bi-chevron-right shadow-sm' style='color:lightgray' type='button' disabled></button>");
    			}else{
    				$("#nextBtn").html("<button class='page-link border-0 text-dark bi bi-chevron-right shadow-sm' type='button' onClick='getNumber("+(results.pagination.pageNum+1)+")'></button>");
    			}
    		}
    	}
    	/*$("#chatting").on("click",function(){
    	});*/
    	function createRoom(){
    		var sharemarket_seq = "${shareMarketContents.sm_seq}";
    		var roomName = "${shareMarketContents.title}";
    		var category = "${shareMarketContents.category}";
    		var gemail = "${shareMarketContents.email}";
    		alert(gemail);
    		var roomdata = {
    				c_b_seq:sharemarket_seq, 
    				roomName:roomName, 
    				category:category, 
    				gemail:gemail, 
    				email:"${sessionScope.email}"
    				};
    		$.ajax({
    			url: '/createRoom.json',
    			data: roomdata,
    			type: 'POST',
    			success: function (res) {
    				window.open("/room", '우리동네 돌보미 채팅', 'width=450px,height=515px,location=no');
    			},
    			error : function(err){
    			}
    		});
    	}
    </script>
    <style>
    	.coSubmit{
    		background-color: #a091f3 !important;
    	}
    	.coSubmit:hover{
    		filter: brightness 1.5;
    	}
    	.col-lg-8{
    		z-index:1;
    	}
    	#map{
    		height: auto !important;
    		width:100%;
    		padding-bottom: 100%;
    		border-radius: 1.5%;
    	}
    	.carousel {
    		margin-top: 1rem;    		
    		margin-bottom: 1.4rem;    		   		
    	}
    	@media(max-width: 800px ){
    		.carousel-item {
	    		width: 100%;
	    		height: 311px;
    		}
    	}
    	@media(min-width: 800px){
    		.carousel-item {
	    		width: 100%;
	    		height: 576px;
    		}
    	}
    	.d-block {
    		height: 100%;
    		width: 100%;
    		object-fit: cover;
    	}
    	.imgs{
    		width:100%;
    	}
    	a{
    		color:gray;
    	}
    	.writerFrame{
    		width:60px;
    		height:60px;
    		float:left;
    		text-align:center;
    	}
    	.writerInfo{
    		line-height:1.4rem;
    		padding-left:0.5rem;
    		padding-right:0.5rem;
    	}
    	#heart{
    		color:#ff2b53;
    		font-size:1.3rem;
    	}}
    	#heart:hover{
    		opacity:0.5;
    	}
    	.comntWriterFrame{
    		width: 45px;
    		height: 45px;
    		float: left;
    		text-align:center;
    	}
    	.comntProfile{
    		width:100%;
    		height:100%;
    		object-fit:cover;
    	}
    	.comntContents{
    		padding-left:0.5rem;
    		line-height:1.5rem;
    		word-break:break-word;
    	}
    	.comntOption{
    		height:30%;
    		text-align:center;
    	}
    	.dropdown-menu{
    		min-width:4rem;
		}
		.recentFiles{
			width: 80px;
			height: 80px;
		}
		.recentContents{
			font-size:0.8rem;
		}
		.profile{
			width:100%;
			height:100%;
			object-fit:cover;
		}
		.blog-img{
			border-radius: 5%;
		}
		.markerImg{
			border-radius:50%;
			width:70px;
			height:70px;
			object-fit:cover;
		}
		.markerDiv{
			border-width: 3px !important;
			border-color: #00bd56 !important;
		}
		[style="position: absolute; width: 4px; height: 100%; background-color: rgb(51, 150, 255); left: 50%; margin: 0px 0px 0px -2px;"]{
			background-color: lightgray !important;
		}
    </style>
  </head>
  <body>
<%@include file="../header.jsp" %>
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
    <section class="ftco-section bg-light">
	    <div class="container">
		<!-- share market content -->
			<div class="row bg-white shadow">
				<div class="col-lg-8 p-4 col-lg-8 ftco-animate fadeInUp ftco-animated">
					<div class="d-flex align-self-center mb-2"> <!-- 제목 -->
						<h4 class="col-11 d-flex title p-0 text-black">
							<span class="rounded-pill shadow-sm px-3 p-1" style="background-color:#d8d0ff75; color:gray">${shareMarketContents.category}</span>
							<span class="px-3 align-self-center">${shareMarketContents.title}</span>
							<div><span id="price" class="badge align-self-center fs-6 px-2 shadow-sm" style="background-color: #a091f3"></span></div>
						</h4>
						<div class="col-1 p-0 text-end align-self-center">
							<i id="heart" class="bi bi-heart"></i>
						</div>
					</div>
					<!-- ------------------------------------------------------------------------------------------------------------------ -->
					<c:if test="${!empty imgNames}">
					<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
						<div class="carousel-indicators p-2">
						<c:forEach var="imgName" varStatus="status" items="${imgNames}">
							<c:choose>
							<c:when test="${status.index eq 0}">
							<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${status.index}" class="active" aria-current="true" aria-label="Slide ${status.index+1}"></button>
							</c:when>
							<c:otherwise>
							<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${status.index}" aria-current="true" aria-label="Slide ${status.index+1}"></button>
							</c:otherwise>
							</c:choose>
						</c:forEach>
						</div>
						<div class="carousel-inner rounded px-2">
							<c:forEach var="imgName" varStatus="status" items="${imgNames}">
							<div class="carousel-item 
							<c:if test="${status.index eq 0}">active</c:if>">
								<img src="/market/display?imgName=${imgName.fname}" class="d-block">
							</div>
							</c:forEach>
						</div>
						<button class="carousel-control-prev mx-2" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Previous</span>
						</button>
						<button class="carousel-control-next mx-2" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Next</span>
						</button>
					</div>
					</c:if>
					<!-- ------------------------------------------------------------------------------------------------------------------ -->
					<div>
						<div class="block-21 d-flex mb-3 justify-content-between">
							<div class="writerFrame align-self-top ml-2 mr-1">
							<c:choose>
							<c:when test="${fn:length(writerProfile) ne 0}">
								<img class="profile rounded-circle" src="/market/display?imgName=${writerProfile[0].fname}">
							</c:when>
							<c:otherwise>
								<div class="profile bi bi-person-fill rounded-circle bg-light fs-2 f"></div>
							</c:otherwise>
							</c:choose>
							</div>
							<div class="col writerInfo align-self-center">
								<div class="d-flex justify-content-between">
									<div class="d-flex col mb-1 p-0">
										<div>${shareMarketContents.nickname}</div>
										<div class="badge mx-2 py-1 align-self-center rounded-pill" id="chatting" onClick="createRoom();" style="background-color:#a091f3;cursor:pointer">채팅</div>
									</div>
									<div class="justify-content-end">
									<c:if test="${shareMarketContents.email eq email}">
									<div class="btn-group">
										<button class="btn p-0" type="button" data-bs-toggle="dropdown" aria-expanded="false">
											<span class="bi bi-three-dots"></span>
										</button>
										<ul id="${shareMarketContents.sm_seq}" class="dropdown-menu">
											<li id="update" class="btn text-secondary p-0"><a class="dropdown-item bi bi-eraser-fill"> 수정</a></li>
											<li id="delete" class="btn text-secondary p-0"><a class="dropdown-item bi bi-x-lg"> 삭제</a></li>
										</ul>
									</div>
									</c:if>
								</div>
								</div>
								<div class="row justify-content-between">
									<div class="col-12 mb-1">${shareMarketContents.location}</div>
									<div class="col-12 text-end px-0 pr-4">
										<span>${shareMarketContents.wdate} · </span>
										<span class="bi bi-eye text-black"></span>
										<span> ${shareMarketContents.views} · </span>
										<span class="bi bi-heart-fill text-danger" style="font-size:14px"></span>
										<span id="heart_Data"> ${shareMarketContents.likes} </span>
									</div>
								</div>
							</div>
						</div>	
					</div>
					<div>
						<div class='border-top mt-3' style='width:97%; margin:0 auto'></div>
						<div class="p-4 my-2" style="text-align:justify">
						${shareMarketContents.content}
						</div>
					</div>
					<!-- 댓글 영역 -->
					<div id="comntFrame" class="rounded border px-3 mt-1 mb-3">
					</div>
					<div>
						<nav class="col-12 col-md-12 mb-2" aria-label="Page navigation example">
							<ul id="pagination" class="pagination pagination-sm justify-content-center">
								<li id="prevBtn" class="page-item">
								</li>
								<li id="nextBtn" class="page-item">
								</li>
							</ul>
						</nav>
					</div>
					<!-- 댓글 입력 -->
					<div>
						<div class="col-12 col-md-12 p-0 mb-3 border rounded">
							<textarea id="comntArea" class="form-control border-0" rows="2" style="resize:none"></textarea>
							<div class="text-end">
								<span name="comntSubmit" class="btn btn-sm px-2 py-1 m-1 fw-bold shadow-sm rounded-pill text-white" onclick="submit(this);" style="background-color:#a091f3">등록</span>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-4 pb-4 sidebar pl-lg-3 ftco-animate fadeInUp ftco-animated mt-4">
					<h5>위치</h5>
					<div id="map" class="block-21 d-flex mb-4">
					</div>
					<c:if test="${!empty prevContent.shareMarket}">
					<h5>이전 글</h5>
					<div class="block-21 d-flex">
						<a class="blog-img mr-4" style="background-image: url(/market/display?imgName=${prevContent.fname});"></a>
						<div class="text">
							<h3 class="heading m-0"><a href="/market/content?sm_seq=${prevContent.shareMarket.sm_seq}">${prevContent.shareMarket.title}</a></h3>
							<div class="recentContents">
							  <div><span class="icon-person">${prevContent.shareMarket.nickname}</span></div>
							  <div><span class="icon-calendar">${prevContent.shareMarket.wdate}</span></div>
							  <div><span class="bi bi-eye"> ${prevContent.shareMarket.views} · </span><span class="bi bi-heart-fill" style="font-size:0.7rem"> ${prevContent.shareMarket.likes}</span></div>
							</div>
						</div>
					</div>
					</c:if>
					<c:if test="${!empty nextContent.shareMarket}">
					<h5>다음 글</h5>
					<div class="block-21 d-flex">
						<a class="blog-img mr-4" style="background-image: url(/market/display?imgName=${nextContent.fname});"></a>
						<div class="text">
							<h3 class="heading m-0"><a href="/market/content?sm_seq=${nextContent.shareMarket.sm_seq}">${nextContent.shareMarket.title}</a></h3>
							<div class="recentContents">
							  <div><span class="icon-person">${nextContent.shareMarket.nickname}</span></div>
							  <div><span class="icon-calendar">${nextContent.shareMarket.wdate}</span></div>
							  <div><span class="bi bi-eye"> ${nextContent.shareMarket.views} · </span><span class="bi bi-heart-fill" style="font-size:0.7rem"> ${nextContent.shareMarket.likes}</span></div>
							</div>
						</div>
					</div>
					</c:if>
					<h5 class="mt-4">최근 본 게시물</h5>
					<c:choose>
					<c:when test="${!empty recentPosts}">
					<c:forEach var="post" items="${recentPosts}">
					<div class="block-21 d-flex">
						<a class="blog-img mr-4" style="background-image: url(/market/display?imgName=${post.recentFileName});"></a>
						<div class="text">
							<h3 class="heading m-0"><a href="/market/content?sm_seq=${post.recentPost.sm_seq}">${post.recentPost.title}</a></h3>
							<div class="recentContents">
							  <div><span class="icon-person">${post.recentPost.nickname}</span></div>
							  <div><span class="icon-calendar">${post.recentPost.wdate}</span></div>
							  <div><span class="bi bi-eye"> ${post.recentPost.views} · </span><span class="bi bi-heart-fill" style="font-size:0.7rem"> ${post.recentPost.likes}</span></div>
							</div>
						</div>
					</div>
					</c:forEach>
					</c:when>
					<c:otherwise>
					<div class="block-21 mb-4 d-flex">
					<a> 나눔마켓을 둘러보세요 </a>
					</div>
					</c:otherwise>
					</c:choose>
				</div>
			</div>
		<!-- share market content-->
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
  <script src="/js/main.js"></script>

    
  </body>
</html>
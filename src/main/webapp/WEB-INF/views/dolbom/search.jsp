<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
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
    <link rel="stylesheet" href="/css/flaticon.css">
    <link rel="stylesheet" href="/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <script type="text/javascript" language="javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	
    <style>
    .dolbom_lists{
   	width: 100%;
   	position: relative;
   	padding: 0px 0 10px 0;
   	clear: both;
   	margin:0px 0 20px 0;
    }
    .employer_info{
	width: 100%;
   	padding: 10px 0;
   	clear: both;
    }
    .photo .profile_img{
    padding: 5px;
    width: 180px;
    height: 180px;
    float: left;
    margin-right: 10px;
    border-radius: 10%;
    }
    .info .kind {
    padding: 5px 10px;
    background: #e6e6e6;
    color: #000000;
    text-transform: uppercase;
    letter-spacing: .1em;
    font-weight: 400;
    border-radius: 4px;
	}
	.info .state{
	padding: 5px 10px;
    background: #e6e6e6;
    color: #000000;
    text-transform: uppercase;
    letter-spacing: .1em;
    font-weight: 400;
    border-radius: 4px;
    text-align: right;
	}
	.dolbom_lists .row .col-md-6{
	border-radius: 10px;
	background-color:white;
	margin: 10px 0 10px 0;
	}
	.searchbox{
	padding:2px 0 2px 0;
	border-bottom:1px solid #ccc;
	}
	.headtitle{
	margin:auto;
	padding:5% 0 0 0;
	text-align:center;
	font-weight:bold;
	}
	.headtitle h3{
	opacity: .8;
	background: linear-gradient(to bottom right, #97a3ea 20%, #a091f3 60%, #9283f2 90%) no-repeat;
	color:white;
	border-radius:5px;	
	}
	input[type=date]::before {
		content:attr(data-placeholder);width:100%
	}
	input[type=date]:focus::before, 
	input[type=date]:valid::before {display:none}
	input[data-placeholder]::before{
	color: #999;
  	font-family: inherit;
  	font-weight: 700;
  	font-size: 13px;
  	padding:5px 10px;
	}
	.writeBtn{
		background: linear-gradient(45deg, Violet, Orange);
		border-radius:10px;
		border:0;
		outline:0;
	}
	
	#conditions{
		margin:3% 0 0 0;
	}
	h5 a{
	font-size: 1.2rem;
	}
	.content{
     display: -webkit-box;
     display: -ms-flexbox;
     display: box;
	 text-overflow:ellipsis; 
	 overflow:hidden; 
	 word-break:break-all;
	 -webkit-box-orient:vertical;
	 -webkit-line-clamp:1;
	 
	}
	@media (max-width: 767.98px) {
	.photo .profile_img{
    padding: 5px;
    width: 100px;
    height: 100px;
    float: left;
    margin-right: 10px;
    border-radius: 10%;
    }
    .content, .tags{
    display:none;
    }
    h5 a{
    font-size:1rem;
    }
    .employer_info{
    font-size:0.2rem;
    }
    span .kind, span .state{
    font-size:0.2rem;
    }
	 }
    </style>
  </head>
<body>
<%@include file="../header.jsp" %>    
    <section class="ftco-section bg-light pt-0">
    	<div class="container py-3 px-5" style="height:1000px;">
	    	<div class="headtitle">
	    		<c:choose>
	    			<c:when test="${empty mydong}"><h3>내 동네 등록하기&nbsp;
		    			<a href="javascript:check();" style="text-decoration:none;"><i class="bi bi-arrow-right-circle text-white"></i></a></h3>
		    		</c:when>
	    			<c:otherwise><h3><i class="bi bi-geo-alt"></i>&nbsp;${mydong}</h3></c:otherwise>
	    		</c:choose>
	    	</div>
			<div class="searchbox">
				<div class="row justify-content-center">
			         <div class="col-md-2">
					    <select class="selectpicker form-control" id="category" onchange="selectOption();" title="돌봄유형">
					    	<option value="제공">돌봄제공</option>
					    	<option value="요청">돌봄요청</option>
					    </select>
					 </div>
					 <div class="col-md-2">
					    <select class="selectpicker form-control" id="kind" onchange="selectOption();" title="돌봄종류">
					    	<option value="산책">산책</option>
					    	<option value="방문돌봄">방문돌봄</option>
					    	<option value="위탁돌봄">위탁돌봄</option>
					    </select>
					 </div>
        
			        <div class="col-md-4">
			          <select class="selectpicker form-control" id="conditions" onchange="selectOption();" title="희망조건선택" multiple >
			          <option data-hidden="true" value="">돌봄유형</option>
				        <optgroup label="돌보미">
					        <option value="견주">견주</option>
					        <option value="집사">집사</option>
				        </optgroup>
				        <optgroup label="사전만남">
					        <option value="사전만남">사전만남</option>
				        </optgroup>
				        <optgroup label="중성화여부">
					        <option value="중성화O">중성화O</option>
				        </optgroup>
				        <optgroup label="대형견케어">
					        <option value="대형견케어">대형견케어가능</option>
				        </optgroup>
				      </select>
					</div>
					<div class="col-md-2">
				         <input type="date" class="datepicker" id="workdate" data-placeholder="날짜선택" onclick="selectOption()" required aria-required="true" style="border:none;"/>
					</div>
					<div class="col-md-2">
						<select class="selectpicker form-control" id="ampms" multiple title="시간선택" onchange="selectOption();">
					    	<option data-hidden="true" value="">시간선택</option>
					    	<option value="오전">오전</option>
					    	<option value="오후">오후</option>
					    </select>
					</div>
			    </div>
			  </div>
  
			  <div class="row">
				  <div class="col-md-12" style="text-align:right;">
					<a id="reset" href="javascript:reset();"><i class="bi bi-arrow-clockwise"></i>&nbsp;검색 조건 초기화</a>
				  </div>
			 </div>
			 <div class="row">
				 <!-- 
				 <div class="col-md-6" id="conditions">
					검색 결과 총 <span id="count"></span>건
			  	 </div>
				 <div class="col-md-6" id="conditions" style="text-align:right;">
					최신순 | 거리순 | 인기순
			  	 </div>
			  	  -->
			  	  <div class="col-md-12" id="conditions">
					검색 결과 총 <span id="count"></span>건
			  	 </div>
			 </div>
    		
    		 <div class="dolbom_lists">
		    </div>
		    
		    <nav class="row" aria-label="Page navigation example">
				<ul id="pagination" class="pagination pagination-sm justify-content-center" style="margin:auto;">
					<li id="prevBtn" class="page-item">
					</li>
					<li id="nextBtn" class="page-item">
					</li>
				</ul>
			</nav>    
        </div>
    </section>
  
  <%@include file="../footer.jsp" %>
  <script>
  /*오늘날짜 기본값으로 설정*/
  	//document.getElementById('startDate').value = new Date().toISOString().substring(0, 10);
  
	$(function(){
		getList(1, 6);
		
	});
	function getList(pageNum, pageSize,conditions,category,kind,workdate,ampms){
		console.log(pageNum);
		console.log(pageSize);
		console.log(conditions);
		console.log(category);
		console.log(kind);
		console.log(workdate);
		console.log(ampms);
		if(!conditions){
			conditions= [''];
		}
		if(!category){
			category='';
		}
		if(!kind){
			kind='';
		}
		if(!workdate){
			workdate='';
		}
		if(!ampms){
			ampms= [''];
		}
		$.ajax({
			url : "/dolbom/search.json",
			type : "GET",
			data : {
				pageNum : pageNum,
				pageSize : pageSize,
				conditions : conditions,
				category : category,
				kind : kind,
				workdate : workdate,
				ampms : ampms
				//key : key,
				//word : word,
				//b_seq : "${ShareMarketContents.sm_seq}"
			},
			success : function(data){
				updateList(data);
			}
		});
	}
	function getNumber(pageNum){
		getList(pageNum, 6);
	}
	function updateList(results){
		var html = "";
		$("#prevBtn").html("");
		$("#nextBtn").html("");
		$("li").remove("#pageBtn");
		
		 html += '<div class="row">';
		 if(results.dolbomlist.length == 0){
			 html += '<div class="col-md-12" style="text-align:center;">검색 결과가 없습니다.';
		 }else{
			 $.each(results.dolbomlist, function(idx, list){
				 /*if(list.category=="요청"){
				 	html += '<div class="col-md-6" style="background-color:#edf2f7;">';
				 }else{
					 html += '<div class="col-md-6" style="background-color:#edfff6;">';
				 }*/
				 html += '<div class="col-md-6">';
				 html += '<div class="employer_info">';
				 html += '<div class="photo">';
				 if(results.fnames[idx] == null){
					 html += '<img class="profile_img" src="/images/altimg_puppy.png">';
				 }else{
					 html += '<img class="profile_img" src="/dolbom/display?imgName='+results.fnames[idx]+'">';
				 }	 
		    	 html += '</div>';
		    	 html += '<div class="info">';
		    	 html += '<div>';
		    	 if(list.category=="요청"){
		    	 	html += '<span class="kind" style="background-color:#a091f3"><strong>돌봄'+list.category+'</strong></span>';
		    	 }else{
		    		 html += '<span class="kind" style="background-color:#98c9fa"><strong>돌봄'+list.category+'</strong></span>';
		    	 }
		    	 html += '<span class="state"><strong>'+list.state+'</strong></span>';
		    	 if(list.category=="요청"){
		    		 html += '<h5><a href="/dolbom/content.do?dol_seq='+list.dol_seq+'">'+list.header.replace(' ','<br>')+'</a></h5>';
		    	 }else{
		    	 	html += '<h5><a href="/dolbom/content.do?dol_seq='+list.dol_seq+'">'+list.header+'</a></h5>';
		    	 }
		    	 html += '</div>';
		         html += '<div>';
		    	 html += '<span class="writer">'+list.nickname+'</span>&nbsp;·&nbsp;';
		    	 html += '<span class="addr">'+list.region+'</span>';
		    	 html += '</div>';
		    	 html += '<div>';
		    	 html += '<span class="content">'+list.content+'</span>';
		    	 html += '</div>';
		    	 html += '<div>';
		    	 html += '<span class="tags"><strong>'+list.tag+'</strong></span>';
		    	 html += '</div>';
		    	 html += '<div style="text-align:right;">';
		    	 html += '<span><i class="bi bi-chat-dots"></i>&nbsp;&nbsp;'+list.chat+'</span>&nbsp;&nbsp;';
		    	 //html += '<span><i class="bi bi-eye"></i>&nbsp;&nbsp;3</span>&nbsp;&nbsp;';
		    	 html += '<span><i class="bi bi-heart-fill text-danger">&nbsp;&nbsp;</i>'+list.likes+'</span>&nbsp;&nbsp;';
		    	 //html += '<span class="wdate">'+list.wdate+'</span>';
		    	 html += '</div>';
		    	 html += '</div>';
		    	 html += '</div>';
		    	 html += '</div>'; 
			 })
		 }
		 html += '</div>';
		 $('.dolbom_lists').html(html);
		 $("#count").html(results.pagination.totalRowCounts);
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
	
	function selectOption(){		
	  	var conditions = [];
	  		$("#conditions option:selected").each(function(i) {
	  			conditions.push($(this).val());
		    });
		 if(conditions==''){
			 conditions = [''];
		 }
		 var ampms = [];
	  		$("#ampms option:selected").each(function(i) {
	  			ampms.push($(this).val());
		    });
		 if(ampms==''){
			 ampms = [''];
		 }
		 var category = $("#category option:selected").val();
		 var kind = $("#kind option:selected").val();
		 var workdate = $("#workdate").val();
		 
		 getList(1, 6, conditions,category,kind,workdate,ampms);

	}
  function reset(){
	  location.href="/dolbom";
  }
  function check(){
		if(${not empty sessionScope.email}){
			location.href="/address/setting";
		}else{
			alert("로그인 후 이용해주세요!");
		}
	}

  </script>

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>
 <!-- select box 추가  jquery-3.3.1-->
  <!-- <script src="/js/jquery-3.3.1.min.js"></script> -->
  <script src="/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="/js/popper.min.js"></script>
  <script src="/js/bootstrap.min.js"></script>
   <!-- select box 추가  bootstrap-select-->
  <script src="/js/bootstrap-select.min.js"></script>
  <script src="/js/jquery.easing.1.3.js"></script>
  <script src="/js/jquery.waypoints.min.js"></script>
  <script src="/js/jquery.stellar.min.js"></script>
  <script src="/js/jquery.animateNumber.min.js"></script>
  <!-- <script src="/js/bootstrap-datepicker.js"></script> -->
  <!-- <script src="/js/jquery.timepicker.min.js"></script> -->
  <script src="/js/owl.carousel.min.js"></script>
  <script src="/js/jquery.magnific-popup.min.js"></script>
  <script src="/js/scrollax.min.js"></script>
  <script src="/js/main.js"></script>

  </body>
</html>
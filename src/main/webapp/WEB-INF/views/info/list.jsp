<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
	<head>
    <title>Pet Care</title>
    <meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
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
    <style>
    	table.infoview{
    		width:100%;
    		border-collapse: collapse;
  			border-spacing: 1px;
  			text-align: left;
  			line-height: 1.5;
    	}
    	table.infoview th{
  			padding: 10px;
  			font-weight: bold;
  			vertical-align: top;
  			text-align: center;
    	}
    	table.infoview thead{
    		border-bottom: 2px solid black;
    	}
    	table.infoview td {
  		padding: 10px;
  		vertical-align: top;
  		border-bottom: 1px solid #ccc;
		}
		#tablecontent{
			text-align: center;
		}
		.listpage{
			margin:auto;
			text-align:center;
		}
		.wbtn{
			text-align:right;
		}
		.searchdiv{
			text-align:right;
		}
		.addonbtn{
			text-align:right;
		}
		#infokeyword{
			background: #fff !important;
			box-shadow: none !important;
			border:none;
			border-radius: 5px;
		}
		#infokeyword:focus{
			outline:none;
		}
		#infocatgo:focus{
			outline:none;
		}
		#writeBtn{
			border:none;
			background-color:#fff;
		}
		#writeBtn:hover{
			cursor:pointer;
		}
		#searchBtn{
			border:none;
			background-color:#fff;
		}
		#searchBtn:hover{
			cursor:pointer;
		}
		#deletechecked{
			border:none;
			background-color:#fff;
			float:right;
		}
		#deletechecked:hover{
			cursor:pointer;
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
    <div class="container bg-white shadow-sm py-3 px-5">
			<form action="list.do">
				<div class="searchdiv d-flex justify-content-end pb-3">
					<select name="infocatgo" id="infocatgo" class="col-md-2 form-select border-0 p-0">
						<option value="title">제목</option>
						<option value="wdate">작성일</option>
						<option value="udate">수정일</option>
					</select>
				    <input type="text" name="infokeyword" id="infokeyword" value="${sessionScope.infokeyword}">
				    <input type="hidden" name="infosearchModeStr" id="infosearchModeStr" value="T">
					<input type="hidden" name="infocp" id="infocp" value="1">
					<button type="submit" id="searchBtn" class="bi bi-search-heart text-secondary px-2 py-0 bi-search-heart-fill"></button>
					<c:if test="${fn:contains(sessionScope.member.m_seq,'ADMIN') }">
					<button type="button" id="writeBtn" onClick="location.href='/info/infowrite.do'" class="bi bi-pencil fs-5 text-secondary px-2 py-0"></button>
					</c:if>
			    </div>
		    </form>
		    <table class="table table-hover infoview">
		    <thead style="background: linear-gradient(to bottom right, #97a3ea 20%, #a091f3 60%, #9283f2 90%) no-repeat;opacity:0.8;color:white;">
			    <tr>
			    	<th>번호</th>
				    <th>제목</th>
				    <th>작성자</th>
				    <th>작성일</th>
				    <th>수정일</th>
				    <c:if test="${fn:contains(sessionScope.member.m_seq,'ADMIN') }">
				    <th><input type="checkbox" onClick="allClick()" id="checkall"></th>
				    </c:if>
				</tr>
		    </thead>
		    <tbody>
			    <c:choose>
				    <c:when test="${empty listpinS&&empty listVo}">
					    <tr>
					    <td id="tablecontent" colspan="6">공지사항이 없습니다</td>
					    </tr>
				    </c:when>
				    <c:otherwise>
					    <c:forEach items="${listpinS}" var="listpinS">
						    <tr >
							    <td id="tablecontent" class="bi bi-pin-fill"></td>
							    <td id="tablecontent"><a href="infocontent.do?n_seq=${listpinS.n_seq}">${listpinS.title}</a></td>
							    <td id="tablecontent">${listpinS.admin}</td>
							    <td id="tablecontent">${listpinS.wdate}</td>
							    <td id="tablecontent">${listpinS.udate}</td>
							    <c:if test="${fn:contains(sessionScope.member.m_seq,'ADMIN') }">
								    <td id="tablecontent">
								    	<input type="checkbox" name="checkseq" value="${listpinS.n_seq}">
								    </td>
							    </c:if>
						    </tr>
					    </c:forEach>
					    <c:forEach items="${listVo.list}" var="infolist">
						    <tr>
							    <td id="tablecontent">${fn:substring(infolist.n_seq,4,-1)}</td>
							    <td id="tablecontent"><a href="infocontent.do?n_seq=${infolist.n_seq}">${infolist.title}</a></td>
							    <td id="tablecontent">${infolist.admin}</td>
							    <td id="tablecontent">${infolist.wdate}</td>
							    <td id="tablecontent">${infolist.udate}</td>
							    <c:if test="${fn:contains(sessionScope.member.m_seq,'ADMIN') }">
								    <td id="tablecontent">
								    	<input type="checkbox" name="checkseq" value="${infolist.n_seq}">
								    </td>
							    </c:if>
						    </tr>
					    </c:forEach>
				    </c:otherwise>
			    </c:choose>
		    </tbody>
	    </table>
    	<c:if test="${fn:contains(sessionScope.member.m_seq,'ADMIN') }">
    	<c:choose>
    	<c:when test="${!empty listpinS||!empty listVo}">
    	<div class="addonbtn"><button type="button" id="deletechecked" onClick="deletechecked()" class="bi bi-trash fs-5 pr-4"></button>
    	</div>
    	</c:when>
    	</c:choose>
    	</c:if>
	    <div class="listpage">
		    <c:choose>
		    <c:when test="${empty listVo}">
		    </c:when>
		    <c:otherwise>
		    <c:if test="${listVo.currentRange ne 1}">
		    	<a href="#" onClick="fn_paging(1)">[처음]</a>
		    </c:if>
		    <c:if test="${listVo.cp ne 1}">
				<a href="#" onClick="fn_paging('${listVo.prevPage }')">[이전]</a> 
			</c:if>
			<c:forEach var="i" begin="${listVo.startPage }" end="${listVo.endPage }">
				<c:choose>
			    	<c:when test="${i eq  listVo.cp}">
			        	<span style="font-weight: bold;"><a href="#" onClick="fn_paging('${i}')">${i}</a></span> 
					</c:when>
			        <c:otherwise>
			            <a href="#" onClick="fn_paging('${i}')">${i}</a> 
					</c:otherwise>
				</c:choose>
		    </c:forEach>
		        <c:if test="${listVo.cp ne listVo.totalPageCount && listVo.totalPageCount > 0}">
		            <a href="#" onClick="fn_paging('${listVo.nextPage }')">[다음]</a> 
		        </c:if>
			<c:if test="${listVo.currentRange ne listVo.rangeCount && listVo.rangeCount > 0}">
		    	<a href="#" onClick="fn_paging('${listVo.totalPageCount }')">[끝]</a> 
			</c:if>
			</c:otherwise>
			</c:choose>
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
  <script src="/js/main.js"></script>

  <script>
  	function fn_paging(infocp) {
	  	console.log("infocp:"+infocp);
	  	location.href = "/info/list.do?infocp=" + infocp;
  	}
  	var del_list = new Array();
	var checkval = $("input[name=checkseq]");
	var size;
	function allClick(){
		var checkall = $("#checkall");
		checkval = $("input[name=checkseq]");
		size = checkval.length;
		if(checkall.attr('name') == 'checkall-checked'){  			
			$(checkval).prop("checked", false);
			checkall.attr("name","checkall");
			del_list = new Array();
		}else{
			del_list = new Array();
			$(checkval).prop("checked", true);
			checkall.attr("name","checkall-checked");
			for(i=0;i<size;i++){
				var checkvalue = checkval.eq(i).attr("value");
				del_list.push(checkvalue);
				console.log(del_list);
			}
		}
	}
	checkval.change(function(){
		size = checkval.length;
		del_list = new Array();
		for(i=0;i<size;i++){
			if(checkval[i].checked==true){
				var checkvalue = checkval.eq(i).attr("value");
				del_list.push(checkvalue);
			}
		}
		console.log(del_list);
	});
	function deletechecked(){
		var v = {"del_list":del_list};
		if(del_list.length==0){
			alert("체크된 목록이 없습니다");
		}
		$.get("/info/checkdelete.do", v, function(data){
			location.href="/info/list.do";
		});
	};
	$(function(){
		$(".bi-pencil").on("mouseenter",function(){
			$(this).removeClass("bi-pencil");
			$(this).addClass("bi-pencil-fill");
			$(this).css("opacity","0.5");
		});
		$(".bi-pencil").on("mouseleave",function(){
			$(this).removeClass("bi-pencil-fill");
			$(this).addClass("bi-pencil");
			$(this).css("opacity","1");
			$(this).css("transform","scale(1)");
		});
	});
  </script>
    
  </body>
</html>
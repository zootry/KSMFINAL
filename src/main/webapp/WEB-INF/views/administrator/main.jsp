<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
    
    .admincontainer {
	  width: 100%;
	  padding-right: 15px;
	  padding-left: 15px;
	  margin-right: auto;
	  margin-left: auto; }
	  @media (min-width: 576px) {
	    .admincontainer {
	      max-width: 80%; } }
	  @media (min-width: 768px) {
	    .admincontainer {
	      max-width: 80%; } }
	  @media (min-width: 992px) {
	    .admincontainer {
	      max-width: 80%; } }
	  @media (min-width: 1200px) {
	    .admincontainer {
	      max-width: 80%; } }
    
    #addition{
    	float:right;
    }
	.opcategory{
		display:flex;
		justify-content: space-between;
		align-items:flex-end;
	}
	.deletebtn{
		display:flex;
		flex-direction:row-reverse;
	}
	.admincontainer{
		margin-bottom : 2.5rem;
	}
	#deletechecked{
			border:none;
			background-color:#fff;
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
      		<h1 class="mb-0 bread text-dark">관리자페이지</h1>
      		<p class="breadcrumbs mb-2"><span class="text-dark">Administrator</span></p>
        </div>
      </div>
	</section>

    
    <section class="ftco-section bg-light">
    <c:if test="${fn:contains(sessionScope.member.m_seq,'ADMIN') }">
    <div class="container">
    <div class="admincontainer bg-white shadow-sm py-3 px-5">
    <div class="opcategory">
    	<h3>공지사항</h3><a href="../info/list.do" id="addition">더보기</a>
    </div>
    	<table class="table table-hover">
    	<thead style="background: linear-gradient(to bottom right, #97a3ea 20%, #a091f3 60%, #9283f2 90%) no-repeat;opacity:0.8;color:white;">
    	<tr>
    	<th>글 번호</th>
    	<th>작성자</th>
    	<th>글 제목</th>
    	<th>작성일자</th>
    	<c:if test="${fn:contains(sessionScope.member.m_seq,'ADMIN') }">
    	<th><input type="checkbox" onClick="allClick(this)" id="checkall" name="info" value="info"></th>
    	</c:if>
    	</tr>
    	</thead>
    	<tbody>
    	<c:forEach items="${listinfo}" var="info" begin="0" end="2">
    	<tr>
    	<td>${info.n_seq}</td>
    	<td>${info.admin}</td>
    	<td><a href="../info/infocontent.do?n_seq=${info.n_seq}">${info.title}</a></td>
    	<td>${info.wdate}</td>
    	<td><input type="checkbox" name="infocheckseq" value="${info.n_seq}"></td>
    	</tr>
    	</c:forEach>
    	<c:if test="${fn:length(listinfo) < 3}">
    	<c:forEach begin="0" end="${2-fn:length(listinfo)}">
    	<tr>
    	<td colspan="8">내역이 존재하지 않습니다</td>
    	</tr>
    	</c:forEach>
    	</c:if>
    	</tbody>
    	</table>
    	<c:if test="${!empty listinfo}">
    	<div class="deletebtn">
    	<div class="addonbtn"><button type="button" id="deletechecked" onClick="deletechecked()" class="bi bi-trash fs-5 pr-4"></button></div>
    	</div>
    	</c:if>
    </div>
    <div class="admincontainer bg-white shadow-sm py-3 px-5">
    <div class="opcategory">
    	<h3>회원 관리</h3>
    	<a href="../admin/userlist.do" id="addition">더보기</a>
    </div>
    	<table class="table table-hover">
	    	<thead style="background: linear-gradient(to bottom right, #97a3ea 20%, #a091f3 60%, #9283f2 90%) no-repeat;opacity:0.8;color:white;">
		    	<tr>
			    	<th>식별번호</th>
			    	<th>이름</th>
			    	<th>이메일</th>
			    	<th>닉네임</th>
			    	<th>가입일</th>
		    	</tr>
	    	</thead>
	    	<tbody>
		    	<c:forEach items="${listmember}" var="member" begin="0" end="2">
			    	<tr>
				    	<td>${member.m_seq}</td>
				    	<td>${member.name}</td>
				    	<td><a href="useroperating.do?m_seq=${member.m_seq}">${member.email}</a></td>
				    	<td>${member.nickname}</td>
				    	<td>${member.joindate}</td>
			    	</tr>
		    	</c:forEach>
		    	<c:if test="${fn:length(listmember) < 3}">
			    	<c:forEach begin="0" end="${2-fn:length(listmember)}">
				    	<tr>
				    		<td colspan="8">내역이 존재하지 않습니다</td>
				    	</tr>
			    	</c:forEach>
		    	</c:if>
	    	</tbody>
    	</table>
    </div>
    <div class="admincontainer bg-white shadow-sm py-3 px-5">
    <div class="opcategory">
    	<h3>신고 관리</h3>
    	<a href="../report/list.do" id="addition">더보기</a>
    </div>
    	<table class="table table-hover">
	    	<thead style="background: linear-gradient(to bottom right, #97a3ea 20%, #a091f3 60%, #9283f2 90%) no-repeat;opacity:0.8;color:white;">
		    	<tr>
			    	<th>글 번호</th>
			    	<th>신고자</th>
			    	<th>작성자</th>
			    	<th>신고 사유</th>
			    	<th>글 링크</th>
			    	<th>처리 상태</th>
			    	<th>신고 일자</th>
		    	</tr>
	    	</thead>
	    	<tbody>
		    	<c:forEach items="${listreport}" var="report" begin="0" end="2">
			    	<tr>
				    	<td>${report.rep_seq}</td>
				    	<td><a href="/admin/useroperatingemail.do?email=${report.rep_remail}">${report.rep_remail}</a></td>
				    	<td><a href="/admin/useroperatingemail.do?email=${report.rep_wemail}">${report.rep_wemail}</a></td>
				    	<td><a href="/report/content.do?rep_seq=${report.rep_seq}">${report.rep_reason}</a></td>
				    	<td><a href="/dolbom/content.do?dol_seq=${report.rep_wseq}">${report.rep_wseq}</a></td>
				    	<td>${report.rep_state}</td>
				    	<td>${report.rep_date}</td>
			    	</tr>
		    	</c:forEach>
		    	<c:if test="${fn:length(listreport) < 3}">
			    	<c:forEach begin="0" end="${2-fn:length(listreport)}">
				    	<tr>
				    		<td colspan="8">내역이 존재하지 않습니다</td>
				    	</tr>
			    	</c:forEach>
	    		</c:if>
	    	</tbody>
    	</table>
    	<div class="deletebtn">
    	</div>
    </div>
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
  
 	var del_list = new Array();
 	var checkval = $("input[name=infocheckseq]");
	var size;
	function allClick(category){
		var checkall = $("#checkall");
		checkval = $("input[name="+category.value+"checkseq]");
		size = checkval.length;
		if(checkall.attr('name') == category.value+'-checked'){
			$(checkval).prop("checked", false);
			checkall.attr("name",category.value);
			del_list = new Array();
		}else{
			del_list = new Array();
			$(checkval).prop("checked", true);
			checkall.attr("name",""+category.value+"-checked");
			for(i=0;i<size;i++){
				var checkvalue = checkval.eq(i).attr("value");
				del_list.push(checkvalue);
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
			location.href="/admin/main.do";
		});
	};
  </script>
    
  </body>
</html>
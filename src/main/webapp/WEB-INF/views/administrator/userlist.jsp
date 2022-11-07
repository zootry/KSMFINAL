<%@ page contentType="text/html; charset=utf-8" %>
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
    	table.userview{
    		width:100%;
    		border-collapse: collapse;
  			border-spacing: 1px;
  			text-align: left;
  			line-height: 1.5;
  			border-top: 3px solid black;
    	}
    	table.userview th{
  			padding: 10px;
  			font-weight: bold;
  			vertical-align: top;
  			text-align: center;
    	}
    	table.userview thead{
    		border-bottom: 2px solid black;
    	}
    	table.userview td {
  		padding: 10px;
  		vertical-align: top;
  		border-bottom: 1px solid #ccc;
		}
		#tablecontent{
			text-align: center;
		}
		.searchdiv{
			text-align:right;
		}
		.addonbtn{
			text-align:right;
		}
		#userkeyword{
			background: #fff !important;
			box-shadow: none !important;
			border:none;
			border-radius: 5px;
		}
		#userkeyword:focus{
			outline:none;
		}
		#usercatgo:focus{
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
		.listpage{
			margin:auto;
			text-align:center;
		}
    </style>
  </head>
  <body>
<%@include file="../header.jsp" %>
    <section class="hero-wrap hero-wrap-2 bg-light">
      <div class="container text-center d-flex justify-content-center">
        <div class="no-gutters align-items-end" style="margin-top:100px; border-bottom:solid 3px #c1b8f2;">
      		<h1 class="mb-0 bread text-dark">회원 관리</h1>
      		<p class="breadcrumbs mb-2"><span class="text-dark">User Information</span></p>
        </div>
      </div>
	</section>
    
    <section class="ftco-section bg-light">
    <div class="container bg-white shadow-sm py-3 px-5">
    <div class="admincontainer">
		    <form action="userlist.do">
			    <div class="searchdiv d-flex justify-content-end pb-4">
				    <select name="usercatgo" id="usercatgo" class="col-md-1 form-select border-0 p-0">
					    <c:choose>
						    <c:when test="${sessionScope.usercatgo eq 'email'}">
							    <option value="email" selected>이메일</option>
							    <option value="joindate">가입일</option>
							    <option value="nickname">닉네임</option>
						    </c:when>
						    <c:when test="${sessionScope.usercatgo eq 'joindate'}">
							    <option value="email">이메일</option>
							    <option value="joindate" selected>가입일</option>
							    <option value="nickname">닉네임</option>
						    </c:when>
						    <c:when test="${sessionScope.usercatgo eq 'nickname'}">
							    <option value="email">이메일</option>
							    <option value="joindate">가입일</option>
							    <option value="nickname" selected>닉네임</option>
						    </c:when>
						    <c:otherwise>
							    <option value="email" selected>이메일</option>
							    <option value="joindate">가입일</option>
							    <option value="nickname">닉네임</option>
						    </c:otherwise>
					    </c:choose>
				    </select>
				    <input type="text" name="userkeyword" id="userkeyword">
				    <input type="hidden" name="usersearchModeStr" id="usersearchModeStr" value="T">
					<input type="hidden" name="usercp" id="usercp" value="1">
					<button type="submit" id="searchBtn" class="bi bi-search-heart text-secondary px-2 py-0 bi-search-heart-fill"></button>
			    </div>
		    </form>
    <table class="table table-hover infoview">
	    <thead style="background: linear-gradient(to bottom right, #97a3ea 20%, #a091f3 60%, #9283f2 90%) no-repeat;opacity:0.8;color:white;">
		    <tr style="text-align:center;">
		    	<th>이름</th>
			    <th>닉네임</th>
			    <th>이메일</th>
			    <th>성별</th>
			    <th>가입일</th>
			    <th><input type="checkbox" onClick="allClick()" id="checkall"></th>
			</tr>
	    </thead>
	    <tbody>
		    <c:choose>
			    <c:when test="${empty memberVo.list}">
			    	<td id="tablecontent" colspan="5">검색결과가 없습니다</td>
			    </c:when>
			    <c:otherwise>
				    <c:forEach items="${memberVo.list}" var="userlist">
					    <tr>
						    <td id="tablecontent">${userlist.name}</td>
						    <td id="tablecontent">${userlist.nickname}</td>
						    <td id="tablecontent"><a href="/admin/useroperating.do?m_seq=${userlist.m_seq}">${userlist.email}</a></td>
						    <c:choose>
						    <c:when test="${userlist.gender eq 'W'}">
						    <td id="tablecontent">여성</td>
						    </c:when>
						    <c:otherwise>
						    <td id="tablecontent">남성</td>
						    </c:otherwise>
						    </c:choose>
						    <td id="tablecontent">${userlist.joindate}</td>
						    <td id="tablecontent"><input type="checkbox" name="checkseq" value="${userlist.m_seq}"></td>
					    </tr>
				    </c:forEach>
			    </c:otherwise>
		    </c:choose>
	    </tbody>
    </table>
	    <c:choose>
			<c:when test="${!empty memberVo.list}">
	    		<div class="addonbtn"><button type="button" id="deletechecked" onClick="deletechecked()" class="bi bi-trash fs-5 pr-4"></button></div>
	    	</c:when>
	    </c:choose>
	    <div class="listpage">
		    <c:choose>
			    <c:when test="${empty memberVo}">
			    </c:when>
			    <c:otherwise>
			    <c:if test="${memberVo.currentRange ne 1}">
			    	<a href="#" onClick="fn_paging(1)">[처음]</a>
			    </c:if>
			    <c:if test="${memberVo.cp ne 1}">
			    	<a href="#" onClick="fn_paging('${memberVo.prevPage}')">이전</a>
			    </c:if>
			    <c:forEach var="i" begin="${memberVo.startPage}" end="${memberVo.endPage}">
			    	<c:choose>
			    		<c:when test ="${i eq memberVo.cp}">
			    			<span style="font-weight: bold;"><a href="#" onClick="fn_paging('${i}')">${i}</a></span>
			    		</c:when>
			    		<c:otherwise>
			    			<a href="#" onClick="fn_paging('${i}')">${i}</a>
			    		</c:otherwise>
			    	</c:choose>
			    </c:forEach>
			    <c:if test="${memberVo.cp ne memberVo.totalPageCount && memberVo.totalPageCount>0}">
			    	<a href="#" onClick="fn_paging('${memberVo.nextPage}')">[다음]</a>
			    </c:if>
			    <c:if test="${memberVo.currentRange ne memberVo.rangeCount && memberVo.rangeCount>0}">
			    	<a href="#" onClick="fn_paging('${memberVo.totalPageCount}')">[끝]</a>
			    </c:if>
			    </c:otherwise>
		    </c:choose>
	    </div>
    </div>
    </div>
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
			history.back();
		}
	});
  
  	function fn_paging(usercp) {
	  	console.log("usercp:"+usercp);
	  	location.href = "/admin/userlist.do?usercp=" + usercp;
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
		$.get("/admin/checkdelete.do", v, function(data){
			location.href="/admin/userlist.do";
		});
	};
  </script>
    
  </body>
</html>
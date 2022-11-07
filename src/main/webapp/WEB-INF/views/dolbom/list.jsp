<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <link rel="stylesheet" href="/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="/css/jquery.timepicker.css">
    <link rel="stylesheet" href="/css/flaticon.css">
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
    <script type="text/javascript" language="javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
    
    <style>
    .dolbomTable{
    margin-top:50px;
    margin-bottom:50px;
    width: 100%;
	height: 400px;
	overflow: auto;
	/*margin:auto;*/
    }
	.dolbomTable::-webkit-scrollbar {
	width: 10px;
	}
	.dolbomTable::-webkit-scrollbar-thumb {
	background-color: #e4ebf5;
	border-radius: 10px;
	background-clip: padding-box;
	border: 2px solid transparent;
	}
    .category {
    padding: 5px 10px;
    background: #e6e6e6;
    color: #000000;
    text-transform: uppercase;
    font-size: 13px;
    letter-spacing: .1em;
    font-weight: 400;
    border-radius: 4px;
	}
	.btn{
	padding:5px 10px;
	}
    </style>   
  </head>
<body>
<%@include file="../header.jsp" %>
	<section class="hero-wrap hero-wrap-2">
      <div class="container text-center d-flex justify-content-center">
        <div class="no-gutters align-items-end" style="margin-top:100px; border-bottom:solid 3px #c1b8f2;">
      		<h1 class="mb-0 bread text-dark">돌보미 리스트</h1>
      		<p class="breadcrumbs mb-2"><span class="text-dark">Dolbom List</span></p>
        </div>
      </div>
    </section>
    <section class="ftco-section pt-0">
    	<div class="container">
    		<div class="dolbomTable">
	            <table class="table table-hover">
	               	<thead style="background: linear-gradient(to bottom right, #97a3ea 20%, #a091f3 60%, #9283f2 90%) no-repeat;opacity:0.8;color:white;">
		               	<tr>
		               		<th>수신/발신</th>
		               		<th>요청자</th>
		               		<th>돌보미</th>
		               		<th>돌봄시간</th>
		               		<th>돌봄유형</th>
		               		<th>상태</th>
		               		<th>확인</th>
		               		<th>채팅</th>               		
		               		<th>삭제</th>
		               	</tr>
	               	</thead>
	               	<tbody id="dolbomTbody">
		            </tbody>
		        </table>
	        </div>
	        <input type="hidden" id="email" value="${userEmail}">        
        </div>
    </section>
  
  <%@include file="../footer.jsp" %>

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>
  <script>
  function resetDList(){
	  var email = $("#email").val();
	  $.ajax({
		  url: "../dolbom/dlist.json",
		  type: "POST",
		  success: function(data){
			  console.log();
			  var html = "";
			  if(data.length==0){
				  html += '<tr><td colspan="9" align="center">돌봄 리스트가 비어있어요</td></tr>';
			  }else{
				  for(var i=0;i<data.length;i++){
					  
					  if(data[i].category=='요청'){
						  var receiver = data[i].sendernick
						  var dolbomy = data[i].receivernick
					  }else{
						  var receiver = data[i].receivernick
						  var dolbomy = data[i].sendernick					  
					  }
					  html += '<tr>';
					  if(data[i].receiveremail==email){
					  	html += '<td><i class="bi bi-box-arrow-right"></i>수신</td>';
					  }else{
						  html += '<td><i class="bi bi-box-arrow-left"></i>발신</td>';
					  }
					  html += '<td>'+receiver+'</td>';
					  html += '<td>'+dolbomy+'</td>';
					  html += '<td>'+data[i].workdate+'</td>';
					  html += '<td>'+data[i].kind+'</td>'; 
					  html += '<td>'+data[i].state+'</td>';			  
					  
					  if(data[i].state == "대기중"){
						  if(data[i].receiveremail==email){
							  html += '<td><button type="submit" class="btn text-black rounded-pill px-3 text-white" id="yes" onclick="acceptList('+data[i].dl_seq+')" style="background-color:#a091f3;border:none;">수락</button>';
							  html += '<button type="submit" class="btn btn-light rounded-pill px-3 text-secondary" id="no" onclick="deleteList('+data[i].dl_seq+')" style="border:none;">거절</button>';
						  }else{
							  html += '<td><button type="submit" class="btn btn-light rounded-pill px-3 text-secondary" style="border:none;">수락대기중</button>';
						  }	  
					  }else if(data[i].state == "진행중"){
						  if(data[i].requester==email){
							  html += '<td><button type="submit" class="btn text-black rounded-pill px-3 text-white" id="finishid" onclick="finishList('+data[i].dl_seq+',this.id)" style="background-color:#a091f3;border:none;">완료</button>';
							  }
						  else{
							  html += '<td><button type="submit" class="btn btn-light rounded-pill px-3 text-secondary" style="border:none;">진행중</button>';
						  }
					}else if(data[i].state == "완료"){
						if(data[i].requester==email){
							html += '<td><button type="submit" class="btn text-black rounded-pill px-3 text-white" onclick="writeComt('+data[i].dl_seq+')" style="background-color:#98c9fa;border:none;">후기작성</button>';
						}else{
							html += '<td><button type="submit" class="btn btn-light rounded-pill px-3 text-secondary" style="border:none;">완료</button>';
						}
					}else if(data[i].state == "후기등록"){
						html += '<td><button type="submit" class="btn text-black rounded-pill px-3 text-white" onclick="showReview('+data[i].dl_seq+')" style="background-color:#98c9fa;border:none;">후기보기</button>';
					}
					  html += '</td>';
					  //html += '<td><a href="javascript:goChatting(\''+data[i].sendernick+'\',\''+data[i].receivernick+'\',\''+data[i].workdate+'\'/\''+data[i].kind+'\');"><i class="bi bi-chat-dots"></i></a></td>';
					  html += '<td><a href="javascript:goChatting(\''+data[i].sendernick+'\',\''+data[i].receivernick+'\',\''+data[i].workdate+'\',\''+data[i].kind+'\');"><i class="bi bi-chat-dots"></i></a></td>';
					  html += '<td><a href="javascript:checkDelete('+data[i].dl_seq+',\''+data[i].state+'\')"><i class="bi bi-x-circle"></i></a></td>';
					  html += '</tr>';
				  }
			  }
			  $("#dolbomTbody").html(html);
		  }
		  
	  });
	  
  }
  $(document).ready(function(){
	  var errorMsg="<c:out value='${errorMsg}'/>";
	  if(errorMsg){
		  alert(errorMsg);
		  location.href="/dolbom/list.do"
	  }
	  resetDList();
  });
	 function showReview(dl_seq){
		 location.href="/review/content.do?cr_seq=CR"+dl_seq;
	 }
	function acceptList(dl_seq){
		console.log("accept:"+dl_seq);
		$.ajax({
	    	url: "../dolbom/acceptList.json",
			type: "GET",
			data: {dl_seq:dl_seq},
			success: function(data){
				alert("수락할까요?");
				resetDList();	
			}
		});

	}
	function deleteList(dl_seq){
		console.log(dl_seq);
		$.ajax({
	    	url: "../dolbom/deleteList.json",
			type: "GET",
			data: {dl_seq:dl_seq},
			success: function(data){
				resetDList();
			}
		});
	}
	function finishList(dl_seq,id){
		console.log(dl_seq,id);
		$.ajax({
	    	url: "../dolbom/finishList.json",
			type: "GET",
			data: {dl_seq:dl_seq},
			success: function(data){
				alert("돌봄을 완료할까요?");
				resetDList();
				
			}
		});
	}
	function writeComt(dl_seq){
		alert("후기를 작성할까요?");
		location.href="/review/write.do?dl_seq="+dl_seq;
	}
	/*function goChatting(sendernick,receivernick){
		console.log("se"+sendernick);
		console.log("re"+receivernick);
		//console.log(roomName);
		
	}*/
	function goChatting(sendernick,receivernick,roomName1,roomName2){
		console.log(sendernick);
		console.log(receivernick);
		console.log(roomName1);
		console.log(roomName2);
		var roomName = roomName1+"/"+roomName2;
		$.ajax({
	    	url: "../dolbom/goChatting.json",
			type: "GET",
			data: {sendernick:sendernick,receivernick:receivernick,roomName:roomName},
			success: function(data){
				console.log("roomNumber"+data.roomNumber);
				var url = "/moveChating?roomName="+roomName+"&roomNumber="+data.roomNumber+"&nickname="+sendernick+"&gnickname="+receivernick;
				var popup = window.open(url, '채팅', 'width=700px,height=800px,scrollbars=yes');
			}
		});
	}
	function checkDelete(dl_seq,state){
		console.log("state"+state);
		console.log("dl_seq"+dl_seq);
		
		if(state=="대기중"||state=="완료"){
			if(confirm("리스트에서 삭제할까요?") == true){
				//deleteList(dl_seq);
			}else{
				return false;
			}	
		}
		if(state=="진행중"){
			alert("돌봄 진행 중에는 삭제할 수 없습니다.");
		}
	}
	
	
  </script>
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
  <script src="/js/main.js"></script>

  </body>
</html>
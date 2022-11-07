<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		.chating{
			background-color: #ded9f9;
			height: 515px;
			overflow: auto;
			padding:10px;
		}
		.chating::-webkit-scrollbar {
			width: 10px;
		}
		.chating::-webkit-scrollbar-thumb {
			background-color: #e4ebf5;
			border-radius: 10px;
			background-clip: padding-box;
			border: 2px solid transparent;
		}
		.chating .me{
			color: black;
			text-align: right;
		}
		.chating .others{
			color: black;
			text-align: left;
		}
		.chatcontainer{
			/*width:500px;*/
			margin:0 auto;
		}
		input{
			width: 330px;
			height: 25px;
		}
		.mymsg{
			background-color: #a091f3;
			border-radius: 3px;
			word-break: break-all;
			color:white;
		}		
		.othersmsg{
			background-color: white;
			border-radius: 3px;
		}
		.otherName{
			background-color: white;
			border-radius: 3px;
		}
		#chatting{
		width:600px;
		}
	</style>
  </head>
  <body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript">
	var ws;
	var userName;

	function wsOpen(){
		//웹소켓 전송시 현재 방의 번호를 넘겨서 보낸다.
		ws = new WebSocket("ws://" + location.host + "/chating/"+$("#roomNumber").val());
		console.log("소켓 열림");
		wsEvt();
	}
	function wsEvt() {
		ws.onopen = function(data){
			//소켓이 열리면 동작
			console.log("소켓이 열리면 동작");
			console.log(userName);
			var option ={
					type: "enterEvent",
					roomNumber: $("#roomNumber").val(),
					sessionId : $("sessionId").val(),
					userName : userName,
					msg : "님이 입장하셨습니다"
				}
			ws.send(JSON.stringify(option));
		}
		
		ws.onmessage = function(data) {
			//메시지를 받으면 동작
			var msg = data.data;
			if(msg != null && msg.trim() != ''){
				var d = JSON.parse(msg);
				if(d.type == "getId"){
					var si = d.sessionId != null ? d.sessionId : "";
					if(si != ''){
						$("#sessionId").val(si); 
					}
				}else if(d.type == "message"){
					if(d.sessionId == $("#sessionId").val()){
						console.log(d.sessionId);
						if(d.msg == ""){
							
						}else{
							$("#chating").append("<p class='me'><span class='mymsg'>" + d.msg + "</span></p>");
							document.getElementById("chatting").value='';
						}
					}else{
						if(d.msg == ""){
							
						}else{
							$("#chating").append("<p class='others'><span class='otherName'>" + d.userName + "</span><br><span class='othersmsg'>" + d.msg + "</span></p>");
						}
					}
					$('#chating').scrollTop($('#chating').prop('scrollHeight'));
				}else if(d.type == "wsClose"){
					alert("방장이 채팅방을 폭파시켰습니다");
					ws.close();
					location.href="../room";
				}
			}
		}

		document.addEventListener("keypress", function(e){
			if(e.keyCode == 13){ //enter press
				send();
			}
		});
		
		ws.onclose = function(data){
			alert("진짜 종료됨");
			location.href="../room";
		}
	}
	
	$(document).ready(function(){
			$('#chating').scrollTop($('#chating').prop('scrollHeight'));
			var email = "${sessionScope.email}";	
			$.ajax({
				url:"/getNickName.json",
				type: "POST",
				data: {"email": email},
				success: function(data){
					userName = data.userName;
					wsOpen();
					console.log("시작메소드");
					console.log(userName);
					$("#yourName").hide();
					$("#yourMsg").show();
				},
				error: function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
	});
	

	function send() {
		var option ={
			type: "message",
			roomNumber: $("#roomNumber").val(),
			sessionId : $("#sessionId").val(),
			userName : userName,
			msg : $("#chatting").val()
		}
		ws.send(JSON.stringify(option));
		$('#chatting').val("");
	}
	function wsClose(){
		alert("채팅방 연결종료!");
		$.ajax({
			url:"/deleteRoom.json",
			type: "POST",
			data: {"roomNumber": $("#roomNumber").val()},
			success: function(data){
				
			}

		});
		var option ={
				type: "wsClose",
				roomNumber: $("#roomNumber").val(),
				sessionId : $("#sessionId").val(),
				userName : userName,
				msg : "채팅방 연결종료"
			}
		ws.send(JSON.stringify(option));
		ws.close();
	}
	
</script>

    <div id="chatcontainer" class="chatcontainer">
    	<div id="header" class="d-flex justify-content-between p-2">
	    	<c:choose>
	    	<c:when test="${gnickname eq uN}">
	    	<h3>${nickname}</h3>
	    	</c:when>
	    	<c:otherwise>
			<h3>${gnickname}</h3>
			</c:otherwise>
			</c:choose>
			<div class="text-end">
			<button class="btn bi bi-list" style="font-size:1rem" onclick="location.href='../room'"></button>
			</div>
			<!-- <button onclick="wsClose()">채팅방 닫기</button> -->
			<input type="hidden" id="sessionId" value="">
			<input type="hidden" id="roomNumber" value="${roomNumber}">
		</div>
		<div id="chating" class="chating">
		<c:forEach items="${recordslist}" var="records">
		<c:choose>
		<c:when test="${records.userName == uN}">
		<p class='me'>
		<span class='mymsg'>${records.msg}</span>
		</p>
		</c:when>
		<c:otherwise>
		<p class='others'>
		<span class='otherName'>${records.userName}</span>
		<br>
		<span class='othersmsg'>${records.msg}</span>
		</p>
		</c:otherwise>
		</c:choose>
		</c:forEach>		
		</div>
		<div id="yourMsg" class="d-flex justify-content-center">
			<textarea id="chatting" placeholder="보내실 메시지를 입력하세요."></textarea>
			<button class='btn btn-primary bi bi-send text-secondary' onclick="send()" id="sendBtn" type='button'></button>
		</div>
		</div>

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
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="/js/google-map.js"></script>
  <script src="/js/main.js"></script>

    
  </body>
</html>
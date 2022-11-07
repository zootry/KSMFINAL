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
		*{
			margin:0;
			padding:0;
		}
		
		/*.roomContainer{
			width: 100%;
			height: 500px;
			overflow: auto;
			margin:auto;
		}
		.roomList{
			border: none;
			width: 100%;
		}
		.roomList th{
			border: 1px solid #4BDCC8;
			background-color: #fff;
			color: #4BDCC8;
		}
		.roomList td{
			border: 1px solid #4BDCC8;
			background-color: #fff;
			text-align: left;
			color: #4BDCC8;
			white-space: nowrap;
		}
		.roomList .num{
			width: 10%;
			text-align: center;
		}
		.roomList .cat{
			width: 5%;
			text-align: center;
		}
		.roomList .name{
			width: 10%;
			text-align: center;
		}
		.roomList .room{
			width: 50%;
		}
		.roomList .go{
			width: 10%;
			text-align: center;
		}
		.inputTable{
			margin:auto;
		}
		.inputTable input{
			width: 400px;
			height: 25px;
		}*/
		#roomContainer{
		width: 100%;
		height: 500px;
		overflow: auto;
		}
		#roomContainer::-webkit-scrollbar{
		width: 10px;
		}
		#roomContainer::-webkit-scrollbar-thumb {
		background-color: #e4ebf5;
		border-radius: 10px;
		background-clip: padding-box;
		border: 2px solid transparent;
		}
		#Refreshbtn{
			float:right;
		}
		#sendBtn{
			
		}
	</style>
  </head>
  <body>
    <script>
	var ws;
	var userName;
	window.onload = function(){
		getRoom();
	}

	function getRoom(){
		var msg = {email:"${sessionScope.email}"};
		commonAjax('/getRoom.json', msg, 'post', function(result){
			createChatingRoom(result);
		});
	}
	
	$(document).ready(function(){
		var email = "${sessionScope.email}";	
		$.ajax({
			url:"/getNickName.json",
			type: "POST",
			data: {"email": email},
			success: function(data){
				console.log("성공");
				console.log(data.userName);
				userName = data.userName;
			},
			error: function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	});

	function goRoom(number, name, nickname, gnickname){
		location.href="/moveChating?roomName="+name+"&"+"roomNumber="+number+"&nickname="+nickname+"&gnickname="+gnickname;
		//var popup = window.open(url, '채팅', 'width=700px,height=800px,scrollbars=yes');	
	}

	function createChatingRoom(res){
		if(res != null){
			var tag = "";
			console.log("채팅방 만들기");
			console.log(res);
			res.forEach(function(d, idx){
				if(d.c_subject==null){
						
				}else{
					var rn = d.c_subject.trim();	
					var date = rn.substring(0,rn.indexOf(')')+1);
					var time = rn.substring(rn.indexOf(')')+1,rn.indexOf('/'));
					var type = rn.substring(rn.lastIndexOf('/')+1);
					var roomNumber = d.c_number;
					var roomCategory = d.c_category;
					var c_b_seq = d.c_b_seq;
					var c_b_seq_offer = d.c_b_seq_offer;
					var nickname = d.c_ownername;
					var gnickname = d.c_guestname;
					var nick = "${sessionScope.member.nickname}";
					var other ="";
					if(nick==nickname){
						other = gnickname;
					}else{
						other = nickname;
					}
					if(c_b_seq == null){
		                  c_b_seq = "";
		            }
					if(c_b_seq.includes("SM")){
						tag += 
							"<tr scope='row'>"+
								"<td class='name'>"+other+"</td>"+
								"<td class='room'><a href='/market/content.do?sm_seq="+c_b_seq+"'>"+rn+"</a></td>"+
								//"<td class='cat'>"+roomCategory+"</td>"+
								"<td class='cat'><a href='/market/content.do?sm_seq="+c_b_seq_offer+"'>나눔마켓</a></td>"+
								"<td class='go'><button class='btn btn-primary' type='button' onclick='goRoom(\""+roomNumber+"\", \""+rn+"\", \""+nickname+"\" , \""+gnickname+"\")'>채팅</button></td>" +
							"</tr>"+
							"<tr class='spacer'><td colspan='100'></td></tr>"
					}else{
					tag += 
							"<tr scope='row'>"+
								"<td class='name'>"+other+"</td>"+
								"<td class='room'><a href='/dolbom/content.do?dol_seq="+c_b_seq+"'>"+date+"<br>"+time+"/"+type+"</a></td>"+
								//"<td class='cat'>"+roomCategory+"</td>"+
								"<td class='cat'><a href='/dolbom/content.do?dol_seq="+c_b_seq_offer+"'>돌보미</a></td>"+
								"<td class='go'><button class='btn btn-primary' type='button' onclick='goRoom(\""+roomNumber+"\", \""+rn+"\", \""+nickname+"\" , \""+gnickname+"\")'>채팅</button></td>" +
							"</tr>"+
							"<tr class='spacer'><td colspan='100'></td></tr>";
					}
				}
			});
			$("#roomList").empty().append(tag);
		}
	}
	function searchRoom(){
		var searchRoomName = $("#search").val();
		$.ajax({
			url: "/searchroom.json",
			data: {"c_owner":"${sessionScope.email}", "c_guest":"${sessionScope.email}", "c_subject":searchRoomName},
			type: "POST",
			success: function(data){
				createChatingRoom(data);
			}
		});
	}

	function commonAjax(url, parameter, type, calbak, contentType){
		$.ajax({
			url: url,
			data: parameter,
			type: type,
			contentType : contentType!=null?contentType:'application/x-www-form-urlencoded; charset=UTF-8',
			success: function (res) {
				console.log(res);
				calbak(res);
			},
			error : function(err){
				console.log('error');
				calbak(err);
			}
		});
	}
</script>
    
    <div>
	    <div class="logo" style="margin-bottom:20px;">
		    <a href="" class="imgLogoHref"><img src="/images/logo.png" class="imgLogo" style="width:200px;"></a>
		</div>
		<div class="col-8 col-md-4 p-0 d-flex justify-content-center" style="float:right;">
			<input type="text" class="word form-control border-0 p-0 align-self-center" onkeypress="searchRoom()" id="search" placeholder="닉네임 또는 방제목으로 검색해보세요!" style="width:100%;">
			<button id="sendBtn" type="button" class="btn bi bi-search-heart fs-5 text-secondary px-2 py-0" onclick="searchRoom()"></button>
			<button type="button" id="Refreshbtn" class="btn bi bi-arrow-clockwise fs-5 text-secondary px-2 py-0" onclick="getRoom()"></button>
		</div>    
		<div id="roomContainer" class="table-responsive custom-table-responsive shadow-sm">
			<table class="table custom-table">
			<tbody id="roomList">
			</tbody>
			</table>
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
  <script src="/js/owl.carousel.min.js"></script>
  <script src="/js/jquery.magnific-popup.min.js"></script>
  <script src="/js/scrollax.min.js"></script>
  <script src="/js/main.js"></script>

    
  </body>
</html>
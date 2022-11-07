<%@ page language="java" contentType="text/html; charset=utf-8" import="java.util.*, com.petcare.domain.Address" pageEncoding="UTF-8"%>
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
    <!-- 부트스트랩 아이콘 스타일시트 추가-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
    <!-- <script type="text/javascript" language="javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script> -->
    <!-- map -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b19c96904445e8a8df0b446bb87c90bc"></script>
    <!-- 검색자동완성 -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
	<script src="http://code.jquery.com/jquery-1.9.1.js" type="text/javascript"></script>
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js" type="text/javascript"></script>
    <script type="text/javascript">
		function sendXY(lat,lon,addr){
			$.ajax({
				url: "../addressdo.json",
				type: "GET",
				data: {y:lat,x:lon,addr:addr},
				dataType:'json',
				contentType: "application/json; charset=utf-8",
				success: function(data){
					var nearlist=data.nearlist.split(',');
					nearlist[0]=nearlist[0].replace('[','');
					nearlist[nearlist.length-1]=nearlist[nearlist.length-1].replace(']','');
					console.log(nearlist);
					console.log("data:::"+data.mydong);
					var mydong = $('#mydong').text();
					var html = "";
					html += '<p id="mydongButton">';
					html += data.mydong;
					html += '<button type="submit" id="cancel" onclick="cancelDong();"><i class="bi bi-x-circle"></i></button></p>';
					$("#mydong").html(html);
					drawMap(2,data.lat,data.lon);
					setRangeDiv(2);
					setNearList(nearlist);	
				},
				error: function (request, status, error) {
			        console.log("code: " + request.status)
			        console.log("message: " + request.responseText)
			        console.log("error: " + error);
			    }
			});
		  }
		function drawMap(range,lat,lon){
			var level = range+4;
			var latLng = new kakao.maps.LatLng(lat, lon);
			var mapContainer = document.getElementById('map'),
				mapOption = {
					center: latLng,
					level: level
				};
			var map = new kakao.maps.Map(mapContainer, mapOption);
			var circle = new kakao.maps.Circle();				
			var customOverlay =	new kakao.maps.CustomOverlay({
				map:map,
				position:latLng,
				yAnchor: 1
			})				
			var zoomControl = new kakao.maps.ZoomControl();
			

			circle = new kakao.maps.Circle({
				center: new kakao.maps.LatLng(lat,lon),
				radius: range*1000,
				strokeWeight: 5, //선 두께
				strokeColor: '#00a0e9',
				strokeOpacity: 1, //선의 불투명도
				strokeStyle: 'solid',
				fillColor: '#00a0e9',
				fillOpacity: 0.2
			});
			
			map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
			circle.setMap(map);
		}
		function setNearList(nearlist){
			console.log("setNearList"+nearlist);
			var html = "";
			html += "<h5>근처 동네</h5>";				
			html += '<a href="" id="showBtn"><i class="bi bi-arrow-right-circle"></i>&nbsp;내 근처에 총 '+nearlist.length+'동네가 있어요</a>';
			html += '<a href="" id="foldBtn" style="display:none"><i class="bi bi-arrow-right-circle"></i>&nbsp;내 근처 동네 리스트 접기</a>'; 
			html += '<div style="display:none" class="nearDong">';
			html += '<table class="table table-hover" id="nearTable">';
			for(var i=0;i<nearlist.length;i++){	
				html += '<tr><td>'+nearlist[i]+'</td></tr>';
			}
			html += '</table></div>';
			$(".showNearDong").html(html);
		}
		function setRangeDiv(range){
			var html = "";
			html +='<h5>동네 범위 설정</h5>';
			html +='<div class="rangeAddr">';
			html +='<input type="range" class="custom-range" min="1" max="3" onchange="changeRange(this.value)" value="'+range+'">';
			html +='<div class="d-flex justify-content-between">';
			html +='<span>1km</span>';
			html +='<span>2km</span>';
			html +='<span>3km</span>';
			html +='</div></div>';
			$(".nearAddr").html(html);
		}
		var radius = ${mydong.range}
		
		$(document).on("click","#showBtn",function(){
			$(this).nextUntil('.showNearDong').toggle();
	        $(this).hide();
	        $(this).next().show();
	        return false;					
		})
		$(document).on("click","#foldBtn",function(){
			$(this).nextUntil('.showNearDong').toggle();
	        $(this).hide();
	        $(this).prev().show();
	        return false;					
		})

		  $(function(){
			    $("#roadFullAddr").autocomplete({
			        source : function( request, response ) {
			             $.ajax({
			                    type: 'post',
			                    url: "../autoData.json",
			                    dataType: "json",
			                    data: { addr : $("#roadFullAddr").val()},
			                    success: function(data) {
			                        response(
			                            $.map(data, function(item) {
											return {
													label: item.address_name, 
													value: item.address_name,
													x:item.x,
													y:item.y
											}		                               
			                            })
			                        );
			                    }
			               });
			            },
			        minLength: 2,
			        select: function( event, ui ) {
		            	if($("#mydongButton").text()==''){
		            		sendXY(ui.item.y,ui.item.x,ui.item.value);	
		            	}else{
		            		alert("동네는 1개만 등록 가능해요. 삭제 후 재등록 해주세요.");
		            	}   
			        }
			    });
			  
			    //지도
			 	var level = Number(${mydong.range})+4;
				var latLng = new kakao.maps.LatLng(${latLng[0].y}, ${latLng[0].x});
				var mapContainer = document.getElementById('map'),
					mapOption = {
						center: latLng,
						level: level
					};
				var map = new kakao.maps.Map(mapContainer, mapOption);
				var circle = new kakao.maps.Circle();				
				var customOverlay =	new kakao.maps.CustomOverlay({
					map:map,
					position:latLng,
					yAnchor: 1
				})				
				var zoomControl = new kakao.maps.ZoomControl();
				

				circle = new kakao.maps.Circle({
					center: new kakao.maps.LatLng(${latLng[0].y},${latLng[0].x}),
					radius: radius*1000,
					strokeWeight: 5, //선 두께
					strokeColor: '#00a0e9',
					strokeOpacity: 1, //선의 불투명도
					strokeStyle: 'solid',
					fillColor: '#00a0e9',
					fillOpacity: 0.2
				});
				
				map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
				circle.setMap(map);
		  });
						  
		  function changeRange(range){
			  //this.radius = range;
			$.ajax({
				url: "../changeRange.json",
				type: "GET",
				data:{range:range},
				success: function(result){
					drawMap(Number(range),result.lat,result.lon);
					setRangeDiv(range);
					setNearList(result.nearlist);
				}
			});	
		}
		  /*설정한 내 동네 삭제*/
			function cancelDong(){
				$.ajax({
					url: "../addressCancel.json",
					type: "GET",
					success: function(data){
						$("#mydong").empty();
						var html="";
						html += '<a href="#">아직 등록된 동네가 없어요</a>';
						$("#mydong").html(html);
						$("#roadFullAddr").val('');
						$(".custom-range").val(2.0);
						$(".showNearDong").html('');
						$(".nearAddr").html('');
						drawMap(0,${latLng[0].y},${latLng[0].x});
					}
				});	
			}
    </script>
    
    <style>
    /*.inputAddr{
    height:250px;
    width:1000px;
    }*/
    .inputAddr #searchCurr{
    width:100%;
	opacity: .6; /*색상연하게 0.0~1.0*/
	background: linear-gradient(45deg, #207dff 0%, #00bd55 100%);
	color:white;
	border-radius:5px;
	border:none;	
    }
    #roadFullAddr{
    /*width:50%;*/
    border-radius:5px;
    }
    #dong{
    background-color:gray;
    color:white;
    width:180px;
    border-radius: 5px;
    text-align:center;
    }
    #mydongButton{
    background-color:#a091f3;
    opacity:0.6;
    color:white;
    width:180px;
    border-radius: 5px;
    text-align:center;
    }
    .rangeAddr{
    width:50%;
    }
    #cancel{
   background-color: transparent !important;
   background-image: none !important;
   border-color: transparent;
   border: none;
   color: #FFFFFF;

    }
    #nearDong{
    width:40%;
    }
    #settingAddrRow{
    margin:20px 0 20px 0;
    
    }
    #content{
    margin:30px 0 30px 0;
    }
    #map{
		height:250px;
		width:100%;
		padding-bottom: 100%;
		border-radius: 1.5%;
   	}
   	.nearDong{
    margin-bottom:50px;
    width: 100%;
	height: 400px;
	overflow: auto;
	/*margin:auto;*/
    }
	.nearDong::-webkit-scrollbar {
	width: 10px;
	}
	.nearDong::-webkit-scrollbar-thumb {
	background-color: #e4ebf5;
	border-radius: 10px;
	background-clip: padding-box;
	border: 2px solid transparent;
	}

    </style>
  </head>
<body>
<%@include file="header.jsp" %>
	<section class="hero-wrap hero-wrap-2">
      <div class="container text-center d-flex justify-content-center">
        <div class="no-gutters align-items-end" style="margin-top:100px; border-bottom:solid 3px #c1b8f2;">
      		<h1 class="mb-0 bread text-dark">동네설정</h1>
      		<p class="breadcrumbs mb-2"><span class="text-dark">Setting Address</span></p>
        </div>
      </div>
	</section>
    <section class="ftco-section ftco-no-pt ftco-no-pb">
    	<div class="container">
	    	<div class="row" id="settingAddrRow">
		    	<div class="col-md-6 bg-white shadow my-5">
		    		<div class="inputAddr" id="content">
			    		<h5>동네 설정</h5>
						<input id=roadFullAddr type="text" class="form-control" placeholder="내 동네 이름(동,읍,면)으로 검색">
		    			<button type="button" class="btn btn-primary btn-block" id="searchCurr" onclick="searchCurrAddr();">
		    				<i class="bi bi-geo-alt"></i>&nbsp;현재 위치로 찾기
		    			</button>
		    		</div>
		    		<div id="map" class="block-21 d-flex mb-4">
					</div>
		    	</div>
		    	<div class="col-md-6 bg-white shadow my-5">
		    		<div class="myAddr" id="content">
		    			<h5>내가 설정한 동네</h5>		
						<div id="mydong">
						<c:choose>
			    			<c:when test="${empty mydong}">
			    				<a href="">아직 등록된 동네가 없어요</a>
			    			</c:when>
			    			<c:otherwise>
			    				<p id="mydongButton">
			    				${mydong.dongname}
			    				<button id="cancel" onclick="cancelDong();"><i class="bi bi-x-circle"></i></button>
			    				</p>
			    			</c:otherwise>
		    			</c:choose>
		    			</div>    				
		    			<div id="dong"></div>
		    		</div>
		    		
			    		<div class="nearAddr" id="content">
			    		<c:if test="${!empty mydong}">
			    			<h5>동네 범위 설정</h5>
			    			<div class="rangeAddr">
			    				<input type="range" class="custom-range" min="1" max="3" onchange="changeRange(this.value)" value="${range}">
			    				<div class="d-flex justify-content-between">
			    					<span>1km</span>
			    					<span>2km</span>
			    					<span>3km</span>
			    				</div>
							</div>
						</c:if>	
						</div>
						<div class="showNearDong" id="content">
						<c:if test="${!empty mydong}">
							<h5>근처 동네</h5>					
							<a href="" id="showBtn"><i class="bi bi-arrow-right-circle"></i>&nbsp;내 근처에 총 ${totNeardong}동네가 있어요</a>
							<a href="" id="foldBtn" style="display:none"><i class="bi bi-arrow-right-circle"></i>&nbsp;내 근처 동네 리스트 접기</a> 
							<div style="display:none" class="nearDong">
								<table class="table table-hover" id="nearTable">
									<c:forEach items="${nearlist}" var="list">
										<tr><td>${list}</td></tr>
									</c:forEach>
								</table>
							</div>		
						</c:if>	
						</div>
    			</div>
    		</div>  		
        </div>
    </section>
  
  <%@include file="footer.jsp" %>

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

<script>
	
	/*현재 위치 좌표 얻기*/
	function searchCurrAddr(){
		getLocation();
	}
	function getLocation() {
		  if (navigator.geolocation) { 
		    navigator.geolocation.getCurrentPosition(function(position) {
		      if($("#mydongButton").text()==''){
		    	  sendXY(position.coords.latitude,position.coords.longitude,"");	
	          }else{
	          		alert("동네는 1개만 등록 가능해요. 삭제 후 재등록 해주세요.");
	          }   
		    }, function(error) {
		      console.error(error);
		    }, {
		      enableHighAccuracy: false,
		      maximumAge: 0,
		      timeout: Infinity
		    });
		  } else {
		    alert('GPS를 지원하지 않습니다');
		  }
	}
</script>
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
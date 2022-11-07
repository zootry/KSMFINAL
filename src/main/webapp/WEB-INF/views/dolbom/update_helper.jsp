<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
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
    <script type="text/javascript" language="javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  </head>
  <style>
  .scrollable-menu {
    height: auto;
    max-height: 200px;
    max-width: 100px;
    overflow-x: hidden;
    text-align:center;
    }
    a.info{
            text-decoration: none
    }
    a.info:hover{
        position: relative
    }
    a.info span{
        display: none
    }
    a.info:hover span{
        border: #c0c0c0 1px solid;
        padding: 5px 5px 5px 5px;
        display: block;
        z-index: 100;
        left: 0px;
        margin: 10px;
        width: 270px;
        position: absolute;
        top: 10px;
        text-decoration: none
    }
    /*사진첨부*/
    .files{
	height:3rem;
	}
	.box-wrap{
		padding:1.5%;
	}
	.box{
		position:relative;
		width:100%;
	}
	.box::after{
		display:block;
		content:"";
		padding-bottom:100%;
	}
	.img{
		position: absolute;
		margin: 0 auto;
		width: 100%;
		height: 100%;
		object-fit:cover;
	}
	#imageList{
		position:relative;
		padding:1.5%;
	}
	
	.plus{
		cursor:pointer;
	}
	#plus:hover, .selectedImg:hover{
		opacity:0.5;
	}
   	#stime,#etime{
   	width:150px;
   	height:40px;
   	padding:5px;
   	border-color: #ced4da;
   	}
   	#workday{
   	width:200px;
   	height:40px;
   	border-radius: 5px;
    border-color: #ced4da;
    color: #495057;
   	}
   	.headtitle{
   	margin:auto;
   	padding:5% 0 0 0;
   	}
   	.headtitle h3{
	opacity: .8; /*색상연하게 0.0~1.0*/
	background: linear-gradient(to bottom right, #97a3ea 20%, #a091f3 60%, #9283f2 90%);
	color:white;
	border-radius:5px;
	padding:0 50px;
	margin:10px 0;	
	}
	.write-btn{
	margin:5% 0;
	}
  </style>
<body>
<%@include file="../header.jsp" %>
    
    <section class="ftco-section bg-light">
		<div class="container">
		<!-- 돌보미가 될게요 폼 시작 -->
            <div class="headtitle"><h3>돌보미가 될게요</h3></div>
            <div class="rounded shadow bg-white p-5">	
				<div class="row">
					<div class="col-sm-6 col-mb-6">
						<div class="col-sm-6 col-mb-6 form-label m-0 p-0">언제 돌봐줄 수 있나요?</div>
							<select name="workday" id="workday">
			                  <option>요일 선택</option>
			                  <option value="월화수목금" <c:if test="${dolbom.workday eq '월화수목금'}">selected</c:if>>평일</option>
			                  <option value="토일" 
			                  <c:if test="${dolbom.workday eq '토일'}">selected</c:if>>주말</option>
			              	</select>
					</div>
					<div class="col-sm-6 col-mb-6">
						<div class="col-sm-6 col-mb-6 form-label m-0 p-0">몇시에 돌봐줄 수 있나요?</div>
			            <div class="btn-group">
			            	<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" id="stime">시작시간</button>
			           		<ul class="dropdown-menu scrollable-menu" role="menu">
			           			<li><a onclick="setTimesS(this);">오전 12:00</a></li>
			                    <li><a onclick="setTimesS(this);">오전 01:00</a></li>
			                    <li><a onclick="setTimesS(this);">오전 02:00</a></li>
			                    <li><a onclick="setTimesS(this);">오전 03:00</a></li>
			                    <li><a onclick="setTimesS(this);">오전 04:00</a></li>
			                    <li><a onclick="setTimesS(this);">오전 05:00</a></li>
			                    <li><a onclick="setTimesS(this);">오전 06:00</a></li>
			                    <li><a onclick="setTimesS(this);">오전 07:00</a></li>
			                    <li><a onclick="setTimesS(this);">오전 08:00</a></li>
			                    <li><a onclick="setTimesS(this);">오전 09:00</a></li>
			                    <li><a onclick="setTimesS(this);">오전 10:00</a></li>
			                    <li><a onclick="setTimesS(this);">오전 11:00</a></li>
			                    <li><a onclick="setTimesS(this);">오후 12:00</a></li>
			                    <li><a onclick="setTimesS(this);">오후 01:00</a></li>
			                    <li><a onclick="setTimesS(this);">오후 02:00</a></li>
			                    <li><a onclick="setTimesS(this);">오후 03:00</a></li>
			                    <li><a onclick="setTimesS(this);">오후 04:00</a></li>
			                    <li><a onclick="setTimesS(this);">오후 05:00</a></li>
			                    <li><a onclick="setTimesS(this);">오후 06:00</a></li>
			                    <li><a onclick="setTimesS(this);">오후 07:00</a></li>
			                    <li><a onclick="setTimesS(this);">오후 08:00</a></li>
			                    <li><a onclick="setTimesS(this);">오후 09:00</a></li>
			                    <li><a onclick="setTimesS(this);">오후 10:00</a></li>
			                    <li><a onclick="setTimesS(this);">오후 11:00</a></li>
			                </ul>
			            </div>
			            <div class="btn-group">
		                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" id="etime">종료시간<span class="caret"></span></button>
		                <ul class="dropdown-menu scrollable-menu" role="menu">
		                    <li><a onclick="setTimesE(this);">오전 12:00</a></li>
		                    <li><a onclick="setTimesE(this);">오전 01:00</a></li>
		                    <li><a onclick="setTimesE(this);">오전 02:00</a></li>
		                    <li><a onclick="setTimesE(this);">오전 03:00</a></li>
		                    <li><a onclick="setTimesE(this);">오전 04:00</a></li>
		                    <li><a onclick="setTimesE(this);">오전 05:00</a></li>
		                    <li><a onclick="setTimesE(this);">오전 06:00</a></li>
		                    <li><a onclick="setTimesE(this);">오전 07:00</a></li>
		                    <li><a onclick="setTimesE(this);">오전 08:00</a></li>
		                    <li><a onclick="setTimesE(this);">오전 09:00</a></li>
		                    <li><a onclick="setTimesE(this);">오전 10:00</a></li>
		                    <li><a onclick="setTimesE(this);">오전 11:00</a></li>
		                    <li><a onclick="setTimesE(this);">오후 12:00</a></li>
		                    <li><a onclick="setTimesE(this);">오후 01:00</a></li>
		                    <li><a onclick="setTimesE(this);">오후 02:00</a></li>
		                    <li><a onclick="setTimesE(this);">오후 03:00</a></li>
		                    <li><a onclick="setTimesE(this);">오후 04:00</a></li>
		                    <li><a onclick="setTimesE(this);">오후 05:00</a></li>
		                    <li><a onclick="setTimesE(this);">오후 06:00</a></li>
		                    <li><a onclick="setTimesE(this);">오후 07:00</a></li>
		                    <li><a onclick="setTimesE(this);">오후 08:00</a></li>
		                    <li><a onclick="setTimesE(this);">오후 09:00</a></li>
		                    <li><a onclick="setTimesE(this);">오후 10:00</a></li>
		                    <li><a onclick="setTimesE(this);">오후 11:00</a></li>
		                </ul>
		            </div>
            		</div>
            	</div>
            <input type="hidden" id="region" name="region" value="${region}" readonly>
            <div class="col-12 form-label m-0 p-0">어떤 돌봄을 할 수 있나요?</div>
            <div class="row p-2">
			    <div class="col-sm-4 col-mb-4">
			    <div class="d-flex justify-content-between border border-primary mb-3 rounded rounded-3 text-primary shadow-sm">
			    	<div class="p-2">산책</div>
			    	<div class="p-2 texxt-center">
			    	<input type="checkbox" id="kind" name="kind" value="산책" onclick="tagChange(event)" 
			            <c:if test="${fn:contains(dolbom.kind,'산책')}">checked</c:if>>
			    	</div>
			    </div>
			    </div>
			    <div class="col-sm-4 col-mb-4">
			    <div class="d-flex justify-content-between border border-primary mb-3 rounded rounded-3 text-primary shadow-sm">
			    	<div class="p-2">방문돌봄</div>
			    	<div class="p-2 texxt-center">
			    	<input type="checkbox" id="kind" name="kind" value="방문돌봄" onclick="tagChange(event)" 
			          	<c:if test="${fn:contains(dolbom.kind,'방문돌봄')}">checked</c:if>>
			    	</div>
			    </div>
			    </div>
			    <div class="col-sm-4 col-mb-4">
			    <div class="d-flex justify-content-between border border-primary mb-3 rounded rounded-3 text-primary shadow-sm">
			    	<div class="p-2">위탁돌봄</div>
			    	<div class="p-2 texxt-center">
			    	<input type="checkbox" id="kind" name="kind" value="위탁돌봄" onclick="tagChange(event)" 
			            <c:if test="${fn:contains(dolbom.kind,'위탁돌봄')}">checked</c:if>>
			    	</div>
			    </div>
		    	</div>
			</div>
			<div class="col-12 form-label m-0 p-0">돌봄 내용을 상세히 적어주세요</div>
            <textarea rows="5" cols="50" id="content" name="content" class="form-control" placeholder="제공 가능한 돌봄 내용을 작성해주세요">${fn:replace(dolbom.content,"<br/>","&#10;")}</textarea>
            <div class="col-12 form-label m-0 p-0">대표사진</div>
            <div class="col-12 mb-4">
				<div id="imageList" class="row rounded border bg-white">
		      		<div id="plus" class="plus box-wrap col-md-2 col-2"><div class="plus box border rounded d-flex justify-content-center"><div class="img row text-center"><span class="plus col-12 bi bi-plus-lg align-self-center" style="margin:auto;"></span></div></div></div>
		      		<input class="form-control" type="file" id="upload" style="display:none" multiple accept=""/>
	      		</div>
	      	</div>
			</div>
			<!-- 돌보미가 될게요 폼 끝 -->
			<!-- 검색 키워드 선택 폼 시작 -->
			<div class="headtitle"><h3>검색 키워드 선택</h3></div>
			    <div class="rounded shadow bg-white p-5">		
			    <div class="col-12 form-label m-0 p-0">희망 이웃을 선택해주세요</div>
			    <div class="row p-2">
				    <div class="col-sm-4 col-mb-4">
				    <div class="d-flex justify-content-between border border-primary mb-3 rounded rounded-3 text-primary shadow-sm">
				    	<div class="p-2">견주</div>
				    	<div class="p-2 texxt-center">
				    	<label for="neighbor1">
				    	<input type="radio" name="neighbor" id="neighbor1" value="견주" onclick="tagChange(event)" 
				    	<c:if test="${tag.neighbor eq '견주'}">checked="checked"</c:if>>
				    	</label>
				    	</div>
				    </div>
				    </div>
				    <div class="col-sm-4 col-mb-4">
				    <div class="d-flex justify-content-between border border-primary mb-3 rounded rounded-3 text-primary shadow-sm">
				    	<div class="p-2">집사</div>
				    	<div class="p-2 texxt-center"
				    	><label for="neighbor2">
				    	<input type="radio" name="neighbor" id="neighbor2" value="집사" onclick="tagChange(event)" 
				    	<c:if test="${tag.neighbor eq '집사'}">checked="checked"</c:if>>
				    	</label>
				    	</div>
				    </div>
				    </div>
				    <div class="col-sm-4 col-mb-4">
				    <div class="d-flex justify-content-between border border-primary mb-3 rounded rounded-3 text-primary shadow-sm">
				    	<div class="p-2">상관없음</div>
				    	<div class="p-2 texxt-center">
				    	<label for="neighbor3">
				    	<input type="radio" name="neighbor" id="neighbor3" value="견주/집사" onclick="tagChange(event)" 
				    		<c:if test="${tag.neighbor eq '견주/집사'}">checked="checked"</c:if>>
				    	</label></div>
				    </div>
			    	</div>
			    </div>
			    <div class="col-12 form-label m-0 p-0">사전만남을 원하시나요?</div>
			    <div class="row p-2">
				    <div class="col-sm-6 col-mb-6">
					    <div class="d-flex justify-content-between border border-primary mb-3 rounded rounded-3 text-primary shadow-sm">
					    	<div class="p-2">사전만남 원해요</div>
					    	<div class="p-2 texxt-center">
					    	<label for="meeting1">
					    	<input type="radio" name="meeting" id="meeting1" value="사전만남" onclick="tagChange(event)" 
					    	<c:if test="${tag.meeting eq '사전만남'}">checked="checked"</c:if>></label>
					    	</div>
					    </div>
					</div>
					<div class="col-sm-6 col-mb-6">
					    <div class="d-flex justify-content-between border border-primary mb-3 rounded rounded-3 text-primary shadow-sm">
					    	<div class="p-2">사전만남 없어도 돼요</div>
					    	<div class="p-2 texxt-center">
					    	<label for="meeting2"><input type="radio" name="meeting" id="meeting2" value="X" onclick="tagChange(event)" 
					    	<c:if test="${tag.meeting eq 'X'}">checked="checked"</c:if>></label></div>
					    </div>
					</div>
			    </div>
			    <div class="col-12 form-label m-0 p-0">대형견을 케어할 수 있나요?</div>	
			    <div class="row p-2">
				    <div class="col-sm-6 col-mb-6">
					    <div class="d-flex justify-content-between border border-primary mb-3 rounded rounded-3 text-primary shadow-sm">
					    	<div class="p-2">대형견 케어 가능해요</div>
					    	<div class="p-2 texxt-center">
					    	<input type="radio" name="bigcare" id="bigcare1" value="대형견케어" onclick="tagChange(event)" 
					    	<c:if test="${tag.bigcare eq '대형견케어'}">checked="checked"</c:if>></div>
					    </div>
					</div>
					<div class="col-sm-6 col-mb-6">
					    <div class="d-flex justify-content-between border border-primary mb-3 rounded rounded-3 text-primary shadow-sm">
					    	<div class="p-2">대형견 케어 어려워요</div>
					    	<div class="p-2 texxt-center">
					    	<input type="radio" name="bigcare" id="bigcare2" value="대형견불가" onclick="tagChange(event)" 
					    	<c:if test="${tag.bigcare eq '대형견불가'}"></c:if>></div>
					    </div>
					</div>
			    </div>
			</div>
			<!-- 검색 키워드 폼 끝-->          
            <div class="write-btn" align="center">
            	<button type="button" class="btn text-black rounded-pill px-4 text-white submitMsgBtn" id="saveButton" onClick="submit();" style="background-color:#a091f3;border:none;">수정하기</button>
            </div>
         	<input type="hidden" id="workstime" value="${dolbom.workstime}">
         	<input type="hidden" id="worketime" value="${dolbom.worketime}">
         	<input type="hidden" id="dol_seq" value="${dolbom.dol_seq}"> 				
		</div>
	</section>
    
    
    <%@include file="../footer.jsp" %>

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

	<script>
		var stime = $("#workstime").val();
		var etime = $("#worketime").val();
		var dol_seq = $("#dol_seq").val();
		$(function(){
			$("#stime").html(stime);
			$("#etime").html(etime);
		});
		function setTimesS(e){
			stime = $(e).text();
			console.log(stime);
			$("#stime").html(stime);
			
		}
		function setTimesE(e){
			etime = $(e).text();
			console.log(etime);
			$("#etime").html(etime);
			
		}
		 function tagChange(e){
			 var checkboxKinds = [];
			    $("input[name='kind']:checked").each(function(i) {
			    	checkboxKinds.push($(this).val());
			    });
			 if(checkboxKinds==''){
				 console.log("비었음");
				 checkboxKinds = [''];
			 }
			 var neighbor = $("input[name='neighbor']:checked").val();
			 var meeting = $("input[name='meeting']:checked").val();
			 var bigcare = $("input[name='bigcare']:checked").val();
			    
			 $.ajax({
				 url: "../dolbom/he_tagitems.json",
				 type: "GET",
				 data: {checkboxKinds:checkboxKinds,neighbor:neighbor,meeting:meeting,bigcare:bigcare		 
				 },
				 success: function(data){
					 var html = "";
					 if(data.kind.length != 0){
					 html += "#"+data.kind+" ";
					 }
					 if(data.neighbor != null){
					 html += "#"+data.neighbor+" ";
					 }
					 if(data.meeting != null && data.meeting != "X"){
					 html += "#"+data.meeting;
					 }
					 if(data.bigcare != null){
				     html += "#"+data.bigcare;
					 }					 
					 $("#tags").html(html);
				 }
			 });
		 }
		 var selectedImages = [];
		 var savedImages = [];
    	 var imgNum = 0;
    	 $(function(){
    		 <c:forEach var="i" items="${files}">
 				savedImages.push({fname: '${i.fname}', ofname: '${i.ofname}'});
 			</c:forEach>
 		
 			if(savedImages != null){
	 			var html = "";
	 			savedImages.forEach(function(i, idx){
	 				html += "<div class='savedImg box-wrap col-2'>";
   					html += "<div class='box' onmouseenter='attachX(this,"+imgNum+");' onmouseleave='ditachX();'>";
   					html += "<img class='img rounded' src='/market/display?imgName="+i.fname+"' title='"+i.ofname+"'>";
   					html += "</div>";
   					html += "</div>";
   					imgNum ++;
    			});
    			$("#imageList").append(html);
    	 	}
 			$("#plus").on("click", function(){
    			$("#upload").click();	
    		});
 			$("#upload").on("change", function(e){
 				var images = e.target.files;
    			imageArr = Array.prototype.slice.call(images);
    			preview(imageArr);
 			});
    	 });
    	 function preview(imageArr){
      		imageArr.forEach(function(i, idx){
      			if(i.type.match('image.*')){
      				var reader = new FileReader();
      				selectedImages.push(i);
      				reader.onload = function(e){
      					var html = "";
    					html += "<div class='selectedImg box-wrap col-2'>";
    					html += "<div class='box' onmouseenter='attachX(this,"+imgNum+");' onmouseleave='ditachX();'>";
    					html += "<img class='img rounded' src='"+e.target.result+"' title='"+i.name+"'>";
    					html += "</div>";
    					html += "</div>";
    					imgNum ++;
    					$("#imageList").append(html);
      				}
      				reader.readAsDataURL(i);
      			}else{
      				
      			}
      		});
      		$("#upload").val("");
      	}
    	 /*function uploadClick(){
 			$("#upload").click();
 		}*/
    	 function attachX(imgObj, imgNum){
     		$(imgObj).append("<div id='X' class='img bi bi-dash-circle-fill text-danger text-right px-1' onclick='deleteClick(this, "+ imgNum +");'></div>");
     	}
     	
     	function ditachX(){
     		$("#X").remove();
     	}
  	
	  	function deleteClick(imgObj, i){
	  		var parent = $(imgObj).parent().parent();
    		if(parent.attr("class").includes("saved")){
    			//savedImages.splice(i, 1);
    			console.log(savedImages);
    			delete savedImages[i].ofname;
    			$(parent).remove();
    			console.log(savedImages[i].ofname);
    			console.log(savedImages);
    		}else if(parent.attr("class").includes("selected")){
				selectedImages.splice(i, 1);
				$(parent).remove();
				console.log(selectedImages);
    		}
	  	}
		 function submit(){
				var formData = new FormData();
				
				for(var i=0; i<selectedImages.length; i++){
					if(selectedImages[i] != null){
						formData.append("multipartFiles", selectedImages[i]);
					}
				}
				for(var i=0, j=0; i<savedImages.length; i++){
					if(savedImages[i].ofname == null){
						formData.append("fnames["+j+"]", savedImages[i].fname);
						j++;
					}else{
						formData.append("fnames[0]", null);
					}
				}
				var checkboxKinds = [];
			    $("input[name='kind']:checked").each(function(i) {
			    	checkboxKinds.push($(this).val());
			    });
				 if(checkboxKinds==''){
					 console.log("비었음");
					 checkboxKinds = [''];
				 }
				//document.helpf.submit();
				formData.append("content", $("#content").val());
				formData.append("kind", checkboxKinds);
				formData.append("region", $("#region").val());
				formData.append("workday", $("#workday").val());
				formData.append("workstime", stime);
				formData.append("worketime", etime);
				formData.append("neighbor",$("input[name='neighbor']:checked").val());
				formData.append("meeting",$("input[name='meeting']:checked").val());
				formData.append("bigcare",$("input[name='bigcare']:checked").val());
				formData.append("dol_seq", dol_seq);
				$.ajax({
					type : "POST",
					url : "/dolbom/he_update.json",
					data : formData,
					processData : false,
					contentType : false,
					success : function(data){
						if(data){
							location.href="/dolbom";
						}
					}
				});
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
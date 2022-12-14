<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">
	<head>
    <title>Pet Care</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=yes">
    <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
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
	    <% session.removeAttribute("key"); %>
	    <% session.removeAttribute("word"); %>
	    <% session.removeAttribute("pageNum"); %>
	    
    	var selectedImages = [];
    	var savedImages = [];
    	var imgNum = 0;
    	var number = 0;
    	
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
   					$("#imgNum").html(" ( "+imgNum+" / 10 )");
    			});
    			$("#imageList").append(html);
    		}
    		$(".check").on("click", function(){
				if($(".bi-gift-fill").length){
    				$(".bi-gift-fill").removeClass("bi-gift-fill").addClass("bi-gift");
    				$(".bi-gift").next().css("color", "lightgray");
    				$("#price").prop("readonly", false);
    				$("#price").val("");
    			}else if($(".bi-gift").length){
    				$(".bi-gift").removeClass("bi-gift").addClass("bi-gift-fill");
    				$(".bi-gift-fill").next().css("color", "gray");
    				$("#price").prop("readonly", true);
    				$("#price").val(null);
    			}
    		});
    		
    		$("#category").val("${contents.category}").prop("selected",true);
    		$("#title").val("${contents.title}");
    		if(${contents.price} == 0){
    			$(".check").click();
    		}else{
    			$("#price").val("${contents.content}");
    		}
    		
    		$("#price").on("keyup", function(e){
    			number = e.target.value;
    			while(number.includes(",")){
    				number = number.replace(",", "");
    			}
    			if(number.startsWith("99999999")){
   					$(this).val("");
    				return false;
    			}
    			
    			number = Number(number);
    			
    			if(isNaN(number)){
    				$(this).val("");
    			}else if(number > 100000000){
    				$(this).val("");
    			}else{
    				$(this).val(number.toLocaleString('ko-KR'));
    			}
    			

    		})
    		$("#plus").on("click", function(){
    			$("#upload").click();	
    		});
    		
    		$("#upload").on("change", function(e){
    			var images = e.target.files;
    			if((images.length+imgNum)>10 || imgNum>=10){
    				showModal("????????? ?????? 10????????? ???????????? ??????????????? !");
        			$("#upload").val(null);
    				return false;
    			}
    			imageArr = Array.prototype.slice.call(images);
    			for(var i=0; i<images.length; i++){
    				if(!checkExtension(images[i].name)){
    					showModal("????????? ????????? ???????????? ??????????????? !");
    	    			$("#upload").val(null);
    					return false;
    				}
    			}
    			preview(imageArr);
    			$("#upload").val(null);
       		});
    	})
    	function checkExtension(fileName){
    		var regex = new RegExp("\.(bmp|gif|jpg|jpeg|png)$");
    		if(!(regex.test(fileName))){
    			return false;
    		}else{
    			return true;
    		}
    	}
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
    					$("#imgNum").html(" ( "+imgNum+" / 10 )");
    					$("#imageList").append(html);
    				}
    				reader.readAsDataURL(i);
    			}else{
    				
    			}
    		});
    	}
    	
    	function attachX(imgObj, imgNum){
    		$(imgObj).append("<div id='X' class='img bi bi-dash-circle-fill text-danger text-right px-1' onclick='deleteClick(this, "+ imgNum +");'></div>");
    	}
    	
    	function ditachX(){
    		$("#X").remove();
    	}
    	
    	function deleteClick(imgObj, i){
    		var parent = $(imgObj).parent().parent();
    		if(parent.attr("class").includes("saved")){
    			delete savedImages[i].ofname;
    			$(parent).remove();
    		}else if(parent.attr("class").includes("selected")){
				selectedImages.splice(i, 1);
				$(parent).remove();
    		}
    		imgNum --;
    		$("#imgNum").html(" ( "+imgNum+" / 10 )");
    	}
    	function showModal(text){
    		$(".modal-body").html("<span class='text-center'>"+text+"</span>");
			$("#modal").modal("show");
    	}
    	function validate(){
    		if(imgNum==0){
    			showModal("????????? ??? ??? ?????? ????????? ????????? !");
    		}else if($("#content").val() == ""){
    			showModal("????????? ????????? ????????? !");
    			$("#content").focus();
    		}else if($("#title").val() == ""){
    			showModal("????????? ????????? ????????? !");
    			$("#title").focus();
    		}else{
    			update();
    		}
    	}
    	function update(){
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
				}
			}
			
			formData.append("sm_seq", "${contents.sm_seq}");
			formData.append("category", $("#category").val());
			formData.append("title", $("#title").val());
			formData.append("content", $("#content").val());
			formData.append("price", number);

			$.ajax({
				type : "POST",
				url : "/market/update.json",
				data : formData,
				processData : false,
				contentType : false,
				success : function(data){
					if(data){
						location.href="/market";
					}
				}
			});
    	}
    </script>
    <style>
       .img.row.text-center{
    		margin:0 auto;
    	}
    	.check{
    		line-height:1.2rem;
    	}
    	.bi-gift, .bi-gift-fill{
    		font-size:16px;
    	}
    	.bi-gift-fill{
    		color:lightcoral !important;
    	}
    	.bi-gift, #won{
    		color:lightgray !important;
    	}
    	.nanoom .text-center{
    		color:lightgray;
    		font-size:12px;
    	}
	    .btn:hover{
    		filter:brightness(1.5) !important;
    	}
    	select{
    		text-align:center;
    		padding-left: 0rem !important;
    		padding-right: 1rem !important;
    	}
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
    	span.plus{
    		font-size:2rem;
    	}
    	#plus:hover, .selectedImg:hover, .savedImg:hover{
    		opacity:0.5;
    	}
    	#category, #title, #content {
    		border-color: #dee2e6;
    	}
    	#content{
    		padding:3rem;
    	}
    	.headtitle{
			margin:auto;
			text-align:center;
			font-weight:bold;
		}
		.headtitle h3{
			opacity: .8;
			background: linear-gradient(to bottom right, #97a3ea 20%, #a091f3 60%, #9283f2 90%) no-repeat;
			color:white;
			border-radius:5px;	
		}
    </style>
  	</head>
	<body>
		<%@include file="../header.jsp" %>
	    <section class="ftco-section bg-light">
		    <div class="container">
			    <div class="modal fade" id="modal" tabindex="-1" aria-labelledby=modalLabel" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered justify-content-center">
						<div class="modal-content" style="width:80%; border: 1px solid lightgray">
							<div class="modal-header text-end border-0">
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="font-size:0.8rem"></button>
							</div>
							<div class="modal-body text-center pt-4 pb-5">
							</div>
						</div>
					</div>
				</div>
				<div class="headtitle"><h3>???????????? ??? ??????</h3></div>
				<div class="row rounded shadow bg-white p-5">
		      		<div class="col-12 mb-md-4 mb-2">
		      			<div class="row">
		      				<div class="col-12 col-md-6 p-0">
				      			<div>???????????? / ??????</div>
								<div class="input-group p-0 mb-2 mb-md-0 border rounded">
									<select id="category" class="col-4 col-md-4 form-select border-0" aria-label="Default select example">
										<option value="??????">??????</option>
										<option value="??????">??????</option>
										<option value="?????????">?????????</option>
	    								<option value='????????????'>????????????</option>
	    								<option value='??????'>??????</option>
	    								<option value='??????/??????'>??????/??????</option>
									</select>
									<input id="title" type="text" class="form-control border-0" aria-label="Text input with dropdown button">
								</div>
							</div>
							<div class="col-12 col-md-6 pr-md-0 pl-md-2 p-0">
				      			<div id="dealType">?????? ??????</div>
				      			<div class="input-group p-0 border rounded">
									<div id="won" class="align-self-center px-3" style="color:gray !important">&#65510;</div>
				      				<input id="price" type="text" class="form-control border-0" placeholder="????????? ????????? ????????? !">
				      				<div class="check align-self-center">
				      					<div class="nanoom pt-1">
					      					<div class="bi bi-gift px-3"></div>
					      					<div class="nanoom text-center">??????</div>
				      					</div>
				      				</div>
				      			</div>
				      		</div>
				      	</div>
					</div>
		      		<div class="col-12 form-label m-0 p-0">??????<span id="imgNum"> ( 0 / 10 )</span></div>
		      		<div class="col-12 mb-4">
				      	<div id="imageList" class="row rounded border bg-white">
				      		<div id="plus" class="plus box-wrap col-2"><div class="plus box border rounded"><div class="img row text-center"><span class="plus col-12 bi bi-plus-lg align-self-center p-0 fs-5"></span></div></div></div>
				      		<input class="form-control" type="file" id="upload" style="display:none" multiple accept=""/>
				      	</div>
				    </div>
				    <div class="col-12 form-label m-0 p-0">??????</div>
				    <div class="col-12 mb-4">
					    <div class="row">
						<textarea class="col-12 form-control" id="content" rows="10" style="resize:none">${fn:replace(contents.content,"<br/>","&#10;")}</textarea>
						</div>	
				    </div>
			    	<div class="col-6 px-1 text-right">
			    		<input type="button" class="btn btn-light rounded-pill px-4 text-secondary" value="??????"/>
			    	</div>
			    	<div class="col-6 px-1">
			    		<input type="button" class="btn text-black rounded-pill px-4 text-white" style="background-color:#a091f3" value="??????" onClick="validate();"/>
			    	</div>
			    </div>
			</div>
    	</section>
    	<%@include file="../footer.jsp" %>
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
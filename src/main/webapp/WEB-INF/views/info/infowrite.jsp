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
    <link rel="stylesheet" href="/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="/css/jquery.timepicker.css">
    <link rel="stylesheet" href="/css/flaticon.css">
    <link rel="stylesheet" href="/css/style.css">
    
    <!-- 드래그앤드랍 -->
    <script src="https://code.jquery.com/jquery-latest.js"></script>
    <script type="text/javascript" src="../js/map.js"></script>
	<script type="text/javascript" src="../js/stringBuffer.js"></script>
    <!-- alert -->
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script>   
    $(document).ready(function(){
		var m_seq = "${sessionScope.member.m_seq}";
		if(!m_seq.includes("ADMIN")){
			alert("관리자만 볼 수 있습니다.");
			location.href="/";
		}
	});
    //데이터처리 
    var fd = new FormData();
    var map = new Map();
    function submitFile(){
    	fd.append("title", $("#title").val());
		fd.append("content", $("#textarea").val());
		fd.append("admin", "관리자");
		if($("#pin").is(":checked")==true){
			fd.append("pin", $("#pin").val());
		}
    
    	$.ajax({
    		type: "POST",
    		url: "/info/infowrite.do",
    		data : fd,
    		processData : false,
			contentType : false,
			encType:"multipart/form-data",
    		success: function(data){
    			console.log(data);
    			if(data){
    				location.href="/info/list.do";
    			}else{
    				alert("안대요");
    			}
    		}
    	});
    }
    
    function handleFileUpload(files){
    	var megaByte = 1024*1024;
    	console.log(files);
    	for(var i = 0; i < files.length; i++){
    		if(map.containsValue(files[i].name) == false && (files[i].size/megaByte) <=20){
    			fd.append(files[i].name, files[i]);
    			map.put(files[i].name, files[i].name);
    			var tag = createFile(files[i].name, files[i].size);
    			$('#fileTable').append(tag);
    		}else{
    			if((files[i].size/megaByte)>20){
    				alert(files[i].name+"은(는) \n 20메가보다 커서 업로드 불가");
    			}else{
    				//swal("중복 파일 불가","중복 파일은 업로드 불가합니다: "+ files[i].name, 'warning');
    				alert("중복 파일은 업로드 불가합니다: " + files[i].name);
    			}
    		}
    	}
    }
    
    //업로드 파일목록 생성
    function createFile(fileName, fileSize){
    	var file = {
    			name : fileName,
    			size : fileSize,
    			format : function(){
    				var sizeKB = this.size / 1024;
    				if (parseInt(sizeKB)>1024){
    					var sizeMB = sizeKB /1024;
    					this.size = sizeMB.toFixed(2) + "MB";
    				}else{
    					this.size = sizeKB.toFixed(2) + "KB";
    				}
    				if(name.length>70){
    					this.name = this.name.substr(0,68)+"...";
    				}
    				return this;
    				
    			},
    			tag : function(){
    				var tag = new StringBuffer();
    				console.log("태그생성 위");
    				tag.append('<tr id = "draglist">');
    				tag.append('<td>'+this.name+'</td>');
    				tag.append("<td><input type='button' class='text-white' style='background-color:#a091f3;border:none;border-radius:2px;' id='"+this.name+"' onclick='delFile(this)' value='X'></td>");
    				tag.append('</tr>');
    				return tag.toString();
    			}
    			
    	}
    	return file.format().tag();
    }
    
    function delFile(e){
    	var formName = e.id;
    	
    	fd.delete(formName);
    	
    	map.remove(formName);
    	
    	$(e).parents('#draglist').remove();
    }
    
    
    
  	//드래그앤드랍 이벤트
    $(document).ready(function(){
    	var objDragDrop = $(".dragDropDiv");
    	$(".dragDropDiv").on("dragover",
    		function(e){
    			e.stopPropagation();
    			e.preventDefault();
    			$(this).css('border', '1px solid red');
    	});
		$(".dragDropDiv").on("drop", function(e){
			$(this).css('border', '1px solid #dee2e6');
			e.preventDefault();
			var files = e.originalEvent.dataTransfer.files;
			handleFileUpload(files);
		});
		$(document).on('dragover', function(e){
			e.stopPropagation();
			e.preventDefault();
			objDragDrop.css('border', '1px solid #dee2e6');
		});
    });
    function check(){
    	for(var i=0; i<document.input.elements.length; i++)
		{
    		if(document.input.elements[i].value == "")
			{
    			if(i==1) continue;
    			if(i==2) continue;
    			alert("모든 값을 입력하셔야 합니다.");
    			return false;
    		}
		}
    	submitFile();
    }
    $(function(){
    	$("#clickuploadbtn").on("click", function(){
        	$("#clickupload").click();
        });
    	$("#clickupload").on("change", function(e){
    		var files = e.target.files;
    		handleFileUpload(files);
    		e.target.value="";
    	});
    });
    </script>
   	<style>
  	.dragDropDiv{
	  	width:100%;
	  	height:100%;
	  	text-align:center;
	  	border-radius:0.25rem;
  		border:1px solid #dee2e6;
  	}
  	#fileTable{
  		width:100%;
  	}
  	#tabFileName{
  		width: 70%;
  		text-align: center;
  	}
  	#tabFileSize{
  		width: 20%;
  	}
  	#tabFileDel{
  		width: 10%;
  	}
  	#title{
  		width: 100%;
  		border-radius:0.25rem;
  		border:1px solid #dee2e6;
  	}
  	.content{
  		height: 100%;
  		width: 100%;
  		border-radius:0.25rem;
  		border:1px solid #dee2e6;
  	}
  	.title:focus{
  		outline: none;
  	}
  	.content:focus{
  		outline: none;
  	}
  	
  	table{
  		width: 80%;
  		margin:auto;
  	}
  	.write-btn{
  		text-align:center;
  	}
  	#writetable{
  		border-collapse: separate;
  		border-spacing: 0 5px;
  		width:100%;
  	}
  	#clickupload{
  		display: none;
  	}
  	#clickuploadbtn{
  		border: 1px solid #cbcbcb;
  		background-color: #fff;
  	}
  	#clickuploadbtn:focus{
  		outline: none;
  	}
  	#clickuploadbtn:hover{
  		cursor: pointer;
  	}
  	.btn{
  		border: 1px solid #dee2e6;
  	}
  	.btn:hover{
    	filter:brightness(1.1) !important;
    	border: 1px solid #dee2e6;
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
    <form name="input">
    <div class="container">
    <div class="headtitle"><h3>공지사항 글 작성</h3></div>
    <div class="input-table row rounded shadow bg-white py-5 px-3 px-md-4">
    	<table id="writetable">
    	<tbody>
    	<tr>
    		<td><input type="text" id="title" class="title" name="title" placeholder="제목을 입력하세요"></td>	
    	</tr>
    	<tr>
    		<td><button type='button' id='clickuploadbtn'>내 파일</button></td>
    	</tr>
    	<tr>
	    	<td>
		    	<div id="fileUpload" class="dragDropDiv">
			    	<table id='fileTable'>
				    	<tr>
					    	<td id='tabFileName'>파일명</td>
					    	<td id='tabFileDel'>삭제</td>
				    	</tr>
				    	<tr>
				    		<td><input type="file" id='clickupload' multiple></td>
				    	</tr>
			    	</table>
		    	</div>
	    	</td>
    	</tr>
    	<tr>
    		<td><textarea rows="10" cols="50" class="content" id="textarea" name="content" placeholder="내용을 입력하세요"></textarea></td>
    	</tr>
    	<tr>
	    	<td>
	    		<c:if test="${fn:contains(sessionScope.member.m_seq,'ADMIN') }">
		    	<div class="write-btn" align="right">
		    		<input type="checkbox" id="pin" name="pin" value=1>고정글<br><br><br>
					<input type="button" class="btn btn-light rounded-pill px-4 text-secondary"  value="목록"onclick="location.href='/info/list.do'">	
					<input type="button" class="btn text-black rounded-pill px-4 text-white" style="background-color:#a091f3" value="등록" onclick="check()">
					<input type="hidden" name="admin" value="관리자" id="admin">
				</div>
				</c:if>
			</td>
    	</tr>
    	</tbody>
    	</table>
    </div>
    </div>
    </form>
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

  </body>
</html>
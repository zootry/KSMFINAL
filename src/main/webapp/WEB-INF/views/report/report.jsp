<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table{
	width:50%;
	margin:auto;
}
</style>
</head>
<body>
<div class="reportdiv" id="reportdiv">
<form method="post" action="report.do" name="report">
<table>
<tr>
<td>작성자 닉네임</td>
<td id="rep_wemail">${report.rep_wemail}</td>
</tr>
<tr>
<td>신고자 닉네임</td>
<td id="rep_remail">${report.rep_remail}</td>
</tr>
<tr>
<td>
<div id="selectdiv">
<span>신고 사유</span>
<select id="rep_reason" name="rep_reason">
<option value="약속파기">약속파기</option>
<option value="욕설/비방">욕설/비방</option>
<option value="음란물/혐오스러운 사진">음란물/혐오스러운 사진</option>
<option value="홍보/상업성">홍보/상업성</option>
<option value="도배">도배</option>
</select>
</div>
</td>
</tr>
<tr><td><textarea id="rep_content" name="rep_content" placeholder="구체적인 신고 사유를 입력해주세요"></textarea></td></tr>
<tr><td><div id="btns">
<input type="hidden" id="rep_wemail" name="rep_wemail" value="${report.rep_wemail}">
<input type="hidden" id="rep_remail" name="rep_remail" value="${report.rep_remail}">
<input type="hidden" id="rep_wseq" name="rep_wseq" value="${report.rep_wseq}">
<input type="hidden" id="rep_state" name="rep_state" value="미처리">
<button class="sendBtn" id="sendBtn">전송</button>
<button class="closeBtn" id="closeBtn">닫기</button>
</div>
</td></tr>
</table>
</form>
</div>

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
	if(!"${sessionScope.email}"){
		alert("로그인 안됨");
		history.back();
	}else if("${report.rep_wemail}" == "${report.rep_remail}"){
		//alert("${report.rep_remail}");
		//alert("${report.rep_wemail}");
		alert("자기 자신 신고 불가");
		history.back();
	}
});
</script>
</body>
</html>
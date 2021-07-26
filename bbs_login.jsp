<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>

<script>
	$(function() {
		$('#loginBtn').click(function() {
				var oo = {};
				oo.cmd = "login";
				oo.id = $('#id').val();
				oo.pw = $('#pw').val();
				$.ajax({
					url : '/bbs/login_check',
					method : 'POST',
					data : oo,
					dataType : 'text',
					success : function(res) {
						if (eval(res)) {
							alert("로그인 성공");
							location.href = "/bbs/page";
						} else {
							alert("로그인 실패")
						}
					},
					error : function(xhr, textStatus, errorThrown) {
						alert(textStatus + ' : ' + errorThrown);

					}
				});
		});
	});
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그 폼</title>
<style>
div {
	margin: 0px auto;
	border: 1px solid black;
	width: 200px;
	height: 200px;
	padding: 10px;
}
#loginBtn {
	float: right;
}
</style>

</head>
<body>
	<form action="/bbs/login_check?cmd=login" method="post">
		<div>
			<h3 style = 'text-align: center;'>로그인</h3>
			아이디 <input type="text" id="id"><br> 
			암 호 <input	type="password" id="pw"><br><br>
			<button type="button" id='loginBtn'>로그인</button>
		</div>
	</form>
</body>
</html>
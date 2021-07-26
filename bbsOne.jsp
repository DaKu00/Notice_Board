<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String uid = (String) session.getAttribute("userid");
String check = null;
if (uid != null) {
	check = "logout";
} else
	check = "login";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#container {
	width: fit-content;
	padding: 10px;
	margin: 0px auto;
	margin-top: 50px;
	position: relative;
	overflow: hidden;
}

#text {
	padding: 10px;
	border: 1px solid black;
	border-radius: 5px;
}

#dat {
	width: fit-content;
	padding: 10px;
	border-radius: 7px;
	margin: 0px auto;
}

.datlist {
	width: fit-content;
	padding: 10px;
	border-radius: 7px;
	float: left;
	width: 100%;
}

#container>h3 {
	text-align: center;
	border-bottom: 3px double black;
}

#colums {
	border-top: none;
}

#colums1 {
	background: #ebf9ff;
}

div.row {
	border-top: 1px solid black;
}

div.contents {
	width: fit-content;
	border-bottom: 1px solid black;
	width: 100%;
}

#dat {
	margin: 0px auto;
}

a {
	text-decoration: none;
	text-color: black;
}

a:link {
	color: black;
	text-decoration: none;
}

a:visited {
	color: black;
	text-decoration: none;
}

a:hover {
	background-color: #dfe0ed;
	color: #8286c2;
}

span {
	display: inline-block;
	border-right: 1px solid black;
	text-align: center;
	padding: 5px;
}

span.num {
	width: 40px;
}

span.title {
	width: 240px;
}

span.title_f {
	background: #ebf9ff;
	width: 40px;
}

span.title_in {
	width: 300px;
	border-right: none;
}

span.writer {
	width: 80px;
}

span.writer2 {
	width: 60px;
	border-right: none;
}

span.date2 {
	width: 180px;
	border-right: none;
}

span.contents {
	text-align: left;
	width: 200px;
	border-right: none;
}

span.date {
	width: 180px;
}

span.hit {
	width: 50px;
	border-right: none;
}

.but {
	float: right;
	text-align: center;
}

.b {
	float: right;
	text-align: center;
}

.update {
	float: right;
	text-align: center;
}

span:nth-child(4) {
	border-right: none;
}

.login {
	position: absolute;
	right: 10px;
	top: 8px;
	border: 1px solid black;
	border-radius: 5px;
}

#nik {
	position: absolute;
	right: 100px;
	top: 14px;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<script>
	$(function() {
		$('.dathidden').css('display', 'none');
		$('.updateD2').css('display', 'none');
		$('.u').css('display', 'none');
		$('#g2').css('display', 'none');
		$('.b').click(function() {
			if ($('#' + this.id + 't').css('display') != 'none') {
				$('.u').css('display', 'none');
				$('#datlast').css('display', 'block');
			} else {
				$('.u').css('display', 'none');
				$('#' + this.id + 't').css('display', 'block');
				$('#datlast').css('display', 'none');
			}
		});

		$('#updateG').click(function() {
			$('#g').css('display', 'none');
			$('#g2').css('display', 'block');
		});

		//수정버튼을 눌렀을 때
		$('.updateD1').click(function() {

			$('#1up' + this.id).css('display', 'none');
			$('#2up' + this.id).css('display', 'block');
			$('.b').css('display', 'none');
			$('.updateD1').css('display', 'none');
			$('#' + this.id + 'd').css('display', 'block');
			$('#datlast').css('display', 'none');
			$('.u').css('display', 'none');
		});

	});

	$(function() { //댓글 등록

		$('.dbtn').click(function() {
				var oo = {};
				oo.writer = $('#user').val();
				oo.contents = $('#' + this.id + '1').val();
				oo.pnum = this.id
				alert(this.id)
				$.ajax({
					url : '/bbs/datadd', //보내는 곳, 서버에서 받는.. url에 연결된 프로그램
					method : 'GET', // 보내는 방식은 POST
					data : oo, //보낼 데이터는 jsobj안에 있는 데이터
					dataType : 'text', //응답될 때 DataType
					success : function(res) {
						if (eval(res)) {
							alert("등록 성공");
							location.href = "";
						} else {
							alert("등록 실패")
						}
					},
					error : function(xhr, textStatus, errorThrown) {
						alert(textStatus + ' : ' + errorThrown);

					}
				});
		});

		//로그아웃
		$('#logout').click(function() {
			var oo = {};
			oo.cmd = "logout";
			$.ajax({
				url : '/bbs/login_check',
				method : 'POST',
				data : oo,
				dataType : 'text',
				success : function(res) {
					if (eval(res)) {
						alert("로그인아웃 성공");
						location.href = "";
					} else {
						alert("로그인 실패")
					}
				},
				error : function(xhr, textStatus, errorThrown) {
					alert(textStatus + ' : ' + errorThrown);

				}
			});
		});

		//게시글
		$('#updateG2').click(function() {
			var oo = {};
			oo.contents = $('#updatetext').val();
			oo.num = $('#gid').val();
			$.ajax({
				url : '/bbs/update_G',
				method : 'POST',
				data : oo,
				dataType : 'text',
				success : function(res) {
					if (eval(res)) {
						alert("게시글 수정 성공");
						location.href = "";
					} else {
						alert("게시글 수정 실패")
					}
				},
				error : function(xhr, textStatus, errorThrown) {
					alert(textStatus + ' : ' + errorThrown);

				}
			});
		});

		//댓글
		$('.updateD2').click(function() {
				var oo = {};
				var nb = this.id.replace("d", "")
				oo.contents = $('#2up' + nb).val();
				oo.num = nb;
				$.ajax({
					url : '/bbs/update_G',
					method : 'POST',
					data : oo,
					dataType : 'text',
					success : function(res) {
						if (eval(res)) {
							alert("댓글 수정 성공");
							location.href = "";
						} else {
							alert("댓글 수정 실패")
						}
					},
					error : function(xhr, textStatus, errorThrown) {
						alert(textStatus + ' : ' + errorThrown);

					}
				});
		});
	});
</script>
</head>
<body>
	<div id='nik'>
		<c:if test='${login == true}'>
		${userid} 님
		</c:if>
	</div>
	
	<div id='btn'>
		<c:choose>
			<c:when test="${login != true}">
				<a href="/bbs/login"><span class="login"><%=check%></span></a>
			</c:when>
			<c:otherwise>
				<a href=''><span class="login" style='float: right;' id='logout'><%=check%></span></a>
			</c:otherwise>
		</c:choose>
	</div>


	<input type='hidden' id='user' value='${userid}'>
	<div id='container'>
		<div class="rowt" id='colums'>
			<span class="title_f">제목</span> <span class="title_in">${one.title}</span>
			<br>
		</div>
		<div class="row" id='colums1'>
			<span class="num">번호</span> <span class="writer">작성자</span> <span
				class="date">날짜</span> <span class="hit">조회수</span>

		</div>
		<div class="row" id='contents'>

			<span class="num" id='num'>${one.num}</span> <span class="writer"
				id='writer'>${one.writer}</span> <span class="date">${one.wdate}</span>
			<span class="hit">${one.hit}</span>
		</div>
		<p></p>
		<div id='g'>
			<div id="text" style="overflow: auto; width: 500px; height: 150px;">
				${one.contents}</div>
				<form  action="/bbs/download" method="post">
					<span style="margin-left: 250px; border-right: none;" >${file.filename}</span>
					<input type='hidden' name = 'filename' value='${file.filename}'>
					<c:choose>
						<c:when test="${file.filename != null}">
							<a href="/bbs/login"><span class="login"><%=check%></span></a>
							<button type="submit" class="but" id='download'>다운로드</button>
						</c:when>
					</c:choose>	
				</form>
			<c:if test="${login == true}">
				<c:if test="${one.writer == userid}">
					<button type="button" class="but" id='updateG'>수정</button>
				</c:if>
			</c:if>
		</div>
		<div id='g2'>
			<input id="updatetext"
				style="overflow: auto; width: 500px; height: 150px;"
				value="${one.contents}"> <input type='hidden' id='gid'
				value='${one.num}'>
			<div>
				<button type="button" class="but" id='updateG2'>수정완료</button>
			</div>
		</div>
		<br> <br> <br> <br> <br>
		<div class='datlist'>
			<c:forEach var="u" items="${dat}">
				<div class='contents' style="position: relative; left:${u.lvl}00px;">
					<span class="writer2">${u.writer}</span><span class="date2">${u.wdate}</span><br>
					<span id='1up${u.num}' class="contents">${u.contents}</span> <input
						id='2up${u.num}' type='text' value='${u.contents}'
						class='dathidden'>

					<div id='lb'
						style='position: absolute; right: ${u.lvl}00px; top:4px'>

						<c:if test="${login == true}">
							<button type='button' id='${u.num}' class='b'>답뵨</button>
							<c:if test="${u.writer == userid}">
								<br>
								<div style='position: absolute; top: 28px;' id='${u.num}d1'>
									<button type='button' id='${u.num}' class='updateD1'>수정</button>
								</div>
								<button type='button' id='${u.num}d' class='updateD2'>완료</button>
								<br>
							</c:if>
							<br>
						</c:if>
					</div>
				</div>

				<c:if test="${login == true}">

					<div id='${u.num}t' class='u' style='position: relative;'>
						댓글<br> <textarea style="resize: none; overflow: auto; width: 98%; height: 80px;" placeholder="글 입력" class="text_in" id='${u.num}1'></textarea>
						<br>
						<div style='position: absolute; bottom: 10px; right: 0px'>
							<button type="button" class='dbtn' id="${u.num}">등 록</button>
						</div>
						<br> <br>
					</div>
				</c:if>

			</c:forEach>

			<c:if test="${login == true}">
				<div id='datlast' style='position: relative;'>
					댓글<br>
						<textarea style="resize: none; overflow: auto; width: 98%; height: 80px;" placeholder="글 입력" class="text_in" id='${one.num}1'></textarea>
					<br>
					<div style='position: absolute; bottom: -8px; right: 0px'>
						<button type="button" class='dbtn' id="${one.num}">등 록</button>
					</div>
					<br>
				</div>
			</c:if>
		</div>
	</div>
</body>
</html>
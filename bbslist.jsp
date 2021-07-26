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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<script>

$(function() { //ready함수, 함수의 정의, 웹 페이지의 모든 테그들이 로드 된 후에 실행되는 함수 html을 객체로 참조 가능할때 실행되는 함수
	$('#logout').click(function() {
			var oo = {};
			oo.cmd = "logout";
			$.ajax({
				url : '/bbs/login_check', //보내는 곳, 서버에서 받는.. url에 연결된 프로그램
				method : 'POST', // 보내는 방식은 POST
				data : oo, //보낼 데이터는 jsobj안에 있는 데이터
				dataType : 'text', //응답될 때 DataType
				success : function(res) {
					if (eval(res)) {
						alert("로그인아웃 성공");
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
<title>Insert title here</title>
<style>
#container {
	width: fit-content;
	padding: 10px;
	margin: 0px auto;
	margin-top: 50px;
	border: 1px solid black;
	border-radius: 8px;
	border: 1px solid black;
	position: relative;
}

#container>h3 {
	text-align: center;
	border-bottom: 3px double black;
}

#colums {
	background: #ebf9ff;
	border-top: none;
}

div.row {
	border-top: 1px solid black;
	border-bottom: none;
}

#pagination {
	width: fit-content;
	padding: 10px;
	margin: 10px auto;
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

span.writer {
	width: 80px;
}

span.date {
	width: 180px;
}

.but {
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
#creatG {
	position: absolute;
	right : 10px;
	bottom: 10px;
}
</style>
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
	
	<div id='container'>
		<h3>
			게시판
		</h3>
		<div class="row" id='colums'>
			<span class="num">번호</span> <span class="title">제목</span> <span
				class="writer">작성자</span> <span class="date">날짜</span>
		</div>

		<c:forEach var="u" items="${pageInfo.getList()}" varStatus="statu">
			<div class="row" id='contents'>
				<a href="/bbs/num/${u.num}"> <span class="num">${u.num}</span> <span
					class="title">${u.title}</span> <span class="writer">${u.writer}</span>
					<span class="date">${u.wdate}</span>
				</a>
			</div>
		</c:forEach>


		<div id="pagination">
			<c:forEach var="i" items="${pageInfo.navigatepageNums}">
				<c:choose>
					<c:when test="${i==pageInfo.pageNum}">
               			[${i}]
            </c:when>
					<c:otherwise>
               			[<a href="/bbs/page/${i}">${i}</a>]
            </c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		<br>
		
		<c:if test="${login == true}">
				<button type="button" class="but" id='creatG'
					onclick='location.href = "/bbs/creatG"'>게시물 작성</button>
			</c:if>
	</div>
</body>
</html>
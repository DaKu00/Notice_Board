<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String uid = (String) session.getAttribute("userid");
System.out.println(uid);
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
	border: 1px solid;
	border-radius: 7px;
	padding: 10px;
	margin: 0px auto;
	margin-top: 50px;
	position: relative;
}

span {
	display: inline-block;
	border: 1px solid black;
	text-align: center;
	padding: 5px;
}

span.title {
	width: 50px;
	height: 20px;
	border-right: none;
	
	border-radius: 4px;
}
span.title1 {
	height: 20px;
	width: 433px;
	border-radius: 4px;
}
#contents {
resize: none; overflow: auto; width: 500px; height: 180px; border-radius: 4px;
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
				<a href=''><span class="login" style='float: right;' id='test'><%=check%></span></a>
			</c:otherwise>
		</c:choose>
	</div>

	<div id='container'>
		<form action="/bbs/upload" method="post" id="bbs" enctype="multipart/form-data" >
			<input type='hidden' id='userid' name = 'writer' value='${userid}'>
			<span class='title'>title</span><span class='title1' >
				<input type='text' name = 'title' id='title' value='제목' style='font-size : 15px; border: none; width: 400px;' >
			</span>
			<br>
			<textarea id='contents' name = 'contents'  placeholder="글 입력" class="text_in" ></textarea>
			<div id='file' >
				<input id = 'file' style='margin-right: 0px; ' type="file" name="files" multiple="multiple"><br>
				<br>
				<br>
			<button style='float:right;' id='fin'>완료</button>
			<br>
			</div>
		</form>
	</div>
</body>
</html>
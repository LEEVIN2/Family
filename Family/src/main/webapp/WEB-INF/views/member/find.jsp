<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- head -->
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- style -->
<style>
.image-container {
    text-align: center; /* 이미지 가운데 정렬 */
    padding-top: 3.5em; /* 안에서 위 여백 */
}
.image-container img {
    width: 522px; /* 너비 */
    height: 179px; /* 높이 */
}
.find {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        padding-top: 9%; /* 위쪽 여백 */
    	padding-bottom: 13%; /* 아래쪽 여백 */
}
.button-find {
	display: flex; /* 플렉스박스로 설정 */
    justify-content: center; /* 가로축 가운데 정렬 */
    align-items: center; /* 세로축 가운데 정렬 */
    width: 360px; /* 너비 */
    height: 70px; /* 높이 */
    background-color: black;
    color: white;
    font-size: 20px;
    border-radius: 20px; /* 모서리 */
    text-decoration: none;
}
.login-link {
	display: flex; /* 플렉스박스로 설정 */
    justify-content: center; /* 가로축 가운데 정렬 */
    align-items: center; /* 세로축 가운데 정렬 */
	color: gray;
    font-size: 20px;
    text-decoration: none;
}
</style>
</head>

<!-- body -->
<body>
<div class="image-container">
	<img src="${pageContext.request.contextPath}/resources/img/member/logo.png" alt="logo">
</div>

<div class="find">
<a class="button-find" href="${pageContext.request.contextPath}/member/findid">아이디 찾기</a><br>
<a class="button-find" href="${pageContext.request.contextPath}/member/findpass">비밀번호 찾기</a><br>
</div>

<a class="login-link" href="${pageContext.request.contextPath}/member/login">로그인하기</a>
</body>
</html>
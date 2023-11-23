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
body {
    display: flex; /*페이지의 내용을 세로 방향으로 배열*/
    flex-direction: column; /*페이지의 내용을 세로 방향으로 배열*/
    height: 100vh; /*body의 높이를 뷰포트의 높이로 설정*/
    margin: 0;
    align-items: center; /*내용을 가운데 정렬*/
    justify-content: flex-end; /*하단에 위치*/
}
.image-container {
    text-align: center; /* 이미지를 가운데 정렬 */
    padding-bottom: 11em; /* 이미지와 버튼 사이에 여백을 추가 */
}

.image-container img {
    width: 522px; /* 이미지의 너비를 설정하세요 */
    height: 179px; /* 이미지의 높이를 설정하세요 */
}
.container {
    text-align: center; /*링크를 가운데 정렬*/
    padding: 3em; /*하단에 여백을 추가*/
}
a {
/*     display: inline-block; */
    display: flex;
    justify-content: center;
    align-items: center;
    text-decoration: none; /*링크 밑줄 제거*/
    background-color: black;
    color: white;
    padding: 30px 40px;
    border-radius: 100px;
    margin: 2px;
    font-size: 25px;
    width: 400px; 
    height: 50px;
}
</style>
</head>

<!-- body -->
<body>
<div class="image-container">
	<img src="${pageContext.request.contextPath}/resources/img/member/logo.png" alt="logo">
</div>
<div class="container">
    <a href="${pageContext.request.contextPath}/member/join">회원가입</a><br>
    <a href="${pageContext.request.contextPath}/member/login">로그인</a>
</div>
</body>
</html>
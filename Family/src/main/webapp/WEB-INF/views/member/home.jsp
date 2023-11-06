<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>'${sessionId}' 님 환영합니다! </h3>
<span>${sessionScope.email}님</span>
<span>${sessionScope.nickname}님</span>
<a href="${pageContext.request.contextPath}/member/logout">로그아웃</a><br>

<a href="${pageContext.request.contextPath}/board/board">게시판</a>
<a href="${pageContext.request.contextPath}/mypage/mypage">마이페이지</a>

</body>
</html>
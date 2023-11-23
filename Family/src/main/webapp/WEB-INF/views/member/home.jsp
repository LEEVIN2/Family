<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 마이페이지로 옮기기 -->
<%-- <a href="${pageContext.request.contextPath}/member/logout">로그아웃</a><br> --%>

<a href="${pageContext.request.contextPath}/board/board">게시판</a>
<a href="${pageContext.request.contextPath}/notice/notice">알림</a>
<a href="${pageContext.request.contextPath}/mypage/mypage">마이페이지</a>

</body>
</html>
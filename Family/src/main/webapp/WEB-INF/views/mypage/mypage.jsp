<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- head -->
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<!-- body -->
<body>
<c:choose>
    <c:when test="${empty memberDTO.profile}">
        <img src="${pageContext.request.contextPath}/resources/img/profile/기본프로필.png" alt="기본프로필" width="100" height="100">
    </c:when>
    <c:otherwise>
        <img src="${pageContext.request.contextPath}/resources/img/profile/${memberDTO.profile}" alt="profile" width="100" height="100">
    </c:otherwise>
</c:choose>
<a>${sessionScope.nickname}</a>
<a>${sessionScope.email}</a>
<a href="${pageContext.request.contextPath}/mypage/profile">프로필 변경</a><br>

<br>

다크모드<br>
알림설정<br>
화면잠금<br>

<br>

공지사항<br>
FAQ<br>
문의하기<br>

</body>
</html>
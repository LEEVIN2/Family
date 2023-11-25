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
<img src="${pageContext.request.contextPath}/resources/img/profile/기본프로필.png" alt="기본프로필">
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
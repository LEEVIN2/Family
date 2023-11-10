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
<a>${sessionScope.nickname}</a>
<a>${sessionScope.id}</a>
<a href="${pageContext.request.contextPath}/mypage/profile">프로필 변경</a><br>
닉네임 변경<br>
이메일 변경<br>
비밀번호 변경<br>

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
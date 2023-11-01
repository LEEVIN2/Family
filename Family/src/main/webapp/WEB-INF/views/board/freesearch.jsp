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

뒤로가기

<!-- form(검색) -->
<form action="${pageContext.request.contextPath}/board/freesearch" method="get">
<input type="text" name="search" placeholder="자유게시판 내 검색">
<input type="submit" value="검색">
</form>

</body>
</html>
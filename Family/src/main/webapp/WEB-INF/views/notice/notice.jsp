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

<!-- table -->
<table>
<c:forEach var="boardDTO" items="${noticeList}">
    <tr><td>글번호</td>		<td>${boardDTO.boardNum}</td></tr>
    <tr><td>닉네임</td>		<td>${boardDTO.nickname}</td></tr>
    <tr><td>내용</td>			<td>${boardDTO.content}</td></tr>
    <tr><td>시간</td>			<td>${boardDTO.submitTime}</td></tr>
</c:forEach>
</table>

</body>
</html>
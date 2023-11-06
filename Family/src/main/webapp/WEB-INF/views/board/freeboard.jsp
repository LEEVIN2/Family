<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
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

<a href="${pageContext.request.contextPath}/board/board">뒤로가기</a> 
자유게시판
<a href="${pageContext.request.contextPath}/board/freesearch">검색</a><br>


<!-- table -->
<table>
<c:forEach var="boardDTO" items="${boardList}">
<tr onclick="location.href='${pageContext.request.contextPath}/board/detail?boardNum=${boardDTO.boardNum}'">
<td>${boardDTO.boardNum}</td>
<td>${boardDTO.nickname}</td>
<td>${boardDTO.submitTime}</td>
<td>${boardDTO.title}</td>
<td>${boardDTO.content}</td>
<td><img src="${pageContext.request.contextPath}/resources/img/${boardDTO.filePath}" alt="Image" width="100" height="100"></td>
<td>${boardDTO.viewCnt}</td>
<td>${boardDTO.commentCnt}</td>
<td>${boardDTO.board_likeCnt}</td>
</tr>
</c:forEach>
</table>

<input type="button" value="글쓰기" onclick="location.href='${pageContext.request.contextPath}/board/write'">

</body>
</html>
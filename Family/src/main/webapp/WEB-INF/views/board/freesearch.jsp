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

<a href="${pageContext.request.contextPath}/board/freeboard">뒤로가기</a> 

<!-- form(검색) -->
<form action="${pageContext.request.contextPath}/board/freesearch" method="get">
<input type="text" name="search" placeholder="자유게시판 내 검색">
<input type="submit" value="검색">
</form>

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

</body>
</html>
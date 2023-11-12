<!-- jstl 제목이랑 컨텐츠 내용 자르는데 사용 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<%-- <td>${boardDTO.id}</td> --%>
<td>${boardDTO.nickname}</td>
<td>${boardDTO.submitTime}</td>
<%-- <td>${boardDTO.title}</td> --%>
<td><c:choose>
    <c:when test="${fn:length(boardDTO.title) > 10}">
        ${fn:substring(boardDTO.title, 0, 10)}...
    </c:when>
    <c:otherwise>
        ${boardDTO.title}
    </c:otherwise>
</c:choose></td>
<%-- <td>${boardDTO.content}</td> --%>
<td><c:choose>
    <c:when test="${fn:length(boardDTO.content) > 20}">
        ${fn:substring(boardDTO.content, 0, 20)}...
    </c:when>
    <c:otherwise>
        ${boardDTO.content}
    </c:otherwise>
</c:choose></td>
<%-- <td><img src="${pageContext.request.contextPath}/resources/img/${boardDTO.filePath}" alt="Image" width="100" height="100"></td> --%>
<td><c:choose>
    <c:when test="${not empty boardDTO.filePath}">
        <img src="${pageContext.request.contextPath}/resources/img/${boardDTO.filePath}" alt="Image" width="100" height="100">
    </c:when>
    <c:otherwise>
        <!-- 빈칸 -->
    </c:otherwise>
</c:choose></td>
<td>${boardDTO.viewCnt}</td>
<td>${boardDTO.commentCnt}</td>
<td>${boardDTO.board_likeCnt}</td>
</tr>
</c:forEach>
</table>

</body>
</html>
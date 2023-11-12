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
<tr onclick="location.href='${pageContext.request.contextPath}/board/detail?boardNum=${boardDTO.boardNum}'">
<%--     <td>${boardDTO.boardNum}</td> --%>
    <td>
        <c:choose>
            <c:when test="${empty boardDTO.content}">
                1개의 좋아요를 받았어요
            </c:when>
            <c:otherwise>
                새로운 댓글이 달렸어요
            </c:otherwise>
        </c:choose>
    </td>
    <td>${boardDTO.id}</td>
    <td>${boardDTO.content}</td>
    <td>${boardDTO.submitTime}</td>
    </tr>
</c:forEach>
</table>

</body>
</html>
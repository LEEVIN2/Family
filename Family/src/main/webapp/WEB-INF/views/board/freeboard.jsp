<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
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
<!-- 페이지를 처음 방문하거나 다른 페이지에서 돌아올 때마다 페이지가 새로 고침 -->
<!-- 조회수가 바로 적용이 안돼서 추가한거임 -->
<script type="text/javascript">
    window.onload = function() {
        if(!sessionStorage.getItem('reloaded')) {
            sessionStorage.setItem('reloaded', true);
            location.reload();
        } else {
            sessionStorage.removeItem('reloaded');
        }
    }
</script>

</head>

<!-- body -->
<body>

<a href="${pageContext.request.contextPath}/board/board">뒤로가기</a> 
자유게시판
<a href="${pageContext.request.contextPath}/board/freesearch">검색</a><br>

<!-- table -->
<table>
<c:if test="${sessionScope.currentPage == 1}">
 <tbody>
 <c:forEach var="boardDTO" items="${boardHotList}">
<tr onclick="location.href='${pageContext.request.contextPath}/board/detail?boardNum=${boardDTO.boardNum}&pageNum=${sessionScope.currentPage}'">
<td><span style="color:red;">HOT</span></td>
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
 </tbody>
 </c:if>


 <tbody>
<c:forEach var="boardDTO" items="${boardList}">
<tr onclick="location.href='${pageContext.request.contextPath}/board/detail?boardNum=${boardDTO.boardNum}&pageNum=${sessionScope.currentPage}'">
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
 </tbody>
</table>

<input type="button" value="글쓰기" onclick="location.href='${pageContext.request.contextPath}/board/write'"><br>

<!-- 페이징처리 -->
<c:forEach var="i" begin="${boardDTO.startPage}" end="${boardDTO.endPage}" step="1">
<a href="${pageContext.request.contextPath}/board/freeboard?pageNum=${i}">${i}</a> 
</c:forEach>


</body>
</html>
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
<tr><td>글번호</td>		<td>${boardDTO.boardNum}</td></tr>
<tr><td>닉네임</td>		<td>${boardDTO.nickname}</td></tr>
<tr><td>시간</td>			<td>${boardDTO.submitTime}</td></tr>
<tr><td>제목</td>			<td>${boardDTO.title}</td></tr>
<tr><td>내용</td>			<td>${boardDTO.content}</td></tr>
<%-- <tr><td>사진</td>			<td><img src="${pageContext.request.contextPath}/resources/img/${boardDTO.filePath}" alt="Image" width="100" height="100"></td></tr> --%>

<c:forEach var="filePath" items="${filePaths}">
<tr><td>사진</td>			<td><img src="${pageContext.request.contextPath}/resources/img/${filePath}" alt="Image" width="100" height="100"></td></tr>
</c:forEach>

</table>




</body>
</html>
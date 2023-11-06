<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- head -->
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
    $("button").click(function() {
        var board_like = ${board_like}; // 여기에 실제 값을 할당해야 합니다.
        var boardNum = '${boardDTO.boardNum}';
        var nickname = "${sessionScope.nickname}";

        var boardDTO = {
            boardNum: boardNum,
            nickname: nickname
        };

        if(board_like == 0) {
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/board/likeUp",
                data: boardDTO,
                success: function() {
                    console.log("컨트롤러 연결 성공");
                    console.log(boardDTO.boardNum);
                    console.log(boardDTO.nickname);
                    location.reload();  // 페이지 새로 고침
                },
                error: function() {
                	console.log(board_like);
                	console.log(boardDTO.boardNum);
                    console.log(boardDTO.nickname);
                    console.log("컨트롤러 연결 실패");
                }
            });
        } else {
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/board/likeDown",
                data: boardDTO,
                success: function() {
                    console.log("컨트롤러 연결 성공");
                    console.log(boardDTO.boardNum);
                    console.log(boardDTO.nickname);
                    location.reload();  // 페이지 새로 고침
                },
                error: function() {
                	console.log(board_like);
                	console.log(boardDTO.boardNum);
                    console.log(boardDTO.nickname);
                    console.log("컨트롤러 연결 실패");
                }
            });
        }
    });
});


</script>
</head>


<!-- body -->
<body>

<a href="${pageContext.request.contextPath}/board/freeboard">뒤로가기</a><br>

<!-- 조회수 -->
<c:set var="count" value="0" scope="page" />
<c:forEach var="boardDTO2" items="${commentList}">
  <c:if test="${boardDTO2.boardNum eq boardDTO.boardNum}">
    <c:set var="count" value="${count + 1}" scope="page" />
  </c:if>
</c:forEach>

${sessionScope.nickname}

<!-- table -->

<button type="button"  style="width: 100px; height: 50px; text-align: center;">
    <c:choose>
        <c:when test='${board_like == 0}'>좋아요</c:when>
        <c:otherwise>좋아요취소</c:otherwise>
    </c:choose>
</button>

<table>
<tr><td>나의 좋아요</td>		<td>${board_like}</td></tr>
<tr><td>전체 좋아요</td>		<td>${board_likeCnt}</td></tr>
<tr><td>글번호</td>		<td>${boardDTO.boardNum}</td></tr>
<tr><td>닉네임</td>		<td>${boardDTO.nickname}</td></tr>
<tr><td>시간</td>			<td>${boardDTO.submitTime}</td></tr>
<tr><td>제목</td>			<td>${boardDTO.title}</td></tr>
<tr><td>내용</td>			<td>${boardDTO.content}</td></tr>
<tr><td>조회수</td>			<td>${boardDTO.viewCnt}</td></tr>
<tr><td>댓글수</td>			<td>${count}</td></tr>
<c:forEach var="filePath" items="${filePaths}">
<tr><td>사진</td>			<td><img src="${pageContext.request.contextPath}/resources/img/${filePath}" alt="Image" width="100" height="100"></td></tr>
</c:forEach>
</table>

<!-- table -->
<table border="1">
<c:forEach var="boardDTO2" items="${commentList}">
  <c:if test="${boardDTO2.boardNum eq boardDTO.boardNum}">
    <tr><td>글번호</td>		<td>${boardDTO2.boardNum}</td></tr>
    <tr><td>닉네임</td>		<td>${boardDTO2.nickname}</td></tr>
    <tr><td>내용</td>			<td>${boardDTO2.content}</td></tr>
    <tr><td>시간</td>			<td>${boardDTO2.submitTime}</td></tr>
  </c:if>
</c:forEach>
</table>


<!-- form (댓글)-->
<form action="${pageContext.request.contextPath}/board/writePro2" method="post" >
댓글		<input type="text" name="content" required> 
<input type="hidden" name="nickname" value="${sessionScope.nickname}">
<input type="hidden" name="boardNum" value="${boardDTO.boardNum}">
<input type="submit" value="작성">
</form>

</body>
</html>
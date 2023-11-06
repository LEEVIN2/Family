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
<script type="text/javascript">
$(document).ready(function() {
	var board_like = $('.LikeBtn').data('like'); // HTML 태그에서 '좋아요' 상태 읽기
    var boardNum = '${boardDTO.boardNum}';
    var nickname = "${sessionScope.nickname}";
    
    if(board_like == 1) {
        $('.LikeBtn').text('좋아요 취소');
    } else {
        $('.LikeBtn').text('좋아요');
    }

    $('.LikeBtn').click(function() {
    	console.log(nickname);
        console.log(boardNum);
        $.ajax({
            url: "/board/likeDown",
            type: "POST",
            data: { boardNum: boardNum, nickname: nickname },
            success: function() {
                console.log("좋아요 취소");
            }
        });
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
<table>
<tr><td>글번호</td>		<td>${boardDTO.boardNum}</td></tr>
<tr><td>닉네임</td>		<td>${boardDTO.nickname}</td></tr>
<tr><td>시간</td>			<td>${boardDTO.submitTime}</td></tr>
<tr><td>제목</td>			<td>${boardDTO.title}</td></tr>
<tr><td>내용</td>			<td>${boardDTO.content}</td></tr>
<tr><td>조회수</td>			<td>${boardDTO.viewCnt}</td></tr>
<tr><td>댓글수</td>			<td>${count}</td></tr>
<tr><td><button class="LikeBtn" data-like="${board_like}">좋아요</button></td> <td>${board_like}</td>
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
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
        var id = "${sessionScope.id}";

        var boardDTO = {
            boardNum: boardNum,
            id: id
        };

        if(board_like == 0) {
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/board/likeUp",
                data: boardDTO,
                success: function() {
                    console.log("컨트롤러 연결 성공");
                    console.log(boardDTO.boardNum);
                    console.log(boardDTO.id);
                    // 좋아요 수를 증가시키고 버튼 텍스트를 업데이트
                    var likeCount = parseInt($("td:contains('전체 좋아요')").next().text()) + 1;
                    $("td:contains('전체 좋아요')").next().text(likeCount);
                    // 나의 좋아요 값을 증가시키기
                    var myLike = parseInt($("td:contains('나의 좋아요')").next().text()) + 1;
                    $("td:contains('나의 좋아요')").next().text(myLike);
                    $("button").text('좋아요취소');
                },
                error: function() {
                    console.log(board_like);
                    console.log(boardDTO.boardNum);
                    console.log(boardDTO.id);
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
                    console.log(boardDTO.id);
                    // 좋아요 수를 감소시키고 버튼 텍스트를 업데이트
                    var likeCount = parseInt($("td:contains('전체 좋아요')").next().text()) - 1;
                    $("td:contains('전체 좋아요')").next().text(likeCount);
                    $("button").text('좋아요');
                },
                error: function() {
                    console.log(board_like);
                    console.log(boardDTO.boardNum);
                    console.log(boardDTO.id);
                    console.log("컨트롤러 연결 실패");
                }
            });
        }
    });
});

// 댓글쓸때 닉네임값 있는지 확인
function checkLogin() {
    var id = document.getElementsByName('id')[0].value;
    if (!id) {
        alert('로그인이 필요합니다!');
        return false;
    }
    return true;
}


//페이지 로드 시 댓글을 가져오는 함수
function loadComments() {
  var xhr = new XMLHttpRequest();
  xhr.open('GET', '${pageContext.request.contextPath}/board/comments?boardNum=${boardDTO.boardNum}');
  xhr.onreadystatechange = function() {
    if (xhr.readyState === 4 && xhr.status === 200) {
      // 서버의 응답을 받아서 댓글을 페이지에 추가
      var commentList = JSON.parse(xhr.responseText);
      commentList.forEach(function(comment) {
        var newComment = document.createElement('p');
        newComment.textContent = comment.content;
        document.getElementById('commentArea').appendChild(newComment);
      });
    }
  };
  xhr.send();
}

// 페이지 로드 시 댓글을 가져옴
window.onload = loadComments;


</script>
</head>


<!-- body -->
<body>

<!-- 뒤로가기 로직 -->
<c:set var="prevPage" value="${header['referer']}" scope="session"/>
<a href="${sessionScope.prevPage}">뒤로가기</a><br>

<!-- 조회수 -->
<c:set var="count" value="0" scope="page" />
<c:forEach var="boardDTO2" items="${commentList}">
  <c:if test="${boardDTO2.boardNum eq boardDTO.boardNum}">
    <c:set var="count" value="${count + 1}" scope="page" />
  </c:if>
</c:forEach>

${sessionScope.id}

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
<tr><td></td>			<td><img src="${pageContext.request.contextPath}/resources/img/${filePath}" alt="Image" width="100" height="100"></td></tr>
</c:forEach>
</table>

<hr>

<!-- table -->
<!-- <table> -->
<%-- <c:forEach var="boardDTO2" items="${commentList}"> --%>
<%--   <c:if test="${boardDTO2.boardNum eq boardDTO.boardNum}"> --%>
<%--     <tr><td>글번호</td>		<td>${boardDTO2.boardNum}</td></tr> --%>
<%--     <tr><td>닉네임</td>		<td>${boardDTO2.nickname}</td></tr> --%>
<%--     <tr><td>내용</td>			<td>${boardDTO2.content}</td></tr> --%>
<%--     <tr><td>시간</td>			<td>${boardDTO2.submitTime}</td></tr> --%>
<%--   </c:if> --%>
<%-- </c:forEach> --%>
<!-- </table> -->

<!-- form (댓글)-->
<%-- <form action="${pageContext.request.contextPath}/board/writePro2" method="post" onsubmit="return checkLogin();"> --%>
<!-- 댓글		<input type="text" name="content" required>  -->
<%-- <input type="hidden" name="id" value="${sessionScope.id}"> --%>
<%-- <input type="hidden" name="boardNum" value="${boardDTO.boardNum}"> --%>
<!-- <input type="submit" value="작성"> -->
<!-- </form> -->

<!-- 댓글을 표시할 영역 -->
<table id="commentArea"></table>

<form id="commentForm" action="${pageContext.request.contextPath}/board/writePro2" method="post">
댓글		<input type="text" name="content" required> 
<input type="hidden" name="id" value="${sessionScope.id}">
<input type="hidden" name="boardNum" value="${boardDTO.boardNum}">
<input type="submit" value="작성">
</form>

<script>
document.getElementById('commentForm').addEventListener('submit', function(event) {
	  event.preventDefault();

	  var formData = new FormData(this);

	  var xhr = new XMLHttpRequest();
	  xhr.open(this.method, this.action);
	  xhr.onreadystatechange = function() {
	    if (xhr.readyState === 4 && xhr.status === 200) {
	      // 서버의 응답을 받아서 댓글을 페이지에 추가
	      var newComment = document.createElement('p');
	      newComment.textContent = formData.get('content');
	      document.getElementById('commentArea').appendChild(newComment);

	      // 댓글 작성 후 입력 필드를 비움
	      document.getElementById('commentForm').reset();
	    }
	  };
	  xhr.send(formData);
	});

</script>


</body>
</html>
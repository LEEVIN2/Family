<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- head -->
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- css -->
<link href="${pageContext.request.contextPath}/resources/css/detail.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>

var board_like = ${board_like}; // 전역 변수로 선언

$(document).ready(function() {
	$("#like_image").click(function() {
//     $("button").click(function() {
        
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
                    board_like = 1; // 좋아요를 눌렀으므로 board_like 값을 1로 설정
                    $("#like_image img").attr("src", "${pageContext.request.contextPath}/resources/img/board/좋아요(누름).png");
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
                    // 나의 좋아요 값을 증가시키기
                    var myLike = parseInt($("td:contains('나의 좋아요')").next().text()) - 1;
                    $("td:contains('나의 좋아요')").next().text(myLike);
                    $("button").text('좋아요');
                    board_like = 0; // 좋아요를 취소했으므로 board_like 값을 0으로 설정
                    $("#like_image img").attr("src", "${pageContext.request.contextPath}/resources/img/board/좋아요.png");
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

// 클릭한 요소를 저장할 전역 변수
var clickedElement;

//페이지 로드 시 댓글을 가져오는 함수
function loadComments() {
  var xhr = new XMLHttpRequest();
  xhr.open('GET', '${pageContext.request.contextPath}/board/comments?boardNum=${boardDTO.boardNum}');
  console.log('Request URL: ' + xhr.responseURL);
  xhr.onreadystatechange = function() {
	  console.log('readyState: ' + xhr.readyState);
	  console.log('status: ' + xhr.status);
    if (xhr.readyState === 4 && xhr.status === 200) {
      // 서버의 응답을 받아서 댓글을 페이지에 추가
      var commentList = JSON.parse(xhr.responseText);
      console.log('Response text: ' + xhr.responseText);

commentList.forEach(function(comment) {
    var newComment = document.createElement('tr');
    var profileImage = comment.profile ? '${pageContext.request.contextPath}/resources/img/profile/' + comment.profile : '${pageContext.request.contextPath}/resources/img/profile/기본프로필.png';
    
    newComment.innerHTML = '<td><div class="row1"><img src="' + profileImage + '" alt="profile"><span class="nickname">' + comment.nickname + '</span>  <span class="submitTime">' + comment.submitTime + '</span></div>' +
                          						    '<div class="row2" data-reply-num="' + comment.replyNum + '">' + comment.content + '</div>' +
                          						 	'<div class="row3" onclick="focusCommentInput(this, \'' + comment.nickname + '\', \'' + comment.commentNum + '\', \'' + comment.replyNum + '\')">답글달기</div></td>';
													
                          						 	// 나중에 살릴 기능
                          						 	// newComment.innerHTML += '<td><button class="more-button" onclick="event.stopPropagation();">삭제</button></td>';

    	    document.getElementById('commentArea').appendChild(newComment);
    	    
//     	    댓글 목록을 순회하면서 각 댓글의 commentNum이 다른 댓글의 replyNum과 일치하는 경우가 있는지 확인하고, 일치하는 경우가 있으면 해당 댓글의 “답글달기” 텍스트를 "답글보기"로 변경하는 코드
    	    var hasReplies = commentList.some(function(otherComment) {
    	        return otherComment.replyNum === comment.commentNum;
    	      });

    	      // If this comment has replies, change the text to "답글보기"
    	      if (hasReplies) {
    	        newComment.querySelector('.row3').textContent = '답글보기';
    	      }
    	      
    	   // Initially hide all comments
    	        newComment.style.display = 'none';
    	   
    	     // Show comments with no replies
    	        if (comment.replyNum === '') {
    	          newComment.style.display = '';
    	        }
    	      });
    	    }
    	  }
    	  xhr.send();
    	}

//페이지 로드 시 댓글을 가져옴
window.onload = loadComments;

//답글달기 클릭 시 댓글 입력창으로 포커스 이동 및 placeholder 설정
function focusCommentInput(element, nickname, commentNum, replyNum) {
	// //클릭한 요소를 전역 변수에 저장
	clickedElement = element;
  var commentInput = document.querySelector('input[name="content"]');
  commentInput.focus();
  commentInput.placeholder = nickname + "에게 답글달기";
  
  // 클릭한 tr의 배경색을 회색으로 변경
//   element.parentElement.style.backgroundColor = 'gray';
// element.parentElement.parentElement.style.backgroundColor = '#c7c7c7';
element.parentElement.parentElement.style.backgroundColor = '#2196f317';
  
  // 댓글을 전송하면 원래의 배경색으로 복원
  commentInput.onblur = function() {
    element.parentElement.style.backgroundColor = '';
  };
  
//replyNum 입력 필드에 comment.commentNum 설정
  document.querySelector('input[name="replyNum"]').value = commentNum;
  
  
//답글보기를 클릭했을 때 해당 댓글에 대한 모든 답글을 보여주는 코드
	if (element.textContent === '답글보기') {
		var allComments = document.querySelectorAll('#commentArea > tr');
		allComments.forEach(function(comment) {
			
			var parentCommentNum = commentNum;
			var childReplyNum = comment.querySelector('.row2').dataset.replyNum;
			
			if (parentCommentNum === childReplyNum || childReplyNum === '') {
				comment.style.display = '';
			} else {
				comment.style.display = 'none';
			}
		});
		// 답글보기를 답글닫기로 변경
		element.textContent = '답글닫기';
	} else if (element.textContent === '답글닫기') {
		// 답글닫기를 클릭하면 모든 댓글을 다시 표시
		var allComments = document.querySelectorAll('#commentArea > tr');
		allComments.forEach(function(comment) {
			var childReplyNum = comment.querySelector('.row2').dataset.replyNum;
			
			if (childReplyNum === '') {
				comment.style.display = '';
			} else {
				comment.style.display = 'none';
			}
		});
		// 답글닫기를 답글보기로 변경
		element.textContent = '답글보기';
		// 포커스 해제, placeholder 초기화, 입력 필드 초기화
		commentInput.blur();
		commentInput.placeholder = "댓글을 입력해주세요";
		document.querySelector('input[name="replyNum"]').value = "";
	}
}

</script>
</head>


<!-- body -->
<body>

<!-- top -->
<div class="top-container">
	<!-- 뒤로가기 -->
	<c:set var="prevPage" value="${header['referer']}" scope="session"/>
	<a href="${sessionScope.prevPage}"><img src="${pageContext.request.contextPath}/resources/img/board/뒤로가기.png" alt="뒤로가기"></a>
	<!-- 자유게시판 -->
	<c:choose>
		<c:when test="${boardDTO.boardNum.startsWith('FR')}">
        	<span>자유게시판</span>
    	</c:when>
    	<c:otherwise>
       		<span>모든게시판</span>
    	</c:otherwise>
	</c:choose>
	<!-- 더보기 -->
	<a id="seeMore"><img src="${pageContext.request.contextPath}/resources/img/board/더보기.png" alt="더보기"></a><br>
</div>


<!-- 조회수 -->
<c:set var="count" value="0" scope="page" />
<c:forEach var="boardDTO2" items="${commentList}">
  <c:if test="${boardDTO2.boardNum eq boardDTO.boardNum}">
    <c:set var="count" value="${count + 1}" scope="page" />
  </c:if>
</c:forEach>


<!-- table -->
<div class="table-container">
<table>
<tr>

<td class="content">
<div class="row1">
<c:choose>
    <c:when test="${empty boardDTO.profile}">
        <img src="${pageContext.request.contextPath}/resources/img/profile/기본프로필.png" alt="기본프로필">
    </c:when>
    <c:otherwise>
        <img src="${pageContext.request.contextPath}/resources/img/profile/${boardDTO.profile}" alt="profile">
    </c:otherwise>
</c:choose>
<%-- <c:choose> --%>
<%--     <c:when test="${boardDTO.boardNum.startsWith('FR')}"> --%>
<!--         자유게시판 -->
<%--     </c:when> --%>
<%--     <c:otherwise> --%>
<!--         모든 게시판 -->
<%--     </c:otherwise> --%>
<%-- </c:choose> --%>
	<span class="nickname">${boardDTO.nickname}</span>
	<span class="submitTime">${boardDTO.submitTime}</span>
</div>

<div class="row2">${boardDTO.title}</div>
<div class="row3" id="tableContent">${boardDTO.content}</div>


<div class="content-img">
<c:forEach var="filePath" items="${filePaths}">
    <c:if test="${not empty filePath}">
        <img src="${pageContext.request.contextPath}/resources/img/upload/${filePath}" alt="Image" width="100" height="100">
    </c:if>
</c:forEach>
</div>

<div class="row4">
		<span id="like_image"><img src="${pageContext.request.contextPath}/resources/img/board/${board_like == 0 ? '좋아요' : '좋아요(누름)'}.png" alt="기본프로필"> ${board_likeCnt}</span>
		<span id="middle"><img src="${pageContext.request.contextPath}/resources/img/board/댓글.png" alt="기본프로필"> ${boardDTO.commentCnt}</span>
        <span><img src="${pageContext.request.contextPath}/resources/img/board/조회.png" alt="기본프로필"> ${boardDTO.viewCnt}</span>
</div>

</td>
</tr>
</table>
</div>


<!-- 좋아요 버튼 -->
<!-- <button type="button" id="like_button"> -->
<%--     <c:choose> --%>
<%--         <c:when test='${board_like == 0}'>좋아요</c:when> --%>
<%--         <c:otherwise>좋아요취소</c:otherwise> --%>
<%--     </c:choose> --%>
<!-- </button> -->


<!-- 댓글을 표시할 영역 -->
<table id="commentArea"></table>

<form id="commentForm" action="${pageContext.request.contextPath}/board/writePro2" method="post">
<input type="text" name="content" id="comment-box" placeholder="댓글을 입력하세요" required> 
<input type="hidden" name="id" value="${sessionScope.id}">
<input type="hidden" name="nickname" value="${sessionScope.nickname}">
<input type="hidden" name="boardNum" value="${boardDTO.boardNum}">
<input type="hidden" name="replyNum" value="">
<input type="submit" value="작성">
</form>

<!-- 더보기 모달창 -->
<div id="seeMoreModal" style="display: none;">
<c:if test="${sessionScope.id != null && sessionScope.id == boardDTO.id}">
<form id="writeForm" action="${pageContext.request.contextPath}/board/deleteBoard" method="get" >
<a id="deletePost">게시글 삭제</a>
<input type="hidden" name="boardNum" value="${boardDTO.boardNum}">
<input type="hidden" name="id" value="${sessionScope.id}">
</form>
</c:if>

<c:if test="${sessionScope.id != boardDTO.id}">
<!-- sessionScope.id != null인 경우 선택시 로그인이 필요한 기능이라고 띄우기 -->
<a>신고하기</a><br>
<a>채팅하기</a><br>
</c:if>
<a id="modalClose">닫기</a>
</div>

<!-- bottom -->
<div class="bottom-container">
<a href="${pageContext.request.contextPath}/board/home"><img src="${pageContext.request.contextPath}/resources/img/board/home.png" alt="home"></a>
<a href="${pageContext.request.contextPath}/member/home"><img src="${pageContext.request.contextPath}/resources/img/board/chat.png" alt="chat"></a>
<a href="${pageContext.request.contextPath}/board/board"><img src="${pageContext.request.contextPath}/resources/img/board/board.png" alt="board"></a>
<a href="${pageContext.request.contextPath}/notice/notice"><img src="${pageContext.request.contextPath}/resources/img/board/notice.png" alt="notice"></a>
<a href="${pageContext.request.contextPath}/mypage/mypage"><img src="${pageContext.request.contextPath}/resources/img/board/mypage.png" alt="mypage"></a>
</div>


<!-- script -->
<script>
window.onload = function() {
    var deletePost = document.getElementById('deletePost');
    if(deletePost) {
        deletePost.addEventListener('click', function() {
            document.getElementById('writeForm').submit();
        });
    }

    var seeMore = document.getElementById("seeMore");
    var seeMoreModal = document.getElementById("seeMoreModal");
    var modalClose = document.getElementById("modalClose");

    seeMore.addEventListener("click", function() {
        seeMoreModal.style.display = "block";
    });

    modalClose.addEventListener("click", function() {
        seeMoreModal.style.display = "none";
    });

    // 페이지 로드 시 댓글을 가져오는 함수 호출
    loadComments();
}


document.getElementById('commentForm').addEventListener('submit', function(event) {
	var id = document.getElementsByName('id')[0].value;
    console.log(id === null ? "null" : id === "" ? "빈 문자열" : "undefined");
    if (!id || id === "") {
        alert('로그인이 필요합니다!');
//         자바스크립트에서 이벤트의 기본 동작을 취소하는 데 사용되는 메서드
        event.preventDefault();
        return false;
    }

    event.preventDefault();

	  var formData = new FormData(this);

	  var xhr = new XMLHttpRequest();
	  xhr.open(this.method, this.action);
	  xhr.onreadystatechange = function() {
	    if (xhr.readyState === 4 && xhr.status === 200) {
	     // 서버의 응답을 받아서 댓글을 페이지에 추가
		var newComment = document.createElement('tr');
     	newComment.innerHTML = '<div class="row1">' + formData.get('nickname') + '  방금' + '</div>' +
                            							'<div class="row2">' + formData.get('content') + '</div>' +
                            							'<div class="row3"></div>';
                            							
     // 댓글 작성 후 입력 필드를 비움
        document.getElementById('commentForm').reset();
        commentForm.querySelector('input[name="content"]').placeholder = "댓글을 입력하세요";

        // 답글을 해당 tr의 바로 아래에 추가하거나 페이지의 맨 아래에 추가
        var commentArea = document.getElementById('commentArea');
        if (clickedElement) {
          var nextSibling = clickedElement.parentElement.nextSibling;
          commentArea.insertBefore(newComment, nextSibling);
          clickedElement = null; // Reset clickedElement after use
        } else {
          commentArea.appendChild(newComment);
        }
      }
    };
    xhr.send(formData);
  });
                            							

// textarea에서 줄바꿈을 해서 3줄로 작성하면 아래의 코드에서 내용을 보이게 할때도 3줄로 보이게 할 수 있어?
//사용자가 입력한 내용을 가져옵니다.
// 줄바꿈을 <br> 태그로 변환합니다.
// 변환된 내용을 다시 textarea에 설정합니다.
var content = document.getElementById('tableContent').innerHTML;
content = content.replace(/\n/g, '<br>');
document.getElementById('tableContent').innerHTML = content;


</script>


</body>
</html>
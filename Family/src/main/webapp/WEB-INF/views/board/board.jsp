<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- head -->
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- css -->
<link href="${pageContext.request.contextPath}/resources/css/board.css" rel="stylesheet" type="text/css">
</head>

<!-- body -->
<body>

<!-- top -->
<div class="top-container">
	<a href="${pageContext.request.contextPath}/board/home"><img src="${pageContext.request.contextPath}/resources/img/board/logo-1.png" alt="logo-1"></a>
	<a href="${pageContext.request.contextPath}/board/search"><img src="${pageContext.request.contextPath}/resources/img/board/검색.png" alt="검색"></a><br>
</div>

<!-- mid -->
<div class="mid-container">
<div class="mid1-container">
<a href="${pageContext.request.contextPath}/board/written"><img src="${pageContext.request.contextPath}/resources/img/board/작성한글.png" alt="작성한글">작성한 글</a>
<a href="${pageContext.request.contextPath}/board/written2"><img src="${pageContext.request.contextPath}/resources/img/board/댓글.png" alt="댓글">작성한 댓글</a>
<a><img src="${pageContext.request.contextPath}/resources/img/board/북마크.png" alt="북마크">북마크</a>
</div>

<div class="mid2-container">
<a href="${pageContext.request.contextPath}/board/bestboard"><img src="${pageContext.request.contextPath}/resources/img/board/BEST게시글.png" alt="BEST게시글">BEST게시글</a>
<a href="${pageContext.request.contextPath}/board/popularboard"><img src="${pageContext.request.contextPath}/resources/img/board/인기게시글.png" alt="인기게시글">인기게시글</a>
</div>

<div class="mid3-container">
<a href="${pageContext.request.contextPath}/board/freeboard"><img src="${pageContext.request.contextPath}/resources/img/board/게시판(즐찾).png" alt="게시판(즐찾)">자유게시판</a>
<a><img src="${pageContext.request.contextPath}/resources/img/board/게시판.png" alt="게시판">추억게시판</a>
<a><img src="${pageContext.request.contextPath}/resources/img/board/게시판.png" alt="게시판">질문게시판</a>
<a><img src="${pageContext.request.contextPath}/resources/img/board/게시판.png" alt="게시판">정보게시판</a>
<a><img src="${pageContext.request.contextPath}/resources/img/board/게시판.png" alt="게시판">후기게시판</a>
</div>

<div class="mid4-container">
<a><img src="${pageContext.request.contextPath}/resources/img/board/게시판.png" alt="게시판">외출도장 찍기</a>
<a><img src="${pageContext.request.contextPath}/resources/img/board/게시판.png" alt="게시판">웃긴사진 뽐내기</a>
<a><img src="${pageContext.request.contextPath}/resources/img/board/게시판.png" alt="게시판">반려동물 자랑하기</a>
</div>

<div class="mid5-container">
<a><img src="${pageContext.request.contextPath}/resources/img/board/게시판.png" alt="게시판">실종/목격</a>
<a><img src="${pageContext.request.contextPath}/resources/img/board/게시판.png" alt="게시판">홍보</a>
</div>
</div>

<!-- bottom -->
<div class="bottom-container">
<a href="${pageContext.request.contextPath}/board/home"><img src="${pageContext.request.contextPath}/resources/img/board/home.png" alt="home"></a>
<a href="${pageContext.request.contextPath}/member/home"><img src="${pageContext.request.contextPath}/resources/img/board/chat.png" alt="chat"></a>
<a href="${pageContext.request.contextPath}/board/board"><img src="${pageContext.request.contextPath}/resources/img/board/board_push.png" alt="board_push"></a>
<a href="${pageContext.request.contextPath}/notice/notice"><img src="${pageContext.request.contextPath}/resources/img/board/notice.png" alt="notice"></a>
<a href="${pageContext.request.contextPath}/mypage/mypage"><img src="${pageContext.request.contextPath}/resources/img/board/mypage.png" alt="mypage"></a>
</div>

</body>
</html>
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

<!-- css -->
<link href="${pageContext.request.contextPath}/resources/css/home.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>

<!-- body -->
<body>

<!-- top -->
<div class="top-container">
	<a href="${pageContext.request.contextPath}/board/home"><img src="${pageContext.request.contextPath}/resources/img/board/logo-1.png" alt="logo-1"></a>
	<a href="${pageContext.request.contextPath}/board/search"><img src="${pageContext.request.contextPath}/resources/img/board/검색.png" alt="검색"></a><br>
</div>

<!-- button -->
<div class="button-container">
<a id="new" class="active">최신</a>
<a id="pop" class="inactive">인기</a><br>
</div>

<!-- table -->
<div class="table-container">
<table id="table-new">
<c:forEach var="boardDTO" items="${boardNewList}">
<tr onclick="location.href='${pageContext.request.contextPath}/board/detail?boardNum=${boardDTO.boardNum}'">

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
	<span class="nickname">${boardDTO.nickname}</span>
	<span class="submitTime">${boardDTO.submitTime}</span>
</div>

<div class="row2">
<c:choose>
    <c:when test="${fn:length(boardDTO.title) > 10}">
        ${fn:substring(boardDTO.title, 0, 10)}...
    </c:when>
    <c:otherwise>
        ${boardDTO.title}
    </c:otherwise>
</c:choose>
</div>

<div class="row3">
<c:choose>
    <c:when test="${fn:length(boardDTO.content) > 20}">
        ${fn:substring(boardDTO.content, 0, 20)}...
    </c:when>
    <c:otherwise>
        ${boardDTO.content}
    </c:otherwise>
</c:choose>
</div>

<div class="row4">
		<span><img src="${pageContext.request.contextPath}/resources/img/board/좋아요(누름).png" alt="기본프로필"> ${boardDTO.board_likeCnt}</span>
        <span><img src="${pageContext.request.contextPath}/resources/img/board/댓글.png" alt="기본프로필"> ${boardDTO.commentCnt}</span>
        <span><img src="${pageContext.request.contextPath}/resources/img/board/조회.png" alt="기본프로필"> ${boardDTO.viewCnt}</span>
        </div>
</td>

<td class="content-img">
<c:choose>
    <c:when test="${not empty boardDTO.filePath}">
        <img src="${pageContext.request.contextPath}/resources/img/${boardDTO.filePath}" alt="Image">
    </c:when>
    <c:otherwise>
        <!-- 빈칸 -->
    </c:otherwise>
</c:choose>
</td>

</tr>
</c:forEach>
</table>

<!-- table -->
<table id="table-pop">
<c:forEach var="boardDTO" items="${boardPopList}">
<tr onclick="location.href='${pageContext.request.contextPath}/board/detail?boardNum=${boardDTO.boardNum}'">

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
        <span class="nickname">${boardDTO.nickname}</span>
        <span class="submitTime">${boardDTO.submitTime}</span>
        </div>

        <div class="row2">
        <c:choose>
            <c:when test="${fn:length(boardDTO.title) > 10}">
                ${fn:substring(boardDTO.title, 0, 10)}...
            </c:when>
            <c:otherwise>
                ${boardDTO.title}
            </c:otherwise>
        </c:choose>
        </div>
        
        <div class="row3">
        <c:choose>
            <c:when test="${fn:length(boardDTO.content) > 20}">
                ${fn:substring(boardDTO.content, 0, 20)}...
            </c:when>
            <c:otherwise>
                ${boardDTO.content}
            </c:otherwise>
        </c:choose>
        </div>

        <div class="row4">
        <span><img src="${pageContext.request.contextPath}/resources/img/board/좋아요(누름).png" alt="좋아요(누름)"> ${boardDTO.board_likeCnt}</span>
        <span><img src="${pageContext.request.contextPath}/resources/img/board/댓글.png" alt="댓글"> ${boardDTO.commentCnt}</span>
        <span><img src="${pageContext.request.contextPath}/resources/img/board/조회.png" alt="조회"> ${boardDTO.viewCnt}</span>
        </div>
    </td>
    
    <td class="content-img">
        <c:choose>
            <c:when test="${not empty boardDTO.filePath}">
                <img src="${pageContext.request.contextPath}/resources/img/${boardDTO.filePath}" alt="Image">
            </c:when>
            <c:otherwise>
                <!-- 빈칸 -->
            </c:otherwise>
        </c:choose>
    </td>
    
</tr>
</c:forEach>
</table>
</div>

<!-- bottom -->
<div class="bottom-container">
<a href="${pageContext.request.contextPath}/board/home"><img src="${pageContext.request.contextPath}/resources/img/board/home.png" alt="home"></a>
<a href="${pageContext.request.contextPath}/member/home"><img src="${pageContext.request.contextPath}/resources/img/board/chat.png" alt="chat"></a>
<a href="${pageContext.request.contextPath}/board/board"><img src="${pageContext.request.contextPath}/resources/img/board/board.png" alt="board"></a>
<a href="${pageContext.request.contextPath}/notice/notice"><img src="${pageContext.request.contextPath}/resources/img/board/notice.png" alt="notice"></a>
<a href="${pageContext.request.contextPath}/mypage/mypage"><img src="${pageContext.request.contextPath}/resources/img/board/mypage.png" alt="mypage"></a>
</div>

<!-- 마이페이지로 옮기기 -->
<%-- <a href="${pageContext.request.contextPath}/member/logout">로그아웃</a><br> --%>

<!-- script -->
<script type="text/javascript">

// ${boardDTO.filePath} 값이 있는 경우와 없는 경우에 따라 다른 패딩 값을 적용
var rows = document.querySelectorAll('.table-container tr');
rows.forEach(function(row) {
    var img = row.querySelector('.content-img img');
    if (img) {
        row.classList.add('with-image');
    } else {
        row.classList.add('without-image');
    }
});

window.onload = function() {
    document.getElementById('table-new').style.display = 'block';
    document.getElementById('table-pop').style.display = 'none';
 	// css 때문에 넣은 코드 2개
    document.getElementById('new').classList.add('active');
    document.getElementById('pop').classList.add('inactive');
};

document.getElementById('new').addEventListener('click', function() {
    document.getElementById('table-new').style.display = 'block';
    document.getElementById('table-pop').style.display = 'none';
 	// css 때문에 넣은 코드 4개
    this.classList.add('active');
    this.classList.remove('inactive');
    document.getElementById('pop').classList.remove('active');
    document.getElementById('pop').classList.add('inactive');
});

document.getElementById('pop').addEventListener('click', function() {
    document.getElementById('table-pop').style.display = 'block';
    document.getElementById('table-new').style.display = 'none';
 	// css 때문에 넣은 코드 4개
    this.classList.add('active');
    this.classList.remove('inactive');
    document.getElementById('new').classList.remove('active');
    document.getElementById('new').classList.add('inactive');
});

// 무한스크롤
let start = 0;
const limit = 3;

window.onscroll = function(ev) {
    console.log("스크롤 이벤트 발생!");
    if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
        start += limit;
        loadMoreData(start, limit);
    }
};


function loadMoreData(start, limit) {
    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/board/loadMoreData",
        data: {
            'start': start,
            'limit': limit
        },
        success: function(response) {
            console.log("데이터 요청 성공: ", response);
            response.forEach(function(loadMoreData) {
            	console.log("렌더링 항목: ", loadMoreData);
            	console.log("렌더링 항목의 내용: ", loadMoreData.nickname);
            	console.log("렌더링 항목의 내용: ", loadMoreData.content);
            	
            	var boardNum = loadMoreData.boardNum;
            	var nickname = loadMoreData.nickname;
            	var submitTime = loadMoreData.submitTime;
            	var title = loadMoreData.title;
            	var content = loadMoreData.content;
            	var filePath = loadMoreData.filePath;
            	var viewCnt = loadMoreData.viewCnt;
            	var commentCnt = loadMoreData.commentCnt;
            	var board_likeCnt = loadMoreData.board_likeCnt;
            	
            	var newRow = '<tr onclick="location.href=\'' + "${pageContext.request.contextPath}" + '/board/detail?boardNum=' + boardNum + '\'">' +
'<td class="content">' +
                '<div class="row1">' +
                    (loadMoreData.profile ? '<img src="' + "${pageContext.request.contextPath}" + '/resources/img/profile/' + loadMoreData.profile + '" alt="profile">' : '<img src="' + "${pageContext.request.contextPath}" + '/resources/img/profile/기본프로필.png" alt="기본프로필">') +
                    '<span class="nickname">' + nickname + '</span>' +
                    '<span class="submitTime">' + submitTime + '</span>' +
                '</div>' +
                '<div class="row2">' +
                    (title.length > 10 ? title.substring(0, 10) + '...' : title) +
                '</div>' +
                '<div class="row3">' +
                    (content.length > 20 ? content.substring(0, 20) + '...' : content) +
                '</div>' +
                '<div class="row4">' +
                    '<span><img src="' + "${pageContext.request.contextPath}" + '/resources/img/board/좋아요(누름).png" alt="기본프로필"> ' + board_likeCnt + '</span>' +
                    '<span><img src="' + "${pageContext.request.contextPath}" + '/resources/img/board/댓글.png" alt="기본프로필"> ' + commentCnt + '</span>' +
                    '<span><img src="' + "${pageContext.request.contextPath}" + '/resources/img/board/조회.png" alt="기본프로필"> ' + viewCnt + '</span>' +
                '</div>' +
            '</td>' +
            '<td class="content-img">' +
                (filePath ? '<img src="' + "${pageContext.request.contextPath}" + '/resources/img/' + filePath + '" alt="Image">' : '') +
            '</td>' +
    		    '</tr>';
    		    
                console.log("새로운 행: ", newRow);
                $('#table-new').append(newRow);
                $('#table-pop').append(newRow);

                // 새로 추가된 행에 대해 스타일 적용
                var rows = document.querySelectorAll('.table-container tr');
                rows.forEach(function(row) {
                    var img = row.querySelector('.content-img img');
                    if (img) {
                        row.classList.add('with-image');
                    } else {
                        row.classList.add('without-image');
                    }
                });
            });
        },
        error: function(error) {
            console.log("데이터 요청 실패: ", error);
        }
    });
}

</script>
</body>
</html>
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

<!-- css -->
<link href="${pageContext.request.contextPath}/resources/css/freeboard.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

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

<!-- top -->
<div class="top-container">
	<a href="${pageContext.request.contextPath}/board/board"><img src="${pageContext.request.contextPath}/resources/img/board/뒤로가기.png" alt="뒤로가기"></a>
	<span>자유게시판</span>
	<a href="${pageContext.request.contextPath}/board/freesearch"><img src="${pageContext.request.contextPath}/resources/img/board/검색.png" alt="검색"></a><br>
</div>

<!-- table -->
<div class="table-container">
<table>
<%-- <c:if test="${sessionScope.currentPage == 1}"> --%>
 <tbody>
 <c:forEach var="boardDTO" items="${boardHotList}">
<tr onclick="location.href='${pageContext.request.contextPath}/board/detail?boardNum=${boardDTO.boardNum}&pageNum=${sessionScope.currentPage}'">

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
	<span class="HOT">HOT</span>
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

<!-- <div class="row3"> -->
<%-- <c:choose> --%>
<%--     <c:when test="${fn:length(boardDTO.content) > 20}"> --%>
<%--         ${fn:substring(boardDTO.content, 0, 20)}... --%>
<%--     </c:when> --%>
<%--     <c:otherwise> --%>
<%--         ${boardDTO.content} --%>
<%--     </c:otherwise> --%>
<%-- </c:choose> --%>
<!-- </div> -->

<div class="row3">
<span class="tableContent">${boardDTO.content}</span>
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
        <img src="${pageContext.request.contextPath}/resources/img/upload/${boardDTO.filePath}" alt="Image">
    </c:when>
    <c:otherwise>
        <!-- 빈칸 -->
    </c:otherwise>
</c:choose>
</td>
</tr>
</c:forEach>
 </tbody>
<%--  </c:if> --%>


<tbody id="tbody-new">
<c:forEach var="boardDTO" items="${boardList}">
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
<span class="tableContent">${boardDTO.content}</span>
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
        <img src="${pageContext.request.contextPath}/resources/img/upload/${boardDTO.filePath}" alt="Image">
    </c:when>
    <c:otherwise>
        <!-- 빈칸 -->
    </c:otherwise>
</c:choose>
</td>
</tr>
</c:forEach>
 </tbody>
</table>
</div>

<!-- button -->
<div class="button-container">
<input type="button" value="+ 글쓰기" onclick="writePost()"><br>
</div>

<!-- bottom -->
<div class="bottom-container">
<a href="${pageContext.request.contextPath}/board/home"><img src="${pageContext.request.contextPath}/resources/img/board/home.png" alt="home"></a>
<a href="${pageContext.request.contextPath}/member/home"><img src="${pageContext.request.contextPath}/resources/img/board/chat.png" alt="chat"></a>
<a href="${pageContext.request.contextPath}/board/board"><img src="${pageContext.request.contextPath}/resources/img/board/board.png" alt="board"></a>
<a href="${pageContext.request.contextPath}/notice/notice"><img src="${pageContext.request.contextPath}/resources/img/board/notice.png" alt="notice"></a>
<a href="${pageContext.request.contextPath}/mypage/mypage"><img src="${pageContext.request.contextPath}/resources/img/board/mypage.png" alt="mypage"></a>
</div>

<!-- 페이징처리 -->
<%-- <c:forEach var="i" begin="${boardDTO.startPage}" end="${boardDTO.endPage}" step="1"> --%>
<%-- <a href="${pageContext.request.contextPath}/board/freeboard?pageNum=${i}">${i}</a>  --%>
<%-- </c:forEach> --%>

<!-- script -->
<script type="text/javascript">
function writePost() {
    if("${sessionScope.id}" === "") {
        alert("로그인 후 이용 가능합니다.");
    } else {
        location.href='${pageContext.request.contextPath}/board/write';
    }
}

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

//무한스크롤
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
                	'<span class="tableContent">' + content + '</span>' +
                '</div>' +
                '<div class="row4">' +
                    '<span><img src="' + "${pageContext.request.contextPath}" + '/resources/img/board/좋아요(누름).png" alt="기본프로필"> ' + board_likeCnt + '</span>' +
                    '<span><img src="' + "${pageContext.request.contextPath}" + '/resources/img/board/댓글.png" alt="기본프로필"> ' + commentCnt + '</span>' +
                    '<span><img src="' + "${pageContext.request.contextPath}" + '/resources/img/board/조회.png" alt="기본프로필"> ' + viewCnt + '</span>' +
                '</div>' +
            '</td>' +
            '<td class="content-img">' +
                (filePath ? '<img src="' + "${pageContext.request.contextPath}" + '/resources/img/upload/' + filePath + '" alt="Image">' : '') +
            '</td>' +
    		    '</tr>';
    		    
                console.log("새로운 행: ", newRow);
                $('#tbody-new').append(newRow);

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

// 줄바꿈
window.onload = function() {
    var contents = document.querySelectorAll('.tableContent');
    contents.forEach(function(content) {
        var text = content.innerHTML;
        text = text.replace(/\n/g, '<br>');
        content.innerHTML = text;
        
        var splitContent = content.innerHTML.split('<br>');
        if (splitContent.length > 2) {
            content.innerHTML = splitContent[0] + '<br>' + splitContent[1];
        }
    });
}

</script>
</body>
</html>
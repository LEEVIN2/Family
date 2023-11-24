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
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<!-- style -->
<style>
#table-new{
    height: 1000px;
}
</style>
</head>

<!-- body -->
<body>
<a href="${pageContext.request.contextPath}/board/freesearch">검색</a><br>

<a id="new" class="active"> 최신</a>
<a id="pop" class="inactive"> 인기</a><br>

<!-- table -->
<table id="table-new">
<c:forEach var="boardDTO" items="${boardNewList}">
<tr onclick="location.href='${pageContext.request.contextPath}/board/detail?boardNum=${boardDTO.boardNum}'">
<td>${boardDTO.nickname}</td>
<td>${boardDTO.submitTime}</td>
<td><c:choose>
    <c:when test="${fn:length(boardDTO.title) > 10}">
        ${fn:substring(boardDTO.title, 0, 10)}...
    </c:when>
    <c:otherwise>
        ${boardDTO.title}
    </c:otherwise>
</c:choose></td>
<td><c:choose>
    <c:when test="${fn:length(boardDTO.content) > 20}">
        ${fn:substring(boardDTO.content, 0, 20)}...
    </c:when>
    <c:otherwise>
        ${boardDTO.content}
    </c:otherwise>
</c:choose></td>
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
</table>

<!-- table -->
<table id="table-pop">
<c:forEach var="boardDTO" items="${boardPopList}">
<tr onclick="location.href='${pageContext.request.contextPath}/board/detail?boardNum=${boardDTO.boardNum}'">
<td>${boardDTO.nickname}</td>
<td>${boardDTO.submitTime}</td>
<td><c:choose>
    <c:when test="${fn:length(boardDTO.title) > 10}">
        ${fn:substring(boardDTO.title, 0, 10)}...
    </c:when>
    <c:otherwise>
        ${boardDTO.title}
    </c:otherwise>
</c:choose></td>
<td><c:choose>
    <c:when test="${fn:length(boardDTO.content) > 20}">
        ${fn:substring(boardDTO.content, 0, 20)}...
    </c:when>
    <c:otherwise>
        ${boardDTO.content}
    </c:otherwise>
</c:choose></td>
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
</table>

<!-- bottom -->
<a href="${pageContext.request.contextPath}/member/home">홈</a>
<a href="${pageContext.request.contextPath}/board/home">채팅</a>
<a href="${pageContext.request.contextPath}/board/board">게시판</a>
<a href="${pageContext.request.contextPath}/notice/notice">알림</a>
<a href="${pageContext.request.contextPath}/mypage/mypage">마이페이지</a>

<!-- 마이페이지로 옮기기 -->
<%-- <a href="${pageContext.request.contextPath}/member/logout">로그아웃</a><br> --%>

<!-- script -->
<script type="text/javascript">
window.onload = function() {
    document.getElementById('table-new').style.display = 'block';
    document.getElementById('table-pop').style.display = 'none';
};

document.getElementById('new').addEventListener('click', function() {
    document.getElementById('table-new').style.display = 'block';
    document.getElementById('table-pop').style.display = 'none';
});

document.getElementById('pop').addEventListener('click', function() {
    document.getElementById('table-pop').style.display = 'block';
    document.getElementById('table-new').style.display = 'none';
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
            	
            	var nickname = loadMoreData.nickname;
            	var submitTime = loadMoreData.submitTime;
            	var title = loadMoreData.title;
            	var content = loadMoreData.content;
            	var filePath = loadMoreData.filePath;
            	var viewCnt = loadMoreData.viewCnt;
            	var commentCnt = loadMoreData.commentCnt;
            	var board_likeCnt = loadMoreData.board_likeCnt;
            	
            	var newRow = '<tr>' +
    		        '<td>' + nickname + '</td>' +
    		        '<td>' + submitTime + '</td>' +
    		        '<td>' + (title.length > 10 ? title.substring(0, 10) + '...' : title) + '</td>' +
    		        '<td>' + (content.length > 20 ? content.substring(0, 20) + '...' : content) + '</td>' +
    		        '<td>' + (filePath ? '<img src="' + "file:///C:/Users/sonmi/git/Family/Family/Family/src/main/webapp" + '/resources/img/' + filePath + '" alt="Image" width="100" height="100">' : '') + '</td>' +
    		        '<td>' + viewCnt + '</td>' +
    		        '<td>' + commentCnt + '</td>' +
    		        '<td>' + board_likeCnt + '</td>' +
    		    '</tr>';
                
                console.log("새로운 행: ", newRow);
                $('#table-new').append(newRow);
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
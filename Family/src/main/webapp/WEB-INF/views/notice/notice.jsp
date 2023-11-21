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
<link href="${pageContext.request.contextPath}/resources/css/notice.css" rel="stylesheet" type="text/css">

<!-- script -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script>
// read테이블 y로 업데이트 시키기
function updateRead(boardNum, id, submitTime) {
	
	var sessionid = '${sessionScope.id}'; // 세션 ID 가져오기
	
    var form = document.createElement('form');
    form.setAttribute('method', 'post');
    form.setAttribute('action', '${pageContext.request.contextPath}/notice/updateRead');

    var hiddenField1 = document.createElement('input');
    hiddenField1.setAttribute('type', 'hidden');
    hiddenField1.setAttribute('name', 'boardNum');
    hiddenField1.setAttribute('value', boardNum);
    form.appendChild(hiddenField1);

    var hiddenField2 = document.createElement('input');
    hiddenField2.setAttribute('type', 'hidden');
    hiddenField2.setAttribute('name', 'sessionid');
    hiddenField2.setAttribute('value', sessionid);
    form.appendChild(hiddenField2);
    
    var hiddenField3 = document.createElement('input');
    hiddenField3.setAttribute('type', 'hidden');
    hiddenField3.setAttribute('name', 'id');
    hiddenField3.setAttribute('value', id);
    form.appendChild(hiddenField3);

    var hiddenField4 = document.createElement('input');
    hiddenField4.setAttribute('type', 'hidden');
    hiddenField4.setAttribute('name', 'submitTime');
    hiddenField4.setAttribute('value', submitTime);
    form.appendChild(hiddenField4);

    document.body.appendChild(form);
    form.submit();
}

//전체, 소식, 활동 누르면 각각의 내용 보여지게
//이 함수는 웹 페이지에서 ‘content’ 클래스를 가진 모든 요소를 숨기고, contentId로 전달된 id를 가진 요소만 보여주는 역할
function showContent(contentId) {
var contents = document.getElementsByClassName('content');
for (var i = 0; i < contents.length; i++) {
   contents[i].style.display = 'none';
}
document.getElementById(contentId).style.display = 'block';
}

// 스와이프 기능
$(document).ready(function(){
	var sessionid = '${sessionScope.id}'; // 세션 ID 가져오기

    $("tr").on("swipeleft",function(){
        $(this).find(".delete-button").show();
    });

    $("tr").on("swiperight",function(){
        $(this).find(".delete-button").hide();
    });
    
    $(".delete-button").click(function(event){
        event.stopPropagation();
        event.preventDefault(); // prevent the page from refreshing
        var tr = $(this).closest('tr');
        var boardNum = tr.find('.boardNum').text();
        var id = tr.find('.id').text();
        var submitTime = tr.find('.submitTime').text();
        $.ajax({
            url: '${pageContext.request.contextPath}/notice/delete?boardNum=' + boardNum + '&sessionid=' + sessionid + '&id=' + id + '&submitTime=' + submitTime,
            type: 'POST',
            success: function(result) {
                tr.remove();
            }
        });
    });
});
</script>
</head>

<!-- body -->
<body>

<a href="#" onclick="showContent('total'); return false;">전체</a>
<a href="#" onclick="showContent('news'); return false;">소식</a>
<a href="#" onclick="showContent('active'); return false;">활동</a>

<!-- 전체 -->
<div id="total" class="content" style="display:block;">
<table>
<c:forEach var="boardDTO" items="${noticeList}">
<c:if test="${boardDTO.read != 'D'}">
    <tr onclick="updateRead('${boardDTO.boardNum}', '${boardDTO.id}', '${boardDTO.submitTime}')" class="${boardDTO.read == 'Y' ? 'read' : 'unread'}">
        <td class="boardNum">${boardDTO.boardNum}</td>
        <td class="id">${boardDTO.id}</td>
        <td>${boardDTO.content}</td>
        <td class="submitTime">${boardDTO.submitTime}</td>
<%--         <td>${boardDTO.read}</td> --%>
 <td><button class="delete-button" style="display: none;" onclick="event.stopPropagation();">삭제</button></td>
    </tr>
        </c:if>
</c:forEach>
</table>
</div>

<!-- 소식 -->
<div id="news" class="content" style="display:none;">
<table>
<c:forEach var="boardDTO" items="${noticeNewsList}">
<tr onclick="location.href='${pageContext.request.contextPath}/board/detail?boardNum=${boardDTO.boardNum}'">
        <td class="boardNum">${boardDTO.boardNum}</td>
        <td class="id">${boardDTO.id}</td>
        <td>${boardDTO.content}</td>
        <td class="submitTime">${boardDTO.submitTime}</td>
<%--         <td>${boardDTO.read}</td> --%>
 <td><button class="delete-button" style="display: none;" onclick="event.stopPropagation();">삭제</button></td>
    </tr>
</c:forEach>
</table>
</div>

<!-- 활동 -->
<div id="active" class="content" style="display:none;">
<table>
<c:forEach var="boardDTO" items="${noticeActiveList}">
<c:if test="${boardDTO.read != 'D'}">
    <tr onclick="updateRead('${boardDTO.boardNum}', '${boardDTO.id}', '${boardDTO.submitTime}')" class="${boardDTO.read == 'Y' ? 'read' : 'unread'}">
        <td class="boardNum">${boardDTO.boardNum}</td>
        <td>
            <c:choose>
                <c:when test="${empty boardDTO.content}">
                    1개의 좋아요를 받았어요
                </c:when>
                <c:otherwise>
                    새로운 댓글이 달렸어요
                </c:otherwise>
            </c:choose>
        </td>
       <td class="id">${boardDTO.id}</td>
        <td>${boardDTO.content}</td>
        <td class="submitTime">${boardDTO.submitTime}</td>
<%--         <td>${boardDTO.read}</td> --%>
 <td><button class="delete-button" style="display: none;" onclick="event.stopPropagation();">삭제</button></td>
    </tr>
    </c:if>
</c:forEach>
</table>
</div>

</body>
</html>
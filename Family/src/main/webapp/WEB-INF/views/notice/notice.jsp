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
<script>
// read테이블 y로 업데이트 시키기
function updateRead(boardNum, id, submitTime) {
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
    hiddenField2.setAttribute('name', 'id');
    hiddenField2.setAttribute('value', id);
    form.appendChild(hiddenField2);

    var hiddenField3 = document.createElement('input');
    hiddenField3.setAttribute('type', 'hidden');
    hiddenField3.setAttribute('name', 'submitTime');
    hiddenField3.setAttribute('value', submitTime);
    form.appendChild(hiddenField3);

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

</script>
</head>

<!-- body -->
<body>
<a href="#" onclick="showContent('total'); return false;">전체</a>
<a href="#" onclick="showContent('news'); return false;">소식</a>
<a href="#" onclick="showContent('active'); return false;">활동</a>

<!-- 전체 -->
<div id="total" class="content" style="display:block;">
전체
</div>

<!-- 소식 -->
<div id="news" class="content" style="display:none;">
<table>
<c:forEach var="boardDTO" items="${noticeNewsList}">
    <tr onclick="updateRead('${boardDTO.boardNum}', '${sessionScope.id}', '${boardDTO.submitTime}')" class="${boardDTO.read == 'Y' ? 'read' : 'unread'}">
<%--         <td>${boardDTO.boardNum}</td> --%>
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
        <td>${boardDTO.id}</td>
        <td>${boardDTO.content}</td>
        <td>${boardDTO.submitTime}</td>
<%--         <td>${boardDTO.read}</td> --%>
    </tr>
</c:forEach>
</table>
</div>

<!-- 활동 -->
<div id="active" class="content" style="display:none;">
<table>
<c:forEach var="boardDTO" items="${noticeActiveList}">
    <tr onclick="updateRead('${boardDTO.boardNum}', '${sessionScope.id}', '${boardDTO.submitTime}')" class="${boardDTO.read == 'Y' ? 'read' : 'unread'}">
<%--         <td>${boardDTO.boardNum}</td> --%>
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
        <td>${boardDTO.id}</td>
        <td>${boardDTO.content}</td>
        <td>${boardDTO.submitTime}</td>
<%--         <td>${boardDTO.read}</td> --%>
    </tr>
</c:forEach>
</table>
</div>

</body>
</html>
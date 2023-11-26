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
</head>

<body>
<a href="${pageContext.request.contextPath}/mypage/mypage">닫기</a><br>

<c:choose>
    <c:when test="${empty memberDTO.profile}">
        <img src="${pageContext.request.contextPath}/resources/img/profile/기본프로필.png" alt="기본프로필" width="100" height="100">
    </c:when>
    <c:otherwise>
        <img src="${pageContext.request.contextPath}/resources/img/profile/${memberDTO.profile}" alt="profile" width="100" height="100">
    </c:otherwise>
</c:choose>
<br>

<a id="changePhoto">사진변경</a><br>

${memberDTO.id}<br>
${memberDTO.nickname}<br>
${memberDTO.email}<br>

<!-- 사진변경 클릭시 모달창 -->
<div id="changePhotoModal" style="display: none;">
<form id="writeForm" action="${pageContext.request.contextPath}/mypage/changePhoto" method="post"  enctype="multipart/form-data">
사진변경 <input multiple="multiple" type="file" name="file" id="fileUpload" />
</form>
<a href="${pageContext.request.contextPath}/mypage/deletePhoto">사진삭제</a><br>
<a id="modalClose">닫기</a>
</div>

<!-- script -->
<script>
$(document).ready(function(){
	  $('#fileUpload').change(function(){
	    $('#writeForm').submit();
	  });
	});

// 사진변경, 사진변경 모달창, 모달창 닫기 변수에 저장
var changePhoto = document.getElementById("changePhoto");
var changePhotoModal = document.getElementById("changePhotoModal");
var modalClose = document.getElementById("modalClose");

// 사진변경 버튼을 클릭하면 사진삭제 모달창이 나타나도록 이벤트 리스너를 추가합니다
changePhoto.addEventListener("click", function() {
	changePhotoModal.style.display = "block";
});

//닫기 버튼을 클릭하면 사진변경 모달창이 사라지도록 이벤트 리스너를 추가합니다
modalClose.addEventListener("click", function() {
	changePhotoModal.style.display = "none";
});
</script>

</body>
</html>
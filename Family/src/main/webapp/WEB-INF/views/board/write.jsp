<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<jsp:useBean id="now" class="java.util.Date" scope="page" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- head -->
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- style -->
<style>
/* top */
.top-container {
    display: flex;
    justify-content: center;
    align-items: center;
    padding-top: 1%;
    padding-bottom: 25px;
}

.top-container img {
    max-width: 100%; /* 이미지의 최대 너비를 부모 요소의 너비로 제한합니다. 이를 통해 이미지가 화면을 벗어나지 않도록 할 수 있습니다. */
}

.top-container img[src$="뒤로가기.png"] {
    width: 78px;  
    height: 70px;
    margin-right: 237px;
}

.top-container img[src$="작성.png"] {
    width: 70px;
    height: 70px;
    margin-left: 245px;
}

#write {
	display: flex;
    justify-content: center;
    width: 170px;
    font-size: 30px;
    font-weight: 700;
}

/* form */
#writeForm {
	display: flex;
    flex-direction: column;
    align-items: center;
}

#title {
    width: 800px;
    height: 70px;
    font-size: 17px;
    border-left: none;
    border-right: none;
    border-top: none;
    border-bottom: 3px solid #c7c7c7;
    background: white;
}

#content {
    width: 800px;
    height: 450px;
    padding: 20px;
    font-size: 16.5px;
	border: none; 
	resize: none; /* 크기 조절 기능 */
    overflow: auto; /* 스크롤바 */
}

#title:focus, #content:focus {
    outline: none;
}

#upload {
	position: fixed;
	display: flex;
	align-items: center;
	width: 800px;
    bottom: 180px;
}

#uploadImage {
	width: 50px;
	height: 50px;
	cursor: pointer
}

#uploadText {
	font-size: 17px;
    padding-left: 10px;
}

/* bottom */
body {
    /* bottom-container와 button-container의 높이만큼의 패딩을 추가합니다. */
    padding-bottom: 125px;  /* bottom-container의 높이에 따라 조정하세요 */
    /* 내용이 길어질 경우 스크롤이 가능하도록 합니다. */
    overflow: auto;
}

.bottom-container {
    display: flex; /* 자식 요소들을 가로로 나열합니다. 이를 통해 이미지가 한 줄에 나타나게 됩니다. */
    justify-content: center;
    position: fixed;
    bottom: 0;
    width: 100%;
    transform: translateX(-8px);
}

.bottom-container a {
	display: flex;
    align-items: center;
	height: 130px;
	background-color: white;
	border-top: 5px solid black;
}

.bottom-container img {
    width: 60px;
    height: 60px;
    margin-right: 50px;
    margin-left: 50px;
}
</style>
</head>

<body>
<!-- top -->
<div class="top-container">
	<a href="javascript:history.back()"><img src="${pageContext.request.contextPath}/resources/img/board/뒤로가기.png" alt="뒤로가기"></a>
	<span id="write">게시글 작성</span>
	<span id="submitForm"><img src="${pageContext.request.contextPath}/resources/img/board/작성.png" alt="작성"></span><br>
</div>

<!-- form -->
<form id="writeForm" action="${pageContext.request.contextPath}/board/writePro" method="post"  enctype="multipart/form-data">
<input type="text" id="title" name="title" placeholder="제목을 입력해주세요" required>
<textarea id="content" name="content" rows="4" cols="50"  placeholder="내용을 입력해주세요" required></textarea>

<div id="upload">
    <input style="display: none;" id="file" multiple="multiple" type="file" name="file" />
    <img id="uploadImage" src="${pageContext.request.contextPath}/resources/img/board/앨범.png" alt="앨범">
    <span id="uploadText"></span>
</div>

<input type="hidden" id="id" name="id" value="${sessionScope.id}">
</form>

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
document.getElementById('submitForm').addEventListener('click', function() {
    var id = document.getElementById('id').value;
    var title = document.getElementById('title').value;
    var content = document.getElementById('content').value;
    
    if(id == "") {
        alert("로그인 후 이용 가능합니다.");
    } else if(title == "") {
        alert("제목을 작성해주세요.");
    } else if(content == "") {
        alert("내용을 작성해주세요.");
    } else {
        document.getElementById('writeForm').submit();
    }
});

document.getElementById('uploadImage').addEventListener('click', function() {
    document.getElementById('file').click();
});

document.getElementById('file').addEventListener('change', function() {
    if (this.value) {
        document.getElementById('uploadText').textContent = ' 사진을 첨부했습니다';
    }
});
</script>
</body>
</html>
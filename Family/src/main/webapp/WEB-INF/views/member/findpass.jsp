<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- head -->
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<title>Insert title here</title>

<!-- style -->
<style>
.image-container {
    text-align: center; /* 이미지 가운데 정렬 */
    padding-top: 3.5em; /* 안에서 위 여백 */
}
.image-container img {
    width: 522px; /* 너비 */
    height: 179px; /* 높이 */
}
#find-pass {
	display: flex; /* 플렉스박스로 설정 */
    justify-content: center; /* 가로축 가운데 정렬 */
    align-items: center; /* 세로축 가운데 정렬 */
	color: gray;
    font-size: 20px;
    margin-top: 7%;
}
.form-container {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    	padding-bottom: 5%; /* 아래쪽 여백 */
}
.input-large {
    width: 350px;
    height: 55px;
    font-size: 20px; /* 글자 크기 지정 */
    margin: 7px; /* margin 추가 */
    border-radius: 20px; /* 모서리 둥글게 */
    border: 3px solid black; /* 모서리 색상 검정으로 지정 */
    text-align: center; /* 텍스트를 가로로 중앙 정렬 */
    line-height: 60px; /* 텍스트를 세로로 중앙 정렬 */
}
.button-check {
    width: 360px; /* 버튼의 너비 */
    height: 60px; /* 버튼의 높이 */
    background-color: black;
    color: white;
    font-size: 20px;
    border-radius: 20px; /* 버튼의 모서리를 둥글게 */
    margin: 7px; /* margin 추가 */
}
.find-link {
	display: flex; /* 플렉스박스로 설정 */
    justify-content: center; /* 가로축 가운데 정렬 */
    align-items: center; /* 세로축 가운데 정렬 */
	color: gray;
    font-size: 20px;
    text-decoration: none;
    margin-top: 8%;
}
</style>
</head>

<!-- body -->
<body>
<div class="image-container">
	<img src="${pageContext.request.contextPath}/resources/img/member/logo.png" alt="logo">
</div>

<a id="find-pass">비밀번호 찾고자 하는 아이디</a><br>

<!-- form -->
<div class="form-container">
<form id="join_frm">
<input type="text" name="id" id="id" maxlength="20" placeholder="아이디" class="input-large"><br>
<button type="button" id="join" class="button-check">확인</button>
</form>
</div>

<a class="find-link" href="${pageContext.request.contextPath}/member/find">아이디/비밀번호 찾기</a>

<!-- script -->
<script type="text/javascript">
// 버튼 안누르고 엔터 누르면 폼 제출되는 현상 막음, 엔터 눌러도 버튼 누르는 작동 됨
$('#id').keypress(function(e){
    if(e.which == 13){ //Enter key pressed
        e.preventDefault(); //Prevent form submission
        $('#join').click(); //Trigger button click
    }
});

function fn_join(){
	var f = $('#join_frm');
	var formData = f.serialize();
	$.ajax({
		type : "POST",
		url : "${pageContext.request.contextPath}/member/checkid",
		data : {id: $('#id').val()},
		success: function(data){
			if(data){	
				location.href="${pageContext.request.contextPath}/member/findpass2?id=" + data;
			}else{
				alert("입력하신 아이디를 찾을 수 없습니다.");
			}
		},
		error: function(data){
			alert("에러 발생!");
		}
	});
}
$(function() {
	var idRegex = /^[a-zA-Z0-9]{8,16}$/;
	$('#join').click(function(){
		if(!idRegex.test($('#id').val())){
		    alert("아이디를 정확하게 입력해 주세요.");
		    return false;
		}
		fn_join();
	});
});
</script>
</body>
</html>
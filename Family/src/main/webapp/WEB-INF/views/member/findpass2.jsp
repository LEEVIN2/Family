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
.button-container {
    display: flex;
    justify-content: center; /* 가로축 가운데 정렬 */
    align-items: center; /* 세로축 가운데 정렬 */
	margin-top: 2%; /* 위쪽 여백 */
}
.active {
	display: flex; /* 플렉스박스로 설정 */
    justify-content: center; /* 가로축 가운데 정렬 */
    align-items: center; /* 세로축 가운데 정렬 */
    width: 330px; /* 너비 */
    height: 70px; /* 높이 */
    background-color: black;
    color: white;
    font-size: 20px;
    border-radius: 20px; /* 모서리 */
}
.inactive {
	display: flex; /* 플렉스박스로 설정 */
    justify-content: center; /* 가로축 가운데 정렬 */
    align-items: center; /* 세로축 가운데 정렬 */
    width: 330px; /* 너비 */
    height: 70px; /* 높이 */
    font-size: 20px;
    border-radius: 20px; /* 모서리 */
}
hr {
    border: none; /* 기본 테두리 제거 */
    border-top: 2px solid #b7b7b7; /* 굵기와 색상 설정 */
    width: 660px; /* 길이 설정 */
    margin-top: 20px; /* 위쪽 마진 설정 */
    margin-bottom: 20px; /* 아래쪽 마진 설정 */
}
.form-container {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    	padding-bottom: 1%; /* 아래쪽 여백 */
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
.input-small {
    width: 250px;
    height: 55px;
    font-size: 20px; /* 글자 크기 지정 */
    margin: 7px; /* margin 추가 */
    border-radius: 20px; /* 모서리 둥글게 */
    border: 3px solid black; /* 모서리 색상 검정으로 지정 */
    text-align: center; /* 텍스트를 가로로 중앙 정렬 */
    line-height: 60px; /* 텍스트를 세로로 중앙 정렬, 높이와 동일하게 설정해야 텍스트가 수직 중앙에 배치*/
}
.email_auth_btn {
    width: 85px; /* 버튼의 너비 */
    height: 68px; /* 버튼의 높이 */
    background-color: black;
    color: white;
    font-size: 20px;
    border-radius: 20px; /* 버튼의 모서리를 둥글게 */
}
.mobile_auth_btn {
    width: 85px; /* 버튼의 너비 */
    height: 68px; /* 버튼의 높이 */
    background-color: black;
    color: white;
    font-size: 20px;
    border-radius: 20px; /* 버튼의 모서리를 둥글게 */
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
    margin-top: 3%;
}
</style>
</head>

<!-- body -->
<body>
<div class="image-container">
	<img src="${pageContext.request.contextPath}/resources/img/member/logo.png" alt="logo">
</div>

<div class="button-container">
    <a id="emailButton" class="active">이메일로 찾기</a>
    <a id="phoneButton" class="inactive">전화번호로 찾기</a>
</div>

<hr>

<!-- form -->
<div class="form-container">
<form id="findemail">
<input type="hidden" name="id" id="id" value="${param.id}">
<input type="text" name="email" id="email" maxlength="30" placeholder="이메일" class="input-small">
<button type="button" id="email_auth_btn" class="email_auth_btn">인증</button><br>
<input type="text" id="email_auth_key" placeholder="인증번호" class="input-large"><br>
<input type="password" name="pass" id="pass" maxlength="16" placeholder="새로운 비밀번호" class="input-large"><br>
<input type="password" id="pass2" maxlength="16" placeholder="비밀번호 확인" class="input-large"><br>
<button type="button" id="join" class="button-check">비밀번호 재설정</button>
</form>

<!-- form -->
<form id="findmobile">
<input type="hidden" name="id" id="id" value="${param.id}">
<input type="text" name="mobile" id="mobile" maxlength="11" pattern="\d*" placeholder="전화번호" class="input-small">
<button type="button" id="mobilebtn" class="mobile_auth_btn">인증</button><br>
<input type="text" id="mobilecheck" placeholder="인증번호" class="input-large"><br>
<input type="password" name="pass" id="pass3" maxlength="16" placeholder="새로운 비밀번호" class="input-large"><br>
<input type="password" id="pass4" maxlength="16" placeholder="비밀번호 확인" class="input-large"><br>
<button type="button" id="join2" class="button-check">비밀번호 재설정</button>
</form>

<a class="find-link" href="${pageContext.request.contextPath}/member/find">아이디/비밀번호 찾기</a>
</div>

<!-- script -->
<script type="text/javascript">
window.onload = function() {
    // 페이지가 로드되면 이메일로 찾기 버튼을 누른 것처럼 동작합니다.
    document.getElementById('findemail').style.display = 'block';
    document.getElementById('findmobile').style.display = 'none';
 	// css 때문에 넣은 코드 2개
    document.getElementById('emailButton').classList.add('active');
    document.getElementById('phoneButton').classList.add('inactive');
};
//이메일로 찾기와 전화번호로 찾기 버튼에 이벤트를 추가합니다.
document.querySelector('a').addEventListener('click', function() {
    // 이메일로 찾기 버튼을 누르면 findemail 폼을 보여주고 findmobile 폼을 숨깁니다.
    document.getElementById('findemail').style.display = 'block';
    document.getElementById('findmobile').style.display = 'none';
 	// css 때문에 넣은 코드 4개
    this.classList.add('active');
    this.classList.remove('inactive');
    document.getElementById('phoneButton').classList.remove('active');
    document.getElementById('phoneButton').classList.add('inactive');
});

document.querySelectorAll('a')[1].addEventListener('click', function() {
    // 전화번호로 찾기 버튼을 누르면 findmobile 폼을 보여주고 findemail 폼을 숨깁니다.
    document.getElementById('findmobile').style.display = 'block';
    document.getElementById('findemail').style.display = 'none';
 	// css 때문에 넣은 코드 4개
    this.classList.add('active');
    this.classList.remove('inactive');
    document.getElementById('emailButton').classList.remove('active');
    document.getElementById('emailButton').classList.add('inactive');
});

function fn_join(){
	var f = $('#findemail');
	var formData = f.serialize();
		
	$.ajax({
		type : "POST",
		url : "${pageContext.request.contextPath}/member/findpassPro",
		data : formData,
		success: function(data){
			if(data == "Y"){	
				location.href="${pageContext.request.contextPath}/member/login"
			}else{
				alert("에러 발생!");
			}
		},
		error: function(data){
			alert("에러 발생!");
			console.log(data);
		}
	});
 }
 
function fn_join2(){
	var f = $('#findmobile');
	var formData = f.serialize();
		
	$.ajax({
		type : "POST",
		url : "${pageContext.request.contextPath}/member/findpassPro",
		data : formData,
		success: function(data){
			if(data == "Y"){	
				location.href="${pageContext.request.contextPath}/member/login"
			}else{
				alert("에러 발생!");
			}
		},
		error: function(data){
			alert("에러 발생!");
			console.log(data);
		}
	});
 }

$(function() { 
	 var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	 var email_auth_cd = null;
	 var passwordRegex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
	 
	$('#join').click(function(){
		
		if($('#email').val() == ""){
			alert("이메일을 입력해주세요.");
			return false;
		}
		
		if(!emailRegex.test($('#email').val())){
		    alert("이메일을 올바르게 입력해주세요.");
		    return false;
		}
		
		if(email_auth_cd === null){
           alert("인증번호를 받아주세요.");
           return false;
       }
		
		if($('#id').val() + "," + $('#email').val() + "," + $('#email_auth_key').val() != email_auth_cd){
			alert("인증번호가 일치하지 않습니다.");
			return false;
		}
		
		if($('#pass').val() == ""){
			alert("비밀번호를 입력해주세요.");
			return false;
		}
		
		if(!passwordRegex.test($('#pass').val())){
		    alert("8~16자의 영문 대/소문자, 숫자, 특수문자를 사용해 주세요.");
		    return false;
		}
		
		if($('#pass').val() != $('#pass2').val()){
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
		
		fn_join();	
	});
	
// 	이메일 인증
	$(".email_auth_btn").click(function(){	     	 
    	 var email = $('#email').val();
    	 var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    	 if(email == ''){
    	 	alert("이메일을 입력해주세요.");
    	 	return false;
    	 }
    	 if(!emailRegex.test($('#email').val())){
 		    alert("이메일을 올바르게 입력해주세요.");
 		    return false;
 		}
    	 
    	 $.ajax({
    			type : "POST",
    			url : "${pageContext.request.contextPath}/member/emailAuth2",
    			data : {
    				email : email,
    				id : "${param.id}" // id를 추가합니다.
    			},
    			success: function(data){
    				alert("인증번호가 발송되었습니다.");
    				email_auth_cd = data;
    			},
    			error: function(data){
    				alert("메일 발송에 실패했습니다.");
    			}
    		}); 
	});
	
});


$(function() { 
	 var phoneRegex = /^01([0|1])([0-9]{4})([0-9]{4})$/;
	 var code2 = null;
	 var passwordRegex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
	 
	$('#join2').click(function(){
		
		if($('#mobile').val() == ""){
			alert("전화번호를 입력해주세요.");
			return false;
		}
		
		if(!phoneRegex.test($('#mobile').val())){
		    alert("올바른 전화번호를 입력해주세요.");
		    return false;
		}
		
		if(code2 === null){
          alert("인증번호를 받아주세요.");
          return false;
      }
		
		if($('#id').val() + "," + $('#mobile').val() + "," + $('#mobilecheck').val() != code2){
			alert("인증번호가 일치하지 않습니다.");
			return false;
		}
		
		if($('#pass3').val() == ""){
			alert("비밀번호를 입력해주세요.");
			return false;
		}
		
		if(!passwordRegex.test($('#pass3').val())){
		    alert("8~16자의 영문 대/소문자, 숫자, 특수문자를 사용해 주세요.");
		    return false;
		}
		
		if($('#pass3').val() != $('#pass4').val()){
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
	
		fn_join2();
	});
	
// 	전화번호 인증
	$("#mobilebtn").click(function(){
		var mobile = $("#mobile").val();
		var phoneRegex = /^01([0|1])([0-9]{4})([0-9]{4})$/;
		
		if($('#mobile').val() == ""){
			alert("전화번호를 입력해주세요.");
			return false;
		}
		if(!phoneRegex.test($('#mobile').val())){
		    alert("올바른 전화번호를 입력해주세요.");
		    return false;
		}
		
		$.ajax({
			type:"POST",
			url:"${pageContext.request.contextPath}/member/mobile2",
			data : {
				mobile : mobile,
				id : "${param.id}" // id를 추가합니다.
			},
			success: function(data){
				alert("인증번호가 발송되었습니다.");
				code2 = data;
			},
			error: function(data){
				alert("에러 발생!");
			}
		}); 
	});

	//전화번호 숫자만 입력 가능
	document.getElementById('mobile').addEventListener('input', function (e) {
		  e.target.value = e.target.value.replace(/[^0-9]/g, '');
		});
	
});
</script>
</body>
</html>
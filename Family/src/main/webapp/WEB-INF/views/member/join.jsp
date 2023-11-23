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
    text-align: center; /* 이미지를 가운데 정렬 */
    padding-top: 7em; /* 이미지와 버튼 사이에 여백을 추가 */
}

.image-container img {
    width: 522px; /* 이미지의 너비를 설정하세요 */
    height: 179px; /* 이미지의 높이를 설정하세요 */
}
.join {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        height: 70vh; /* 뷰포트 높이의 100% */
}
.input-large {
    width: 350px;
    height: 60px;
    font-size: 20px; /* 글자 크기 지정 */
    margin: 7px; /* margin 추가 */
    border-radius: 20px; /* 모서리 둥글게 */
    border: 3px solid black; /* 모서리 색상 검정으로 지정 */
    text-align: center; /* 텍스트를 가로로 중앙 정렬 */
    line-height: 60px; /* 텍스트를 세로로 중앙 정렬 */
}
.input-small {
    width: 250px;
    height: 60px;
    font-size: 20px; /* 글자 크기 지정 */
    margin: 7px; /* margin 추가 */
    border-radius: 20px; /* 모서리 둥글게 */
    border: 3px solid black; /* 모서리 색상 검정으로 지정 */
    text-align: center; /* 텍스트를 가로로 중앙 정렬 */
    line-height: 60px; /* 텍스트를 세로로 중앙 정렬, 높이와 동일하게 설정해야 텍스트가 수직 중앙에 배치*/
}
.button-acc {
    width: 90px; /* 버튼의 너비 */
    height: 65px; /* 버튼의 높이 */
    background-color: black;
    color: white;
    font-size: 20px;
    border-radius: 20px; /* 버튼의 모서리를 둥글게 */
}
.button-join {
    width: 360px; /* 버튼의 너비 */
    height: 65px; /* 버튼의 높이 */
    background-color: black;
    color: white;
    font-size: 20px;
    border-radius: 20px; /* 버튼의 모서리를 둥글게 */
    margin: 7px; /* margin 추가 */
}
.login-link {
    margin-top: 70px; /* 원하는 여백 크기로 조정하세요 */
}
a {
    text-decoration: none;
    color: gray;
	font-size: 20px;
}
</style>
</head>

<!-- body -->
<body>

<!-- form -->
<div class="image-container">
	<img src="${pageContext.request.contextPath}/resources/img/member/logo.png" alt="logo">
</div>

<div class="join">
    <div>
        <form id="join_frm">
        <input type="text" name="id" id="id" maxlength="20" placeholder="아이디" class="input-large"><br>
        <input type="password" name="pass" id="pass" maxlength="16" placeholder="비밀번호" class="input-large"><br>
        <input type="password" id="pass2" maxlength="16" placeholder="비밀번호 확인" class="input-large"><br>
        <input type="text" name="email" id="email" maxlength="30" placeholder="이메일" class="input-large"><br>
        <input type="text" name="mobile" id="mobile" maxlength="11" pattern="\d*" placeholder="전화번호" class="input-small">
        <button type="button" id="mobilebtn" class="button-acc">인증</button><br>
        <input type="text" id="mobilecheck" placeholder="인증번호" class="input-large"><br>
        <button type="button" id="join" class="button-join">회원가입</button>
        </form>
    </div>

    <div class="login-link">
        <a href="${pageContext.request.contextPath}/member/login">로그인하기</a>
    </div>
</div>

<!-- script -->
<script type="text/javascript">
function fn_join(){
	var f = $('#join_frm');
	var formData = f.serialize();
		
	$.ajax({
		type : "POST",
		url : "${pageContext.request.contextPath}/member/joinPro",
		data : formData,
		success: function(data){
			if(data == "Y"){
				alert("회원가입이 완료되었습니다.");	
				location.href="${pageContext.request.contextPath}/member/home"
			}else{
				alert("회원가입에 실패하였습니다.");
			}
		},
		error: function(data){
			alert("회원가입 에러 발생!");
			console.log(data);
		}
	});
 }
 
 $(function() { 
	 var idRegex = /^[a-zA-Z0-9]{8,16}$/;
	 var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	 var passwordRegex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
	 var phoneRegex = /^01([0|1])([0-9]{4})([0-9]{4})$/;
// 	 var email_auth_cd = null;
// 	 var code2 = null;
	 
	$('#join').click(function(){
		
		if($('#id').val() == ""){
			alert("아이디를 입력해주세요.");
			return false;
		}
		
		if(!idRegex.test($('#id').val())){
		    alert("8~16자의 영문 대/소문자 또는 숫자만 사용 가능합니다.");
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
		
		if($('#email').val() == ""){
			alert("이메일을 입력해주세요.");
			return false;
		}
		
		if(!emailRegex.test($('#email').val())){
		    alert("이메일을 올바르게 입력해주세요.");
		    return false;
		}
		
		if($('#mobile').val() == ""){
			alert("전화번호를 입력해주세요.");
			return false;
		}
		
		if(!phoneRegex.test($('#mobile').val())){
		    alert("올바른 전화번호를 입력해주세요.");
		    return false;
		}
		
// 		if(email_auth_cd === null){
//             alert("인증번호를 받아주세요.");
//             return false;
//         }
		
// 		if($('#email_auth_key').val() != email_auth_cd){
// 			alert("인증번호가 일치하지 않습니다.");
// 			return false;
// 		}
		
// 		if(code2 === null){
//             alert("인증번호를 받아주세요.");
//             return false;
//         }
		
// 		if($('#mobilecheck').val() != code2){
// 			alert("인증번호가 일치하지 않습니다.");
// 			return false;
// 		}
	
		fn_join();
	});
	
	//이메일 인증
// 	$(".email_auth_btn").click(function(){	     	 
//     	 var email = $('#email').val();
//     	 var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
//     	 if(email == ''){
//     	 	alert("이메일을 입력해주세요.");
//     	 	return false;
//     	 }
//     	 if(!emailRegex.test($('#email').val())){
//  		    alert("이메일을 올바르게 입력해주세요.");
//  		    return false;
//  		}
    	 
//     	 $.ajax({
// 			type : "POST",
// 			url : "${pageContext.request.contextPath}/member/emailAuth",
// 			data : {email : email},
// 			success: function(data){
// 				alert("인증번호가 발송되었습니다.");
// 				email_auth_cd = data;
// 			},
// 			error: function(data){
// 				alert("메일 발송에 실패했습니다.");
// 			}
// 		}); 
// 	});
	
	//휴대폰 번호 인증
// 	$("#mobilebtn").click(function(){
// 		var mobile = $("#mobile").val();
// 		if($('#mobile').val() == ""){
// 			alert("전화번호를 입력해주세요.");
// 			return false;
// 		}
// 		$.ajax({
// 			type:"GET",
// 			url:"${pageContext.request.contextPath}/member/mobile?mobile=" + mobile,
// 	        cache : false,
// 			success: function(data){
// 				if(data == "error"){
// 	        		alert("인증번호 발송에 실패했습니다.")
// 	        	}else{
// 	        		alert("인증번호가 발송되었습니다.")
// 	        		code2 = data;
// 	        	}
// 			}
// 		});
// 	});
	
	//전화번호 숫자만 입력 가능
	document.getElementById('mobile').addEventListener('input', function (e) {
		  e.target.value = e.target.value.replace(/[^0-9]/g, '');
		});
	
 });
</script>
</body>
</html>
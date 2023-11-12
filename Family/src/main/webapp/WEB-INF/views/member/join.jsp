<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<title>Insert title here</title>
</head>
<style>
a {
    text-decoration: none;
}
</style>
<body>
<form id="join_frm">
아이디<input type="text" name="id" id="id" maxlength="20"><br>
비밀번호<input type="password" name="pass" id="pass" maxlength="16"><br>
비밀번호 확인<input type="password" id="pass2" maxlength="16"><br>
이메일<input type="text" name="email" id="email" maxlength="30"><br>
<!-- <button type="button" id="email_auth_btn" class="email_auth_btn">인증번호 보내기</button><br> -->
<!-- <input type="text" placeholder="인증번호 입력" id="email_auth_key"><br> -->
전화번호<input type="text" name="mobile" id="mobile" maxlength="11" pattern="\d*">
<button type="button" id="mobilebtn">인증번호 보내기</button><br>
<input type="text" placeholder="인증번호 입력" id="mobilecheck">
<button type="button" id="join">회원가입</button>
</form>
<a href="${pageContext.request.contextPath}/member/login">로그인하기</a>
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
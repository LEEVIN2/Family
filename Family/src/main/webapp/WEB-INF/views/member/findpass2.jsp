<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<a>이메일로 찾기</a>
<a>전화번호로 찾기</a>

<form id="findemail">
<input type="hidden" name="id" id="id" value="${param.id}">
이메일<input type="text" name="email" id="email" maxlength="30">
<button type="button" id="email_auth_btn" class="email_auth_btn">인증</button><br>
<input type="text" placeholder="인증번호 입력" id="email_auth_key"><br>
새로운 비밀번호<input type="password" name="pass" id="pass" maxlength="16"><br>
비밀번호 확인<input type="password" id="pass2" maxlength="16"><br>
<button type="button" id="join">비밀번호 재설정</button>
</form>

<form id="findmobile">
<input type="hidden" name="id" id="id" value="${param.id}">
전화번호<input type="text" name="mobile" id="mobile" maxlength="11" pattern="\d*">
<button type="button" id="mobilebtn">인증</button><br>
<input type="text" placeholder="인증번호 입력" id="mobilecheck"><br>
새로운 비밀번호<input type="password" name="pass" id="pass3" maxlength="16"><br>
비밀번호 확인<input type="password" id="pass4" maxlength="16"><br>
<button type="button" id="join2">비밀번호 재설정</button>
</form>

<br><br><a href="${pageContext.request.contextPath}/member/find">아이디/비밀번호 찾기</a>

<script type="text/javascript">
window.onload = function() {
    // 페이지가 로드되면 이메일로 찾기 버튼을 누른 것처럼 동작합니다.
    document.getElementById('findemail').style.display = 'block';
    document.getElementById('findmobile').style.display = 'none';
};
//이메일로 찾기와 전화번호로 찾기 버튼에 이벤트를 추가합니다.
document.querySelector('a').addEventListener('click', function() {
    // 이메일로 찾기 버튼을 누르면 findemail 폼을 보여주고 findmobile 폼을 숨깁니다.
    document.getElementById('findemail').style.display = 'block';
    document.getElementById('findmobile').style.display = 'none';
});

document.querySelectorAll('a')[1].addEventListener('click', function() {
    // 전화번호로 찾기 버튼을 누르면 findmobile 폼을 보여주고 findemail 폼을 숨깁니다.
    document.getElementById('findmobile').style.display = 'block';
    document.getElementById('findemail').style.display = 'none';
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
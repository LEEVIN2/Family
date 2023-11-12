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
이메일<input type="text" name="email" id="email" maxlength="30"><br>
<button type="button" id="email_auth_btn" class="email_auth_btn">인증번호 보내기</button><br>
<input type="text" placeholder="인증번호 입력" id="email_auth_key"><br>
<button type="button" id="join">확인</button>
</form>

<form id="findmobile">
휴대전화번호<input type="text" name="mobile" id="mobile" maxlength="11" pattern="\d*"><br>
<button type="button" id="mobilebtn">인증번호 보내기</button><br>
<input type="text" placeholder="인증번호 입력" id="mobilecheck"><br>
<button type="button" id="join2">확인</button>
</form>

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
		url : "${pageContext.request.contextPath}/member/showidPro",
		data : formData,
		success: function(data){
			if(data == "Y"){	
				location.href="${pageContext.request.contextPath}/member/showid"
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
		url : "${pageContext.request.contextPath}/member/showidPro",
		data : formData,
		success: function(){
			location.href="${pageContext.request.contextPath}/member/showid"
		},
		
	});
 }

$(function() { 
	 var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	 var email_auth_cd = null;
	 
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
           alert("이메일 인증번호를 받아주세요.");
           return false;
       }
		
		if($('#email_auth_key').val() != email_auth_cd){
			alert("이메일 인증번호가 일치하지 않습니다.");
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
			url : "${pageContext.request.contextPath}/member/emailAuth",
			data : {email : email},
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
	 var phoneRegex = /^01([0|1]?)([0-9]{4})([0-9]{4})$/;
	 
	$('#join2').click(function(){
		
		if($('#mobile').val() == ""){
			alert("휴대전화번호를 입력해주세요.");
			return false;
		}
		
		if(!phoneRegex.test($('#mobile').val())){
		    alert("올바른 휴대전화번호를 입력해주세요.");
		    return false;
		}
		
		if(code2 === null){
          alert("휴대전화 인증번호를 받아주세요.");
          return false;
      }
		
		if($('#mobilecheck').val() != code2){
			alert("휴대전화번호 인증번호가 일치하지 않습니다.");
			return false;
		}
	
		fn_join2();
	});
	
// 	휴대폰 번호 인증
	$("#mobilebtn").click(function(){
		var mobile = $("#mobile").val();
		if($('#mobile').val() == ""){
			alert("휴대전화번호를 입력해주세요.");
			return false;
		}
		$.ajax({
			type:"GET",
			url:"${pageContext.request.contextPath}/member/mobile?mobile=" + mobile,
	        cache : false,
			success: function(data){
				if(data == "error"){
	        		alert("인증번호 발송에 실패했습니다.")
	        	}else{
	        		alert("인증번호가 발송되었습니다.")
	        		code2 = data;
	        	}
			}
		});
	});
	
	//휴대전화번호 숫자만 입력 가능
	document.getElementById('mobile').addEventListener('input', function (e) {
		  e.target.value = e.target.value.replace(/[^0-9]/g, '');
		});
	
});
</script>
</body>
</html>
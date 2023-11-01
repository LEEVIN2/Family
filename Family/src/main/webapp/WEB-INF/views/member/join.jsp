<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${path}/resources/js/join.js"></script>
<link rel="stylesheet" href="${path}/resources/css/default.css">
<link rel="stylesheet" href="${path}/resources/css/join.css">
	<title>filetable</title>
</head>
<body>
<div id="container" class="container">
	<div class="content">
		<div class="join_wrap">
			<form id="join_frm">
				<div class="join_title">회원가입</div>
				<div class="join_box">
					<input type="text" placeholder="아이디" name="id" id="id" style="margin: 0;">
					<span id="id_ck" class="dpn">이미 사용중인 아이디입니다.</span>
					<input type="text" placeholder="닉네임" name="nickname" id="nickname">
					<span id="nickname_ck" class="dpn">이미 사용중인 닉네임입니다.</span>
					<input type="password" placeholder="비밀번호" name="password" id="password">
					<input type="password" placeholder="비밀번호  확인" id="password_ck">				
					<div class="email_auth">
						<input type="text" placeholder="이메일" name="email" id="email" class="email">
						<button type="button" id="email_auth_btn" class="email_auth_btn">인증번호 받기</button>
					</div>
					<input type="text" placeholder="인증번호 입력" id="email_auth_key">
				</div>
				<button type="button" id="join" class="join_btn">가입하기</button>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
/**
 *  회원가입 관련 처리
 */
 
 function fn_join(){
	var f = $('#join_frm');
	var formData = f.serialize();
		
	$.ajax({
		type : "POST",
		url : "${pageContext.request.contextPath}/member/insertPro",
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
 	
 	var email_auth_cd = '';
 
	$('#join').click(function(){
		
		if($('#id').val() == ""){
			alert("아이디를 입력해주세요.");
			return false;
		}
		
		if($('#nickname').val() == ""){
			alert("닉네임을 입력해주세요.");
			return false;
		}
		
		if($('#password').val() == ""){
			alert("비밀번호를 입력해주세요.");
			return false;
		}
		
		if($('#password').val() != $('#password_ck').val()){
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
		
		if($('#email_auth_key').val() != email_auth_cd){
			alert("인증번호가 일치하지 않습니다.");
			return false;
		}
	
		fn_join();
	});
	
	$(".email_auth_btn").click(function(){	     	 
    	 var email = $('#email').val();
    	 
    	 if(email == ''){
    	 	alert("이메일을 입력해주세요.");
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
	
	$('#id').focusout(function(){
		var id = $('#id').val();
	
		$.ajax({
			type : "POST",
			url : "/idCheck",
			data : {id : id},
			success: function(data){
				console.log(data);
				if(data == "Y"){
					$('#id_ck').removeClass("dpn");
				}else{
					$('#id_ck').addClass("dpn");
				}
			},
			error: function(data){
			}
		}); 
	});
	
	$('#nickname').focusout(function(){
		var nickname = $('#nickname').val();
	
		$.ajax({
			type : "POST",
			url : "/nicknameCheck",
			data : {nickname : nickname},
			success: function(data){
				if(data == "Y"){
					$('#nickname_ck').removeClass("dpn");
				}else{
					$('#nickname_ck').addClass("dpn");
				}
			},
			error: function(data){
			}
		}); 
	});
 });
 </script>
</body>
</html>
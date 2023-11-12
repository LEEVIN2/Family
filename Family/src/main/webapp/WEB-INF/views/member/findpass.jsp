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
<form id="join_frm">
이메일<input type="text" name="email" id="email" maxlength="30"><br>
<button type="button" id="email_auth_btn" class="email_auth_btn">인증번호 보내기</button><br>
<input type="text" placeholder="인증번호 입력" id="email_auth_key"><br>
</form>
</body>
</html>
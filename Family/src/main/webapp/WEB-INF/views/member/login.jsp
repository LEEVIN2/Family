<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
a {
    text-decoration: none;
}
</style>
<body>
<form action="${pageContext.request.contextPath}/member/loginPro" method="post">
아이디<input type="text" name="id"><br>
비밀번호<input type="password" name="pass">
<button>로그인</button>
</form>
<a href="${pageContext.request.contextPath}/member/join">회원가입</a>
<a href="${url}"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
</body>
</html>
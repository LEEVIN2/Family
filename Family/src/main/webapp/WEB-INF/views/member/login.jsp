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
<a href="${pageContext.request.contextPath}/member/find">아이디/비밀번호 찾기</a><br><br>
<a>-간편로그인-</a><br>
<a href="${url}"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a><br>
<a href="https://kauth.kakao.com/oauth/authorize?client_id=da018b782fe37e409f166154390e2391&redirect_uri=http://localhost/family/member/kakaoLogin&response_type=code">카카오톡 로그인</a><br><br>
<a href="${pageContext.request.contextPath}/member/join">회원가입하기</a><br>
<script type="text/javascript">
// 버튼 안누르고 엔터 누르면 폼 제출되는 현상 막음, 엔터 눌러도 버튼 누르는 작동 됨
$('#id').keypress(function(e){
    if(e.which == 13){ //Enter key pressed
        e.preventDefault(); //Prevent form submission
        $('#join').click(); //Trigger button click
    }
});
</script>
</body>
</html>
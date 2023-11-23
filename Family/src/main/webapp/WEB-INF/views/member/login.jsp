<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<!-- head -->
<head>
<meta charset="UTF-8">
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
.login {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        height: 70vh; /* 뷰포트 높이의 100% */
}
.input-login {
    width: 350px;
    height: 60px;
    font-size: 20px; /* 글자 크기 지정 */
    margin: 5px; /* margin 추가 */
    border-radius: 20px; /* 모서리 둥글게 */
    border: 3px solid black; /* 모서리 색상 검정으로 지정 */
    text-align: center; /* 텍스트를 가로로 중앙 정렬 */
    line-height: 60px; /* 텍스트를 세로로 중앙 정렬 */
}
.button-login {
    width: 360px; /* 버튼의 너비 */
    height: 65px; /* 버튼의 높이 */
    background-color: black;
    color: white;
    font-size: 20px;
    border-radius: 20px; /* 버튼의 모서리를 둥글게 */
    margin: 5px; /* margin 추가 */
}
#find-link {
    color: gray; /* 글씨색을 gray로 설정 */
    margin: 15px 0; /* 위 아래 margin 값을 설정 */
    font-size: 20px;
    text-decoration: none;
}
#join-link {
    color: gray;
    font-size: 20px;
    text-decoration: none;
    margin-top: 70px;
}
#quick-login {
    color: black;
    font-size: 20px;
}
 .quick-login-img {
        width: 350px;
        height: 89px;
}
</style>
</head>

<!-- body -->
<body>
<div class="image-container">
	<img src="${pageContext.request.contextPath}/resources/img/member/logo.png" alt="logo">
</div>

<!-- form -->
<div class="login">
<div>
	<form action="${pageContext.request.contextPath}/member/loginPro" method="post">
		<input type="text" name="id" placeholder="아이디" class="input-login"><br>
		<input type="password" name="pass" placeholder="비밀번호" class="input-login"><br>
		<button class="button-login">로그인</button>
	</form>
</div>

<a id="find-link" href="${pageContext.request.contextPath}/member/find">아이디/비밀번호 찾기</a><br><br>

<a id="quick-login">ㅡ 간편로그인 ㅡ</a><br>
<a href="${url}"><img class="quick-login-img" src="${pageContext.request.contextPath}/resources/img/member/naver_login.png"></a><br>
<a href="https://kauth.kakao.com/oauth/authorize?client_id=da018b782fe37e409f166154390e2391&redirect_uri=http://localhost/family/member/kakaoLogin&response_type=code"><img class="quick-login-img" src="${pageContext.request.contextPath}/resources/img/member/kakao_login.png"></a><br>

<a id="join-link" href="${pageContext.request.contextPath}/member/join">회원가입하기</a><br>
</div>

<!-- script -->
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
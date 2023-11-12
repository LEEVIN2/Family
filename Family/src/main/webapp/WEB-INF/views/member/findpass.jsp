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
<a>비밀번호 찾고자 하는 아이디</a><br>
<form id="join_frm">
아이디<input type="text" name="id" id="id" maxlength="20"><br>
<button type="button" id="join">확인</button><br><br>
</form>
<a href="${pageContext.request.contextPath}/member/find">아이디/비밀번호 찾기</a>
<script type="text/javascript">
// 버튼 안누르고 엔터 누르면 폼 제출되는 현상 막음, 엔터 눌러도 버튼 누르는 작동 됨
$('#id').keypress(function(e){
    if(e.which == 13){ //Enter key pressed
        e.preventDefault(); //Prevent form submission
        $('#join').click(); //Trigger button click
    }
});

function fn_join(){
	var f = $('#join_frm');
	var formData = f.serialize();
	$.ajax({
		type : "POST",
		url : "${pageContext.request.contextPath}/member/checkid",
		data : {id: $('#id').val()},
		success: function(data){
			if(data){	
				location.href="${pageContext.request.contextPath}/member/findpass2?id=" + data;
			}else{
				alert("입력하신 아이디를 찾을 수 없습니다.");
			}
		},
		error: function(data){
			alert("에러 발생!");
		}
	});
}
$(function() {
	var idRegex = /^[a-zA-Z0-9]{8,16}$/;
	$('#join').click(function(){
		if(!idRegex.test($('#id').val())){
		    alert("아이디를 정확하게 입력해 주세요.");
		    return false;
		}
		fn_join();
	});
});
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js">
</script>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#loginForm").on("keypress", "input", function(event){
		if(event.keyCode ==13 ){
			return false;
		}
	});
	
	$("#loginBtn").on("click",function(){
		if($.trim($("#mId").val()) ==""){
			alert("아이디를 입력해주세요.");
			$("#mId").focus();
		} else if($.trim($("#mPw").val()) == ""){
			alert("비밀번호를 입력해주세요.");
			$("#mPw").focus();
		} else {
			$("#loginForm").submit();
		}
	});// loginBtn end
}); //ready end
</script>
<title>로그인</title>
</head>
<body>
<form action="testLogins" id="loginForm" method="post">
아이디<input type="text" id="mId" name="mId"/><br/>
비밀번호<input type="password" id="mPw" name="mPw"/><br/>
<input type="button" value="로그인" id="loginBtn"/>
</form>
</body>
</html>
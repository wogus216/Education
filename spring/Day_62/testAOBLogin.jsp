<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style type="text/css">
#sp_msg{
	color: red;
}
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#loginBtn").on("click",function(){
		if($.trim($("#mId").val()) == ""){
			alert("아이디를 입력해주세요");
			$("#mId").focus();
		} else if($.trim($("#mPw").val()) == ""){
			alert("비밀번호를 입력해주세요");
			$("#mPw").focus();
		} else {
			var params = $("#loginForm").serialize();
			
			$.ajax({
				url: "testAOBLogins",
				type: "post",
				dataType: "json",
				data: params,
				success: function(res){
					console.log(res)
					if(res.Msg == "success"){
						location.href = "testAOBList";
					} else{
						alert("아이디 또는 비밀번호가 일치하지 않습니다.")
						$("#sp_msg").html("아이디 또는 비밀번호가 일치하지 않습니다.")
					}
				},
				error: function(request, status, error){
					console.log(error);
				}
			}); // ajax end
		}
	}); 
}); //ready end
</script>
</head>
<body>
<form action="#" id="loginForm" method="post">
아이디<input type="text"	id="mId" name="mId"/><br/>
비밀번호<input type="password" id="mPw" name="mPw"/><br/>
<input type="button" value="로그인" id="loginBtn"/>
</form>
<span id="sp_msg"></span> 
</body>
</html>
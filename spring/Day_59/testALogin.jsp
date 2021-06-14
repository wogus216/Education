<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#sp_msg {
	color: red;
}
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js">
</script>	
<script type="text/javascript">
$(document).ready(function(){
	$("#loginBtn").on("click",function(){
		if($.trim($("#mId").val()) ==""){
			alert("아이디를 입력해주세요.");
			$("#mId").focus();
		} else if($.trim($("#mPw").val()) == ""){
			alert("비밀번호를 입력해주세요.");
			$("#mPw").focus();
		} else {
			//form의 data를 문자열로 전환, 
			//serialize: name이 있는 value 값만 가져옴
			var params = $("#loginForm").serialize();
		}
		
			//ajax
			$.ajax({
				url: "testALogins", //접속 주소
				type: "post", // 전송방식 : get, post
				dataType: "json", // 받아 올 데이터 형식
				data : params, // 보낼 데이터 (문자열 형태)
				success : function(res) { //성공 시 다음 함수 실행
					if(res.resMsg == "success"){
						location.href = "testABList";
					} else{
						alert("아이디 또는 비밀번호가 일치하지 않습니다.")
						$("#sp_msg").html("자바스크립트형식신기신기");
					}
					
					console.log(res);
					
				},
				error: function(request, status, error){ //실패 시 다음 함수 실행
					console.log(error);
				}
			
			});
	});// loginBtn end
			

	
});//ready end
</script>	
</head>
<body>
<form action="#" id="loginForm" method="post">
아이디<input type="text" id="mId" name="mId"/><br/>
비밀번호<input type="password" id="mPw" name="mPw"/><br/>
<input type="button" value="로그인" id="loginBtn"/>
<span id="sp_msg"></span>
</form>
</body>
</html>
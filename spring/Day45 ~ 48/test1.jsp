<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="resources/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#sendBtn").on("click",function(){
		$("#sendForm").submit(); //submit(): form실행
	});
});
</script>
</head>
<body>
Hello Spring!!!<br/>
<!-- action: 값을 전송하여 이동할 주소 -->
<form action="test2" id="sendForm" method="post">
<input type="text" name="txt"/>
<input type="button" value="전송" id="sendBtn"/>
</form>
</body>
</html>
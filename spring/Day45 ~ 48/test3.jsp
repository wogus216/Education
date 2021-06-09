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
	$("#goBtn").on("click",function(){
		if($.trim($("#num").val())==""){//트림 필수요소 필터링
			alert("값좀 넣어라");
			$("#num").focus();
		} else{
			$("#goForm").submit(); //submit action 실행
		}
	});
});
</script>
</head>
<body>
<form action="test4" method="post" id="goForm">
<input type="number" name="num" id="num"/>
<input type="button" value="Go" id="goBtn"/>
</form>
</body>
</html>
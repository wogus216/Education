<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
if("${res}" =="failed"){
alert("${res}");
history.back();
	
}else{
	
	alert("성공이다")
	
}
</script>
</head>
<body>

</body>
</html>
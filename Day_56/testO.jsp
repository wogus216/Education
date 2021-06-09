<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#logoutBtn").on("click",function(){
		location.href = "testLogout";
	});
}); //ready end
</script>
</head>
<body>
<%-- ${} 값 호출때 사용 --%>
${sMNm}님 어서오세요.<input type="button" value="로그아웃" id="logoutBtn"/>
</body>
</html>
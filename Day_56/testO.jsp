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
	
	$("#loginBtn").on("click",function(){
		location.href = "testLogin";
	});
}); //ready end
</script>
</head>
<body>
<c:choose>
<%-- 코어태그 안에 주석은 요렇게 --%>
<%-- empty : 비어있다. 반대 !붙여라--%>
	<c:when test="${empty sMNo}">
	<!-- 비로그인 -->
	<input type="button" value="로그인" id="loginBtn"/>
	</c:when>
	<c:otherwise>
		<%-- ${} 값 호출때 사용 --%>
		${sMNm}님 어서오세요.<input type="button" value="로그아웃" id="logoutBtn"/>
</c:otherwise>
</c:choose>
</body>
</html>
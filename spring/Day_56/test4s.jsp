<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오류발생 메시지</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//el 태그 자바스크립트에서 사용 시 무조건 따옴표로 묶어준다.
	if("${cnt}" > 0) {
		$("#goForm").submit();
	} else if("${cnt}" == 0) {
		alert("문제발생");
		history.back();
	} else{
		alert("${msg}");
		history.back();
	}
});
</script>
</head>
<body>
<form action="test2" id="goForm" method="post"> 
	<input type="hidden" name="bNo" value="${param.bNo}" />
	<input type="hidden" name="page" value="${param.page}"/>
	<input type="hidden" name="searchGbn" value="${param.searchGbn}"/>
	<input type="hidden" name="searchTxt" value="${param.searchTxt}"/>
</form>
</body>
</html>
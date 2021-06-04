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
	$("#listBtn").on("click", function(){
		location.href="test1";
	});
	
	$("#updateBtn").on("click",function(){
		$("#goForm").submit();
	}); //up Btn end
}); //ready end
</script>
</head>
<body>
<form action="test4" id="goFomr" method="post">
	<input type="hidden" name="bNo" value="${data.B_NO}"/>
</form>
번호: ${data.B_NO}<br/>
제목: ${data.B_TITLE}<br/>
작성자: ${data.B_WRITER}<br/>
작성일: ${data.B_DT}<br/>
내용<br/>
${data.B_CON}<br/>
<input type="button" value="수정" id="updateBtn"/>
<input type="button" value="목록으로" id="listBtn"/>
</body>
</html>

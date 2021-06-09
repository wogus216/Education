<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세보기</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#listBtn").on("click", function(){
		$("#goForm").attr("action", "test1");
		$("#goForm").submit();
	});
	
	$("#updateBtn").on("click",function(){
		$("#goForm").attr("action", "test4");
		$("#goForm").submit();
	}); //up Btn end
	
	$("#deleteBtn").on("click", function(){
		if(confirm("삭제하시겠습니까?")){
			$("#goForm").attr("action", "test5s");
			$("#goForm").submit();
		}		
	}); //deleteBtn
}); //ready end
</script>
</head>
<body>
<!-- 상세보기에서 받아온 페이지이기 때문에 param.page/ 그냥 page는 컨트롤러에서 받아옴 -->
<form action="#" id="goForm" method="post">
	<input type="hidden" name="bNo" value="${data.B_NO}"/>
	<input type="hidden" name="page" value="${param.page}"/>
	<input type="hidden" name="searchGbn" value="${param.searchGbn}"/>
	<input type="hidden" name="searchTxt" value="${param.searchTxt}"/>
</form>
번호: ${data.B_NO}<br/>
제목: ${data.B_TITLE}<br/>
작성자: ${data.B_WRITER}<br/>
작성일: ${data.B_DT}<br/>
내용<br/>
${data.B_CON}<br/>
<input type="button" value="수정" id="updateBtn"/>
<input type="button" value="삭제" id="deleteBtn"/>
<input type="button" value="목록으로" id="listBtn"/>
</body>
</html>
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
	$("#listBtn").on("click",function(){
		$("#sendForm").attr("action","testAMList");
		$("#sendForm").submit();
	}); //list end
	
	$("#updateBtn").on("click",function(){
		$("#sendForm").attr("action","testAMUpdate");
		$("#sendForm").submit();
	}); //updateBtn end
	
}); //ready end
</script>
</head>
<body>
<form action="#" id="sendForm" method="post">
	<input type="hidden" name="mNo" value="${d.M_NO}"/>
	<input type="hidden" name="page" value="${param.page}"/>
	<input type="hidden" name="searchGbn" value="${param.searchGbn}"/>
	<input type="hidden" name="searchTxt" value="${param.searchTxt}"/>
</form>
회원번호: ${data.M_NO}<br/>
아이디: ${data.M_ID}<br/>
이름: ${data.M_NM}<br/>
생일: ${data.BD}<br/>
가입일: ${data.DT}<br/>
<input type="button" value="수정" id="updateBtn"/>
<input type="button" value="삭제" id="deleteBtn"/>
<input type="button" value="목록으로" id="listBtn"/>
</body>
</html>
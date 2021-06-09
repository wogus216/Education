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
<script type="text/javascript"
		src="resources/script/ckeditor/ckeditor.js">
</script>
<script type="text/javascript">
$(document).ready(function(){
	CKEDITOR.replace("bCon", {
		resize_enabled : false,
		languague : "ko",
		enterMode : "2",
		width : "600",
		height: "300"
	});
	
	$("#backBtn").on("click", function(){
		history.back();
	});
	//form에서 작성하다 엔터누를 시 실행 방지 
	$("#updateForm").on("keypress", "input", function(event){
		if(event.keyCode ==13 ){
			return false;
		}
	});
	
	$("#updateBtn").on("click",function(){
		$("#bCon").val(CKEDITOR.instances['bCon'].getData());
		//입력된게 없는 경우
		if($.trim($("#bTitle").val()) == ""){
			alert("제목을 입력해주세요");
			$("#bTitle").focus();
		} else if($.trim($("#bCon").val()) == ""){
			alert("내용을 입력해 주세요");
			$("#bCon").focus();
		} else{
			$("#updateForm").submit();
		}
	}); //addBtn end
}); //ready end
</script>
</head>
<body>
<form action="test4s" id="updateForm" method="post">
<input type="hidden" name="page" value="${param.page}"/>
<input type="hidden" name="searchGbn" value="${param.searchGbn}"/>
<input type="hidden" name="searchTxt" value="${param.searchTxt}"/>
<input type="hidden" name="bNo" value="${data.B_NO}"/>
제목<input type="text" id="bTitle" name="bTitle" value="${data.B_TITLE}"/><br/>
작성자: ${data.B_WRITER}<br/>
내용<br/>
<textarea rows="20" cols="50" id="bCon" name="bCon">${data.B_CON}</textarea><br/>
</form>
<input type="button" value="수정" id="updateBtn"/>
<input type="button" value="뒤로가기" id="backBtn"/>
</body>
</html>
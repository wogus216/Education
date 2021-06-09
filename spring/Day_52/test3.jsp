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
	
	$("#listBtn").on("click", function(){
		history.back();
	});
	//form에서 작성하다 엔터누를 시 실행 방지 
	$("#addForm").on("keypress", "input", function(event){
		if(event.keyCode ==13 ){
			return false;
		}
	});
	
	$("#addBtn").on("click",function(){
		$("#bCon").val(CKEDITOR.instances['bCon'].getData());
		//입력된게 없는 경우
		if($.trim($("#bTitle").val()) == ""){
			alert("제목을 입력해주세요");
			$("#bTitle").focus();
		} else if($.trim($("#bWriter").val()) == ""){
			alert("작성자를 입력해주세요");
			$("#bWriter").focus();
		} else if($.trim($("#bCon").val()) == ""){
			alert("내용을 입력해 주세요");
			$("#bCon").focus();
		} else{
			$("#addForm").submit();
		}
	}); //addBtn end
}); //ready end
</script>
</head>
<body>
<form action="test3s" id="addForm" method="post">
제목<input type="text" id="bTitle" name="bTitle"/><br/>
작성자<input type="text" id="bWriter" name="bWriter" /><br/>
내용<br/>
<textarea rows="20" cols="50" id="bCon" name="bCon"></textarea><br/>
</form>
<input type="button" value="등록" id="addBtn"/>
<input type="button" value="목록으로" id="listBtn"/>
</body>
</html>
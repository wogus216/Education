<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, inital-scale=1.0,
								maximum-scale=1.0, user-scalable=no" />
<title>모바일작성</title>
<style type="text/css">
#att {
	display: none;
}
input[name=bTitle],input[name=bWriter]{
	border: none;
	border-bottom: 1px solid;
}
input[type=button]{
	background-color: #ffd699;
	border-radius: 8px;
	border: none;
	
}
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
		src="resources/script/ckeditor/ckeditor.js"></script>
<script type="text/javascript" 
		src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	CKEDITOR.replace("bCon", {
		resize_enabled : false,
		languague : "ko",
		enterMode : "2",
		toolbarGroups : [
			{ name: 'basicstyles', groups: ['basicstyles']},
			{ name: 'paragraph', groups: ['align']},
			{ name: 'colors', groups: ['colors']}
		]
	});
	
	
	$("#fileBtn").on("click",function(){
		$("#att").click();
	});
	
	$("#att").on("change", function(){
		//역슬래시를 문자열로 쓰기위해서는 두개를 사용해야 문자열로 처리된다.
		$("#fileName").html($(this).val().substring($(this).val().lastIndexOf("\\") +1 ));
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
		var fileForm = $("#fileForm");
		
		fileForm.ajaxForm({
			beforeSubmit: function(){
				$("#bCon").val(CKEDITOR.instances['bCon'].getData());
				//입력된게 없는 경우
				if($.trim($("#bTitle").val()) == ""){
					alert("제목을 입력해주세요");
					$("#bTitle").focus();
					return false; // ajaxForm 실행 불가
				} else if($.trim($("#bWriter").val()) == ""){
					alert("작성자를 입력해주세요");
					$("#bWriter").focus();
					return false;
				} else if($.trim($("#bCon").val()) == ""){
					alert("내용을 입력해 주세요");
					$("#bCon").focus();
					return false;
				} 
			},
			success : function(res){
				if(res.result == "SUCCESS"){
					// 올라간 파일명 저장					
					if(res.fileName.length > 0) {
						$("#bFile").val(res.fileName[0]);						
					}
					// 글 저장
					var params = $("#addForm").serialize();
					console.log(params)
					$.ajax({
						url: "testMABWrites",
						type: "post",
						dataType: "json",
						data: params,
						success: function(res){
							console.log(res)
							console.log(params)
							if(res.msg == "success"){
								$("#goForm").submit();
							} else if(res.msg == "failed" ){
								alert("작성에 실패하였습니다.");
							} else {
								alert("작성중 에러가 발생하였습니다.");
								
							}
						},
						error: function(request, status, error){
							console.log(error);
						}
					});
				} else{
					alert("파일업로드 중 문제 발생");
					
				}
			},
			error: function(){
				alert("파일업로드 중 문제 발생");
			}
		}); // ajaxForm end
		
		fileForm.submit();
	}); //addBtn end
	
}); //ready end
</script>
</head>
<body>
<form id="fileForm" action="fileUploadAjax"
		method="post" enctype="multipart/form-data">
		<input type="file" name="att" id="att"/>
</form>
<form action="testMABList" id="goForm" method="post">
<input type="hidden" name="page" value="${param.page}">
<input type="hidden" name="searchGbn" value="${param.searchGbn}">
<input type="hidden" name="searchTxt" value="${param.searchTxt}">
</form>
<form action="#" id="addForm" method="post">
<input type="text" placeholder="제목" id="bTitle" name="bTitle"/><br/>
<input type="text" placeholder="작성자" id="bWriter" name="bWriter"/><br/>
내용<br/>
<textarea rows="20" cols="50" id="bCon" name="bCon"></textarea><br/>
첨부파일<input type="button" value="첨부파일선택" id="fileBtn"/>
<span id="fileName"></span>
<input type="hidden" name="bFile" id="bFile"/>
</form>
<input type="button" value="등록" id="addBtn"/>
<input type="button" value="목록으로" id="listBtn"/>
</body>
</html> 
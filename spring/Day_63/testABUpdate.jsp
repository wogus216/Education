<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정</title>
<style type="text/css">
.off_btn {
	display: none;
}

#att {
	display: none;
}
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
		src="resources/script/ckeditor/ckeditor.js"></script>
<script type="text/javascript" 
		src="resources/script/jquery/jquery.form.js"></script>
<!-- 제이쿼리폼안에 아작스 폼이있다.  -->
<script type="text/javascript">
$(document).ready(function(){
	CKEDITOR.replace("bCon", {
		resize_enabled : false,
		languague : "ko",
		enterMode : "2",
		width : "600",
		height: "300"
	});
	
	$("#fileBtn").on("click",function(){
		$("#att").click();
	});
	
	$("#att").on("change", function(){
		//역슬래시를 문자열로 쓰기위해서는 두개를 사용해야 문자열로 처리된다.
		$("#fileName").html($(this).val().substring($(this).val().lastIndexOf("\\") +1 ));
	});
	
	$("#fileDelBtn").on("click",function(){
		$("#fileName").html("");
		$("#bFile").val("");
		$("#fileBtn").attr("class", "");
		$(this).remove();
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
		var fileForm = $("#fileForm");
		
		fileForm.ajaxForm({
			beforeSubmit: function(){
				$("#bCon").val(CKEDITOR.instances['bCon'].getData());
				//입력된게 없는 경우
				if($.trim($("#bTitle").val()) == ""){
					alert("제목을 입력해주세요");
					$("#bTitle").focus();
					return false; // ajaxForm 실행 불가
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
					// 글 수정
					var params = $("#updateForm").serialize();
					
					$.ajax({
						url: "testABUpdates",
						type: "post",
						dataType: "json",
						data: params,
						success: function(res){
							console.log(res)
						
							if(res.msg == "success"){
								$("#updateForm").attr("action", "testAB");
								$("#updateForm").submit();
							} else if(res.msg == "failed" ){
								alert("작성에 실패하였습니다.");
							} else {
								alert("수정중 에러가 발생하였습니다.");
								
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
		
	}); //update end
}); //ready end
</script>
</head>
<body>
<form id="fileForm" action="fileUploadAjax"
		method="post" enctype="multipart/form-data">
		<input type="file" name="att" id="att"/>
</form>
<form action="#" id="updateForm" method="post">
<input type="hidden" name="page" value="${param.page}"/>
<input type="hidden" name="searchGbn" value="${param.searchGbn}"/>
<input type="hidden" name="searchTxt" value="${param.searchTxt}"/>
<input type="hidden" name="bNo" value="${data.B_NO}"/>
제목<input type="text" id="bTitle" name="bTitle" value="${data.B_TITLE}"/><br/>
작성자: ${data.B_WRITER}<br/>
내용<br/>
<textarea rows="20" cols="50" id="bCon" name="bCon">${data.B_CON}</textarea><br/>
<input type="hidden" id="bFile" name="bFile" value="${data.B_FILE}"/>
첨부파일
<c:choose>
	<c:when test="${!empty data.B_FILE}">
		<input type="button" class="off_btn" value="첨부파일선택" id="fileBtn"/>
	</c:when>
	<c:otherwise>
		<input type="button" value="첨부파일선택" id="fileBtn"/>
	</c:otherwise>
</c:choose>
<span id="fileName">${data.B_UFILE}</span>
<c:if test="${!empty data.B_FILE}">
	<input type="button" value="파일삭제" id="fileDelBtn"/>
</c:if>
</form>
<input type="button" value="수정" id="updateBtn"/>
<input type="button" value="뒤로가기" id="backBtn"/>
</body>
</html>
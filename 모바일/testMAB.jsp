<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, inital-scale=1.0,
								maximum-scale=1.0, user-scalable=no" />
<title>모바일 상세보기</title>
<style type="text/css">
.con{
	width: 100%;
	overflow-x: auto;
}
input[type=button]{
	background-color: #ffd699;
	border-radius: 8px;
	border: none;
	
}
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#listBtn").on("click", function(){
		$("#goForm").attr("action", "testMABList");
		$("#goForm").submit();
	});
	//수정페이지는 상세보기 와 글쓰기 할줄 알면 가능
	$("#updateBtn").on("click",function(){
		$("#goForm").attr("action", "testMABUpdate");
		$("#goForm").submit();
	}); //up Btn end
	
	$("#deleteBtn").on("click", function(){
		if(confirm("삭제하시겠습니까?")){
			var params = $("#goForm").serialize();
			
			$.ajax({
				url: "testMABDeletes",
				type: "post",
				dataType: "json",
				data: params,
				success: function(res){
					console.log(res)
				
					if(res.msg == "success"){
						location.href="testMABList"
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
	내용
	<div class="con">
		${data.B_CON}
	</div>
<c:if test="${!empty data.B_FILE}">
첨부파일: <!-- a의 download : 해당 주소를 다운로드 하겠다. 값이 있는 경우 해당이름으로 다운 받겠다. --> 
<a href="resources/upload/${data.B_FILE}" download="${data.B_FILE}">
${data.B_FILE}
</a>
</c:if>
<input type="button" value="수정" id="updateBtn"/>
<input type="button" value="삭제" id="deleteBtn"/>
<input type="button" value="목록으로" id="listBtn"/>
</body>
</html> 
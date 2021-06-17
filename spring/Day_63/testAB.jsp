<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%> 
<!-- ELTag 확장기능 -->
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%> 
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
		$("#goForm").attr("action", "testABList");
		$("#goForm").submit();
	});
	//수정페이지는 상세보기 와 글쓰기 할줄 알면 가능
	$("#updateBtn").on("click",function(){
		$("#goForm").attr("action", "testABUpdate");
		$("#goForm").submit();
	}); //up Btn end
	
	$("#deleteBtn").on("click", function(){
		if(confirm("삭제하시겠습니까?")){
			var params = $("#goForm").serialize();
			
			$.ajax({
				url: "testABDeletes",
				type: "post",
				dataType: "json",
				data: params,
				success: function(res){
					console.log(res)
				
					if(res.msg == "success"){
						location.href="testABList"
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
내용<br/>
${data.B_CON}<br/>
<c:if test="${!empty data.B_FILE}">
<!-- set: 변수 -->
<c:set var="len" value="${fn:length(data.B_FILE)}"></c:set>
첨부파일: <!-- a의 download : 해당 주소를 다운로드 하겠다. 값이 있는 경우 해당이름으로 다운 받겠다. --> 
<a href="resources/upload/${data.B_FILE}" download="${fn:substring(data.B_FILE,20,len)}">
 ${fn:substring(data.B_FILE,20,len)}</a><br/>
</c:if>
<input type="button" value="수정" id="updateBtn"/>
<input type="button" value="삭제" id="deleteBtn"/>
<input type="button" value="목록으로" id="listBtn"/>
</body>
</html> 
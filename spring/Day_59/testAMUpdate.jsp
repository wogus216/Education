<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#backBtn").on("click",function(){
		history.back();
	});
	
	$("#updateBtn").on("Keypress","input",function(){
		if(event.keyCode == 13){
			return false;
		}
	});
	
	$("#updateBtn").on("click",function(){
		if($.trim($("#mId").val())  == ""){
			alert("아이디를 입력해주세요");
			$("#mId").focus();
		} else if($.trim($("#mBr").val())  == ""){
			alert("생일을 입력해주세요");
			$("#mBr").focus();
		} else{
			var params = $("#updateForm").serialize();
			
			$.ajax({
				url: "testAMUpdates",
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
		}
	});
	
});//ready end
</script>
</head>
<body>
<form action="#" id="updateForm" method="post">
<input type="hidden" name="page" value="${param.page}"/> 
<input type="hidden" name="searchGbn" value="${param.searchGbn}"/> 
<input type="hidden" name="searchTxt" value="${param.searchTxt}"/> 
<input type="hidden" name="mNo" value="${data.M_NO}"/>
회원번호: ${data.M_NO} <br/>
아이디: ${data.M_ID} <br/>
이름<input type="text" id="mNm" name="mNm" value="${data.M_NM}"/><br/>
생일<input type="date" id="mBd" name="mBd" value="${data.BD}"/><br/>
가입일: ${data.DT}<br/>
</form>
<input type="button" value="수정" id="updateBtn"/> 
<input type="button" value="뒤로가기" id="backBtn"/> 
</body>
</html>
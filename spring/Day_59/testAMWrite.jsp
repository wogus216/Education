<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원등록</title>
<style type="text/css">
#addForm input{
	margin-bottom: 10px;
}
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#listBtn").on("click",function(){
		$("#goForm").submit();
	}); // list end
	
	$("#addBtn").on("click",function(){
		//입력된게 없는 경우
		if($.trim($("#mId").val()) == ""){
			alert("아이디를 입력해주세요");
			$("#mId").focus;
		} else if($.trim($("#mPw").val()) ==""){
			alert("비밀번호를 입력해주세요");
			$("#mPw").focus;
		} else if($.trim($("#mPwRe").val()) != $.trim($("#mPw").val())){
			alert("비밀번호가 일치하지 않습니다.");
			$("#mPwRe").focus;
		} else if($.trim($("#mNm").val()) ==""){
			alert("이름 입력해주세요");
			$("#mNm").focus;
		} else if($.trim($("#mBr").val()) ==""){
			alert("생일을 입력해주세요");
			$("#mBr").focus;
		} else{
			var params =$("#addForm").serialize();
			$.ajax({
				url: "testAMWrites",
				type: "post",
				dataType: "json",
				data: params,
				success: function(res){
					console.log(res)
					console.log(params)
					if(res.msg == "success"){
						location.href = "testAMList";
					} else if(res.msg == "failed"){
						alert("등록에 실패하셨습니다.");
					} else {
						alert("에러발생.");
					}
				},
				error: function(request, status, error){
					console.log(error);
				}
			});
		}
	}); // add end
}); //ready end
</script>
</head>
<body>
<form action="testAMList" id="goForm" method="post"> 
	<input type="hidden" name="page" value="${param.page}"/> 
	<input type="hidden" name="searchGbn" value="${param.searchGbn}"/> 
	<input type="hidden" name="searchTxt"	value="${param.searchTxt}"/> 
</form>
<form action="#" id="addForm" method="post" >
아이디<input type="text" id="mId" name="mId"/><br/>
비밀번호<input type="password" id="mPw" name="mPw"/><br/>
비밀번호확인<input type="password" id="mPwRe" name="mPwRe"/><br/>
이름<input type="text" id="mNm" name="mNm"/><br/>
생일<input type="date" id="mBr" name="mBr"/>
</form>
<input type="button" value="등록" id="addBtn"/>
<input type="button" value="목록으로" id="listBtn"/>
</body>
</html> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매물품등록</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#listBtn").on("click",function(){
		$("#goForm").submit();
	});
	
	$("#addBtn").on("click",function(){
		if($.trim($("#sNm").val()) == ""){
			alert("아이템이름을 입력해주세요");ㅣ
			$("#sNm").focus();
		} else if($.trim($("#sNb").val()) == ""){
			alert("판매수량을 입력해주세요");
			$("#sNb").focus();
		}	else if($.trim($("#sDt").val()) == ""){
			alert("날짜를 입력해주세요");
			$("#sDt").focus();
		} else{
			var params = $("#addForm").serialize();
			$.ajax({
				url: "testSEAdds",
				type: "post",
				dataType: "json",
				data: params,
				success: function(res){
					console.log(res);
					if(res.msg == "success"){
						location.href = "testSEList";
					} else if(res.msg == "failed"){
						alert("등록에 실패하셨습니다.");
					} else{
						alert("에러 발생")
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
<form action="testSEList" id="goForm" method="post">
	<input type="hidden" name="page" value="${param.page}"/> 
	<input type="hidden" name="searchGbn" value="${param.searchGbn}"/> 
	<input type="hidden" name="searchTxt"	value="${param.searchTxt}"/> 
</form>
<form action="#" id="addForm" method="post">
아이템이름<input type="text" id="sNm" name="sNm"/><br/>
판매수량<input type="number" id="sNb" name="sNb"/><br/>
판매날짜<input type="date" id="sDt" name="sDt"/><br/>
</form>
<input type="button" value="등록" id="addBtn"/>
<input type="button" value="목록으로" id="listBtn"/>
</body>
</html>
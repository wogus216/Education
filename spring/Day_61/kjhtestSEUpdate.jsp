<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>     
<!DOCTYPE html>
<html>
<head>
<title>수정</title>
<meta charset="UTF-8">
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#backBtn").on("click",function(){
		history.back();
	});
	
	$("#updateBtn").on("Keypress","input",function(){
		if(event.KeyCode == 13){
			return false;
		}
	}); 
	
	$("#updateBtn").on("click",function(){
		if($.trim($("#sNm").val()) == ""){
			alert("물품명을 입력해주세요");
			$("#sNm").focus();
		}else if($.trim($("#sNb").val()) == ""){
			alert("판매수량을 입력해주세요");
			$("#sNb").focus();
		} else if($.trim($("#sDt").val()) == ""){
			alert("판매날짜를 입력해주세요");
			$("#sDt").focus();
		} else{
			var params = $("#updateForm").serialize();
			
			$.ajax({
				url: "kjhtestASEUpdates",
				type: "post",
				dataType: "json",
				data: params,
				success: function(res){
					console.log(res)
					if(res.msg == "success"){
						$("#updateForm").attr("action","kjhtestSEDetail");
						$("#updateForm").submit();
					} else if(res.msg == "failed" ){
						alert("작성에 실패하였습니다.");
					} else {
						alert("수정 중 에러가 발생하였습니다.");
					}	
				},
				error: function(request, status, error){
						console.log(error);
				}
			});
		}
	});
}); //ready end
</script>
</head>
<body>
<form action="#" id="updateForm" method="post">
<input type="hidden" name="page" value="${param.page}"/> 
<input type="hidden" name="searchGbn" value="${param.searchGbn}"/> 
<input type="hidden" name="searchTxt" value="${param.searchTxt}"/> 
<input type="hidden" name="sNo" value="${data.SELL_NO}"/>
판매번호: ${data.SELL_NO}<br/>
물품명<input type="text" id="sNm" name="sNm" value="${data.ITEM_NAME}"/><br/>
판매수량<input type="number" id="sNb" name="sNb" value="${data.COUNT}"/><br/>
판매날짜<input type="date" id="sDt" name="sDt" value="${data.SELL_DT}"/><br/>
</form>
<input type="button" value="수정" id="updateBtn"/> 
<input type="button" value="뒤로가기" id="backBtn"/> 
</body>
</html>
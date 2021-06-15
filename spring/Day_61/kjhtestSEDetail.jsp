<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세보기</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#listBtn").on("click",function(){
		$("#sendForm").attr("action", "kjhtestSEList");
		$("#sendForm").submit();
	}); //list end
	
	$("#updateBtn").on("click",function(){
		$("#sendForm").attr("action", "kjhtestSEUpdate");
		$("#sendForm").submit();
	}); //update end
	
	$("#deleteBtn").on("click",function(){
		if(confirm("삭제하시겠습니까?")){
			var params = $("#sendForm").serialize();
			
			$.ajax({
				url: "kjhtestSEDeletes",
				type: "post",
				dataType: "json",
				data: params,
				success: function(res){
					console.log(res)
					
					if(res.msg == "success"){
						location.href = "kjhtestSEList"						
					} else if(res.msg == "failed"){
						
					
						alert("작성에 실패하였습니다.");
					} else{
						alert("에러가 발생하였습니다.")
					}
				},
				error: function(request, status, error){
						console.log(error)
				}
			});
		}
	}); //delete end
	
}); //ready end
</script>
</head>
<body>
<form action="#" id="sendForm" method="post">
	<input type="hidden" name="sNo" value="${data.SELL_NO}"/>
	<input type="hidden" name="page" value="${param.page}"/>
	<input type="hidden" name="searchGbn" value="${param.searchGbn}"/>
	<input type="hidden" name="searchTxt" value="${param.searchTxt}"/>
</form>
판매번호 : ${data.SELL_NO}<br/>
물품명 : ${data.ITEM_NAME}<br/>
판매수량 : ${data.COUNT}<br/>
판매날짜 : ${data.SELL_DT}<br/>
<input type="button" value="수정" id="updateBtn"/>
<input type="button" value="삭제" id="deleteBtn"/>
<input type="button" value="목록으로" id="listBtn"/>
</body>
</html>
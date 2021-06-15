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
아이템이름 : ${data.ITEM_NAME}<br/>
판매수량 : ${data.COUNT}<br/>
판매날짜 : ${data.SELL_DT}<br/>
</body>
</html>
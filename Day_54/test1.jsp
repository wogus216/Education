<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
thead{
	background-color: orange;
}
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js">
</script>
<script type="text/javascript">
$(document).ready(function(){
	$("tbody").on("click", "tr", function(){
		$("#bNo").val($(this).attr("name")); //여기서 this는 클릭한 tr
		$("#goForm").submit();
	}); //tbody end
	
	$("#addBtn").on("click", function(){
		location.href = "test3";
	});//addBtn end
	
	$("#searchBtn").on("click",function(){
		$("#searchForm").submit();
	});
}); //ready end
</script>
</head>
<body>
<form action="test2" id="goForm" method="post">
	<input type="hidden" id="bNo" name="bNo"/>
</form>
<form action="test1" id="searchForm" method="post">
<input type="hidden" id="page" name="page" value="${page}"/>
<select name="searchGbn">
	<c:choose>
		<c:when test="${param.searchGbn eq 0 }">
			<option value="0" selected="selected">제목</option>
		</c:when>
		<c:otherwise>
			<option value="0">제목</option>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${param.searchGbn eq 1 }">
			<option value="1" selected="selected">작성자</option>
		</c:when>
		<c:otherwise>
			<option value="1">작성자</option>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${param.searchGbn eq 2 }">
			<option value="2" selected="selected">글번호</option>
		</c:when>
		<c:otherwise>
			<option value="2">글번호</option>
		</c:otherwise>
	</c:choose>
	</select>
<input type="text" name="searchTxt" value="${param.searchTxt}"/>
<input type="button" value="검색" id="searchBtn"/>
<input type="button" value="작성" id="addBtn"/>
</form>
<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="data" items="${list}">
			<tr name="${data.B_NO}">
				<td>${data.B_NO}</td>
				<td>${data.B_TITLE}</td>
				<td>${data.B_WRITER}</td>
				<td>${data.B_DT}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</body>
</html>
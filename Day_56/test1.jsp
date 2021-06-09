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
		$("#page").val(1);
		$("#searchForm").submit();
	});
	
	$("#pagingWrap").on("click", "span", function(){
		$("#page").val($(this).attr("name"));
		$("#searchForm").submit();
	}); 
	
	
}); //ready end
</script>
</head>
<body>
<form action="test2" id="goForm" method="post">
	<input type="hidden" id="bNo" name="bNo"/>
	<input type="hidden" name="page" value="${page}"/>
	<input type="hidden" name="searchGbn" value="${param.searchGbn}"/>
	<input type="hidden" name="searchTxt" value="${param.searchTxt}"/>
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
<div id="pagingWrap">
<span name="1">처음</span>
<!-- 이전페이지 -->
<c:choose>
	<c:when test="${page eq 1}">
	<span id="gsg" name="1">이전</span>
	</c:when>
	<c:otherwise>
	<span name="${page-1}">이전</span>
	</c:otherwise>
</c:choose>
<!-- 페이지들  -->
<c:forEach var="i" begin="${pb.startPcount}" end="${pb.endPcount}" step="1">
		<!-- 현재 페이지인 경우 볼드 처리 -->
	<c:choose>
		<c:when test="${i eq page}">
				<span name="${i}"><b>${i}</b></span>
		</c:when>
		<c:otherwise>
			<span name="${i}">${i}</span>
		</c:otherwise>
	</c:choose>
</c:forEach>
<!-- 다음페이지  -->
<c:choose>
	<c:when test="${page eq pb.maxPcount}">
		<span name="${pb.maxPcount}">다음</span>
	</c:when>
	<c:otherwise>
		<span name="${page + 1}">다음</span>
	</c:otherwise>
</c:choose>
<span name="${pb.maxPcount}">마지막</span>
</div>
</body>
</html>
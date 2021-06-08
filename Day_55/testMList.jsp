<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("tbody").on("click", "tr", function(){
		$("#mNo").val($(this).attr("name"));
		$("#goForm").submit();
	}); // tbody end
	
	$("#addBtn").on("click",function(){
		location.href = "testMAdd";
	}); // addBtn end
	
	$("#searchBtn").on("click",function(){
		$("#page").val(1);
		$("#searchForm").submit();
	}); //search end
	
	$("#pagingWrap").on("click","span",function(){
		$("#page").val($(this).attr("name"));
		$("#searchForm").submit();
	}); //pagingWrap end
	
	//스크립트은 사용자에게 보여진다. 코어태그는 사용자가 확인이 어려움 
	if("${param.searchGbn}" !="") {
		$("#searchGbn").val("${param.searchGbn}");
	}
	
}); //ready end
</script>
</head>
<body>
<form action="testMDetail" id="goForm" method="post">
	<input type="hidden" id="mNo" name="mNo"/>
</form>
<form action="testMList" id="searchForm" method="post">
<input type="hidden" id="page" name="page" value="${page}">
<!--name은 컨트롤러에 넘겨 줄 때 키값 -->
<select name="searchGbn" id="searchGbn"> 
		<option value="0">회원번호</option>
		<option value="1">아이디</option>
		<option value="2">이름</option>
</select>
<input type="text" name="searchTxt" value="${param.searchTxt}">
<input type="button" value="검색" id="searchBtn"/>
<input type="button" value="작성" id="addBtn"/>
</form>
<table id="mTable">
	<thead>
		<tr>
			<th>회원번호</th>
			<th>아이디</th>
			<th>비밀번호</th>
			<th>이름</th>
			<th>생년월일</th>
			<th>가입일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="data" items="${list1}">
			<tr name="${data.M_NO}">
				<td>${data.M_NO}</td>
				<td>${data.M_ID}</td>
				<td>${data.M_PW}</td>
				<td>${data.M_NM}</td>
				<td>${data.M_BIRTH}</td>
				<td>${data.M_JOINDT}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div id="pagingWrap">
<span name="1">처음</span>
<!-- 이전 페이지 -->
<c:choose>
	<c:when test="${page eq 1}">
		<span name="1">이전</span>
	</c:when>
	<c:otherwise>
		<span name="${page-1}">이전</span>
	</c:otherwise>
</c:choose>
<!-- 페이지들 -->
<c:forEach var="i" begin="${pb.startPcount}" end="${pb.endPcount}" step="1">
	<!-- 현재페이지인 경우 볼드 처리 -->
	<c:choose>
		<c:when test="${i eq page}">
			<span name="${i}"><b>${i}</b></span>
		</c:when>
		<c:otherwise>
			<span name="${i}">${i}</span>
		</c:otherwise>
	</c:choose>
</c:forEach>
<!-- 다음페이지 -->
<c:choose>
	<c:when test="${page eq pb.maxPcount}">
				<span name="${pb.maxPcount}"><b>다음</b></span>
	</c:when>
	<c:otherwise>
			<span name="${page +1}">다음</span>
	</c:otherwise>
</c:choose>
<!-- 마지막 페이지 -->
<span name="${pb.maxPcount}">마지막</span>
</div>
</body>
</html>
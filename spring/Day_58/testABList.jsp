<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.list_wrap table{
	border-collapse: collapse;
}

.list_wrap thead tr {
	border-top: 1px solid #000;
	border-bottom: 1px solid #000;
	background-color: orange;
	height: 30px;
}

.list_wrap tbody tr{
	border-bottom: 1px solid #000;
	height: 25px;
	text-align: center;
	cursor: pointer;
}


.list_wrap tbody tr td:nth-child(2){
	text-align: left;
}

.list_wrap tbody tr:nth-child(2n){
	background-color: #FFCCAA;
}

.list_wrap tbody tr:hover, .lsit wrap tbody tr:nth-child(2n):hover{
	background-color: blue;
	color: white;
}
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js">
</script>
<script type="text/javascript">
$(document).ready(function(){
	$("#loginBtn").on("click",function(){
		location.href = "testALogin";
	});
	$("#logoutBtn").on("click",function(){
		location.href = "testALogout";
	});
});
</script>
</head>
<body>
<c:choose>
	<c:when test="${empty  sMNo}">
		<input type="button" value="로그인" id="loginBtn"/> 
	</c:when>
	<c:otherwise>
		${sMNm}님 어서오세요.<input type="button" value="로그아웃" id="logoutBtn"/>	
	</c:otherwise>
</c:choose>
<div class="search_area">
	<form action="#" id="actionForm" method="post">
		<input type="hidden" id="page" name="page" value="${page}"/>
		<input type="hidden" id="searchGbn" name="searchGbn" value="${param.searchGbn}"/>
		<input type="hidden" id="searchTxt" name="searchTxt" value="${param.searchTxt}"/>
		<select id="searchGbn" name="searchGbn">
			<option value="0">제목</option>
			<option value="1">작성자</option>
		</select>
		<input type="text" name="searchTxt" value="${param.searchTxt}"/>
		<input type="button" value="검색" id="searchBtn"/>
		<input type="button" value="작성" id="writeBtn"/>
	</form>
</div>
<div class="list_wrap">
	<table>
		<colgroup>
			<col width="100px" />
			<col width="400px" />
			<col width="200px" />
			<col width="100px" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>aaa</td>
				<td>aaa</td>
				<td>aaa</td>
				<td>aaa</td>
			</tr>
			<tr>
				<td>aaa</td>
				<td>aaa</td>
				<td>aaa</td>
				<td>aaa</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="list_wrap">

</div>
</body>
</html>
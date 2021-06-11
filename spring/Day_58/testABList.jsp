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
.paing_wrap{
	margin-top: 10px;
}

.paging_wrap div{
	display:inline-block;
	padding: 5px;
	margin-left: 3px;
	margin-right: 3px;
	border: 1px solid #444;
	border-radius: 3px;
	width: 60px;
	cursor: pointer;
	text-align: center;
}
.paging_wrap div:active, #searchBtn:hover,#writeBtn:active{
	background-color: aqua;
	
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

function reloadList() {
	var params = $("#actionForm").serialize();
	
	//ajax
	$.ajax({
		url: "testABLists", 
		type: "post", 
		dataType: "json",
		data : params, 
		success : function(res) {
			console.log(res);
			drawList(res.list);
			drawPaging(res.pb);
		},
		error: function(request, status, error){ 
			console.log(error);
		}
	
	});
}
// 목록 그리기
function drawList(list){
	var html = "";
	//" +  + " : 문자열 넣는 꿀팁
	for(var d of list){
		html += "<tr bno=\"" + d.B_NO + "\">";
		html += "<td>" +  d.B_NO + "</td> ";
		html += "<td>" +  d.B_TITLE + "</td> ";
		html += "<td>" +  d.B_WRITER + "</td> ";
		html += "<td>" +  d.B_DT + "</td> ";
		html += "</tr>";
	}
	
	$(".list_wrap body").html(html);
}
// 페이징 그리기
function drawPaging(pb){
	var html = "";
	
	html += <div page=\"1\">처음</div>";
	
	if($("#page").val() =="1") {
		html += <div page=\"1\">이전</div>";
	} else{
		
	}
	html += <div page=\"1\">1</div>";
	html += <div page=\"1\">다음</div>";
	html += <div page=\"1\">마지막</div>";
	
}
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
<div class="paging_wrap">
	<div page="1">처음</div>
	<div page="1">이전</div>
	<div page="1">1</div>
	<div page="1">다음</div>
	<div page="1">마지막</div>
</div> 
</body>
</html>
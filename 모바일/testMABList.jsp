<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, inital-scale=1.0,
								maximum-scale=1.0, user-scalable=no" />
<title>게시판 모바일 버전</title>
<style type="text/css">
body{
	margin: 0px;
	font-size: 3vw;
}

.search_area{
	height: 6vh;
	line-height: 6vh;
	margin: 5px;
	text-align: center;
}
.list_wrap table{
	border-collapse: collapse;
	width: 100%;
}
.list_wrap thead tr {
	border-top: 1px solid #000;
	border-bottom: 1px solid #000;
	background-color: orange;
	height: 6vh;
}
.list_wrap tbody tr{
	border-bottom: 1px solid #000;
	height: 6vh;
	text-align: center;
	cursor: pointer;
}

.list_wrap td:nth-child(1), .list_wrap th:nth-child(1){
	width: 15%;
} 
.list_wrap td:nth-child(2), .list_wrap th:nth-child(2){
	width: 45%;
} 
.list_wrap td:nth-child(3), .list_wrap th:nth-child(3){
	width: 20%;
} 
.list_wrap td:nth-child(4), .list_wrap th:nth-child(4){
	width: 20%;
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

.list_wrap tbody img{
	width: 15px;
}
.paging_wrap{
	margin-top: 10px;
	text-align: center;
}
.paging_wrap div{
	display:inline-block;
	padding: 5px;
	margin-left: 3px;
	margin-right: 3px;
	border: 1px solid #444;
	border-radius: 3px;
	width: 10vw;
	cursor: pointer;
	text-align: center;
}
.paging_wrap div:active, #searchBtn:hover,#writeBtn:active{
	background-color: #ffd699;
}
.paging_wrap .on{
	background-color: #ffd699;
}
#searchBtn, #writeBtn{
	background-color: white;
    border-left: none;
    border-right: none;
    border-color: #ffd699;
}
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js">
</script>
<script type="text/javascript">
$(document).ready(function(){
	if("${param.searchGbn}" != ""){
		$("#searchGbn").val("${param.searchGbn}");
	}
	
	reloadList();
	
	$("#searchBtn").on("click", function(){
		$("#page").val(1);
		$("#searchOldTxt").val($("#searchTxt").val());
		reloadList();
	});
	
	$(".paging_wrap").on("click","div",function(){
		$("#page").val($(this).attr("page"));
		reloadList();
	});
	
	$("#writeBtn").on("click",function(){
		$("#actionForm").attr("action", "testMABWrite");
		$("#searchTxt").val($("#searchOldTxt").val());
		$("#actionForm").submit();
	}); //write end
	
	$(".list_wrap tbody").on("click","tr",function(){
		/*  속성명 bno */
		$("#bNo").val($(this).attr("bno"));
		
		$("#actionForm").attr("action", "testMAB");
		$("#actionForm").submit();
	});
}); //ready end
 
function reloadList() {
	var params = $("#actionForm").serialize();
	
	//ajax
	$.ajax({
		url: "testMABLists", 
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
		html += "<td>" +  d.B_TITLE;
		
		if(d.B_FILE != null){
			html += "<img src =\"resources/images/attFile.png\" alt=\"첨부파일\"/>";
		}
		html +="</td> ";
		html += "<td>" +  d.B_WRITER + "</td> ";
		html += "<td>" +  d.B_DT + "</td> ";
		html += "</tr>";
	}
	//비동기시 항상 고정으로 뜨는 친구에게 이벤트 걸어야한다 필수
	$(".list_wrap tbody").html(html);
}
// 페이징 그리기
function drawPaging(pb){
	var html = "";
//	" + + "
	
	if($("#page").val() =="1") {
		html += "<div page=\"1\">이전</div>";
	} else{
		html += "<div page=\"" + ($("#page").val() - 1)  + "\">이전</div>";
	}

			html +="<div class=\"on\" page=\"" + $("#page").val() + "\">" + $("#page").val() + "</div>";
	
	if($("#page").val() == pb.maxPcount){
		html += "<div page=\"" + pb.maxPcount + "\">다음</div>";
	} else{
		html += "<div page=\"" + ($("#page").val() * 1 + 1)+ "\">다음</div>";
		
	}
	
	$(".paging_wrap").html(html);
}
</script>
</head>
<body>
<div class="search_area">
	<form action="#" id="actionForm" method="post">
		<input type="hidden" id="bNo" name="bNo"/>
		<input type="hidden" id="page" name="page" value="${page}"/>
		<input type="hidden" id=searchOldTxt name="searchOldTxt"/>
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
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>
</div>

<div class="paging_wrap"></div> 
</body>
</html> 
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

.list_wrap tbody img{
	width: 15px;
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
.paging_wrap .on{
	background-color: red;
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
	
	$("#loginBtn").on("click",function(){
		location.href = "testALogin";
	});
	$("#logoutBtn").on("click",function(){
		location.href = "testALogout";
	});
	
	$("#searchBtn").on("click", function(){
		$("#page").val(1);
		reloadList();
	});
	
	$(".paging_wrap").on("click","div",function(){
		$("#page").val($(this).attr("page"));
		reloadList();
	});
	
	$("#writeBtn").on("click",function(){
		$("#actionForm").attr("action", "testABWrite");
		$("#actionForm").submit();
	}); //write end
	
	$(".list_wrap tbody").on("click","tr",function(){
		/*  ????????? bno */
		$("#bNo").val($(this).attr("bno"));
		
		$("#actionForm").attr("action", "testAB");
		$("#actionForm").submit();
	});
}); //ready end
 
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
// ?????? ?????????
function drawList(list){
	var html = "";
	//" +  + " : ????????? ?????? ??????
	for(var d of list){
		html += "<tr bno=\"" + d.B_NO + "\">";
		html += "<td>" +  d.B_NO + "</td> ";
		html += "<td>" +  d.B_TITLE;
		
		if(d.B_FILE != null){
			html += "<img src =\"resources/images/attFile.png\" alt=\"????????????\"/>";
		}
		html +="</td> ";
		html += "<td>" +  d.B_WRITER + "</td> ";
		html += "<td>" +  d.B_DT + "</td> ";
		html += "</tr>";
	}
	//???????????? ?????? ???????????? ?????? ???????????? ????????? ??????????????? ??????
	$(".list_wrap tbody").html(html);
}
// ????????? ?????????
function drawPaging(pb){
	var html = "";
//	" + + "
	html += "<div page=\"1\">??????</div>";
	
	if($("#page").val() =="1") {
		html += "<div page=\"1\">??????</div>";
	} else{
		html += "<div page=\"" + ($("#page").val() - 1)  + "\">??????</div>";
	}
	for(var i = pb.startPcount ; i <= pb.endPcount ; i++){
		if($("#page").val() == i){
			html +="<div class=\"on\" page=\"" + i + "\">" + i + "</div>";
		}else{
			html +=	"<div page=\"" + i + "\">" + i + "</div>";
		}
	}
	
	if($("#page").val() == pb.maxPcount){
		html += "<div page=\"" + pb.maxPcount + "\">??????</div>";
	} else{
		html += "<div page=\"" + ($("#page").val() * 1 + 1)+ "\">??????</div>";
		
	}
	html += "<div page=\"" + pb.maxPcount + "\">?????????</div>";
	
	$(".paging_wrap").html(html);
}
</script>
</head>
<body>
<c:choose>
	<c:when test="${empty  sMNo}">
		<input type="button" value="?????????" id="loginBtn"/> 
	</c:when>
	<c:otherwise>
		${sMNm}??? ???????????????.<input type="button" value="????????????" id="logoutBtn"/>	
	</c:otherwise>
</c:choose>
<div class="search_area">
	<form action="#" id="actionForm" method="post">
		<input type="hidden" id="bNo" name="bNo"/>
		<input type="hidden" id="page" name="page" value="${page}"/>
		<select id="searchGbn" name="searchGbn">
			<option value="0">??????</option>
			<option value="1">?????????</option>
		</select>
		<input type="text" name="searchTxt" value="${param.searchTxt}"/>
		<input type="button" value="??????" id="searchBtn"/>
		<input type="button" value="??????" id="writeBtn"/>
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
				<th>??????</th>
				<th>??????</th>
				<th>?????????</th>
				<th>?????????</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>
</div>

<div class="paging_wrap"></div> 
</body>
</html> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>목록</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	if("${param.searchGbn}" != ""){
		$("#searchGbn").val("${param.searchGbn}");
	}
	
	reloadList();
	
	$("#searchBtn").on("click",function(){
		$("#page").val(1);
		reloadList();
	});
	
	$(".paging_wrap").on("click","span",function(){
		$("#page").val($(this).attr("page"));
		$("#searchTxt").val($("#searchOldTxt").val());
		reloadList();
	});
	
	$("#writeBtn").on("click",function(){
		$("#actionForm").attr("action","kjhtestSEAdd")
		$("#actionForm").submit();
	});
	
	//상세보기
	$("tbody").on("click","tr",function(){
		$("#sNo").val($(this).attr("sno"));
		
		$("#actionForm").attr("action","kjhtestSEDetail")
		$("#actionForm").submit();
	});
}); //ready end


function reloadList(){
	var params = $("#actionForm").serialize();
	
	//ajax
	$.ajax({
		url: "kjhtestSELists",
		type: "post",
		dataType: "json",
		data: params,
		success : function(res){
			console.log(res);
			drawList(res.list);
			drawPaging(res.pb);
		},
		error: function(request, status, error){
			console.log(error);
			
			
		}
	});
} // reload end

//목록 그리기
function drawList(list){
	var html = "";
	
	// " + + "
	for(var d of list){                
	html += "<tr sno=\"" + d.SELL_NO + "\">";
	html +=	"<td>" + d.SELL_NO + "</td>";
	html +=	"<td>" + d.ITEM_NAME  + "</td>";
	html +=	"<td>" + d.COUNT + "</td>";
	html +=	"<td>" + d.DT + "</td>";
	html +=	"</tr>";
	}
	$("tbody").html(html);
}

function drawPaging(pb){
	
	var html = "";
	
	html += "<span page=\"1\">처음</span>";
	
	if($("#page").val() == "1"){
		html += "<span page=\"1\">이전</span>";
	} else{
		html += "<span page=\""+($("#page").val() -1) +"\">이전</span>";
	}
	
	for(var i =pb.startPcount ; i <= pb.endPcount ; i++){
		if($("#page").val() == i){
			html += "<span class=\"on\" page=\"" + i + "\"><b>" + i +  "</b></span>";
		} else{
			html +=	"<span page=\"" + i + "\">" + i + "</span>";
		}
	}
		
		if($("#page").val() == pb.maxPcount){
			html += "<span page=\"" + pb.maxPcount + "\">다음</span>";
		} else{
			html += "<span page=\"" + ($("#page").val() * 1 + 1)+ "\">다음</span>";
			
		}
		html += "<span page=\"" + pb.maxPcount + "\">마지막</span>";
		
		$(".paging_wrap").html(html);
}
</script>
</head>
<body>
<div class="search_area">
<form action="#" id="actionForm" method="post">
	<input type="hidden" id="sNo" name="sNo"/>
	<input type="hidden" id="page" name="page" value="${page}"/>
	<input type="hidden" id="searchOldTxt" name="searchOldTxt" value="${param.searchTxt}"/>
	<select id="searchGbn" name="searchGbn">
		<option value="0">물품명</option>
		<option value="1">판매수량</option>
	</select>
	<input type="text" name="searchTxt" value="${param.searchTxt}"/>
	<input type="button" value="검색 " id="searchBtn"/>
	<input type="button" value="작성 " id="writeBtn"/>
</form>
</div>
<div class="list_wrap">
	<table>
		<colgroup>
			<col width="100px"/>
			<col width="100px"/>
			<col width="100px"/>
			<col width="100px"/>
		</colgroup>
		<thead>
			<tr>
				<th>판매번호</th>
				<th>물품명</th>
				<th>판매수량</th>
				<th>판매날짜</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>
</div>
<div class="paging_wrap">

</div>
</body>
</html>
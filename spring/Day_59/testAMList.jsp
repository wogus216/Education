<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>목록</title>
<style type="text/css">


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
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js">
</script>
<script type="text/javascript">
$(document).ready(function(){
	
	reloadList();
	
	$("#loginBtn").on("click",function(){
		location.href = "testAMLogin";	
	}); //loginBtn end
	
	$("#logoutBtn").on("click",function(){
		location.href = "testAMLogout";	
	}); //loginBtn end
	
	$("#searchBtn").on("click", function(){
		$("#page").val(1);
		reloadList();
	});
	
	$(".paging_wrap").on("click","div",function(){
		$("#page").val($(this).attr("page"));
		reloadList();
	});
	
	//작성
	$("#writeBtn").on("click",function(){
		
		$("#actionForm").attr("action","testAMWrite");
		$("#actionForm").submit();
	});
}); //ready end

//목록 소환
function reloadList(){
	var params = $("#actionForm").serialize();

	//ajax
	$.ajax({
		url: "testAMLists",
		type: "post",
		dataType: "json",
		data : params, 
		success: function(res){
			console.log(res);
			drawList(res.list);
			drawPaging(res.pb);
		},
		error : function(request, status, error){
			console.log(error);
		}
	});

}


//목록 그리기
function drawList(list){
	var html= "";
	" +  + "
	for(var d of list){
	html += "<tr mno=\"" + d.M_NO + "\">";
	html += "<td>" + d.M_NO +"</td>";
	html += "<td>" + d.M_ID + "</td>";
	html += "<td>" + d.M_NM + "</td>";
	html +=  "<td>" + d.BIRTH + "</td>";
	html +=  "<td>" + d.DT + "</td>";
	html +=  "</tr>";
	}
	//비동기시 항상 고정으로 뜨는 친구에게 이벤트 걸어야한다 필수
	$(".list_wrap tbody").html(html);
}
//페이징 그리기
function drawPaging(pb){
	var html = "";
	
	
	html += "<div page=\"1\">처음</div>";
	
	if($("#page").val() == "1"){
		html += "<div page=\"1\">이전</div>";
	} else{
		html += "<div page=\""+($("#page").val() -1) +"\">이전</div>";
	}
	for(var i =pb.startPcount ; i <= pb.endPcount ; i++){
		if($("#page").val() == i){
			html += "<div class=\"on\" page=\"" + i + "\">" + i + "</div>";
		} else{
			html +=	"<div page=\"" + i + "\">" + i + "</div>";
		}
	}
		
		if($("#page").val() == pb.maxPcount){
			html += "<div page=\"" + pb.maxPcount + "\">다음</div>";
		} else{
			html += "<div page=\"" + ($("#page").val() * 1 + 1)+ "\">다음</div>";
			
		}
		html += "<div page=\"" + pb.maxPcount + "\">마지막</div>";
		
		$(".paging_wrap").html(html);
	
}
</script>
</head>
<body>
<c:choose>
	<c:when test="${empty sMNo}">
		<input type="button" value="로그인" id="loginBtn"/>
	</c:when>
	<c:otherwise>
		${sMNm}님 어서오슈.<input type="button" value="로그아웃" id="logoutBtn"/>
	</c:otherwise>
</c:choose>
<div class="search_area">
<form action="#" id="actionForm" method="post">
		<input type="hidden" id="mNo" name="mNo"/>
		<input type="hidden" id="page" name="page" value="${page}"/>
		<select id="searchGbn" name="searchGbn">
			<option value="0">회원번호</option>
			<option value="1">아이디</option>
			<option value="2">이름</option>
		</select>
		<input type="text" name="searchTxt" value="${param.searchTxt}"/>
		<input type="button" value="검색" id="searchBtn"/>
		<input type="button" value="등록" id="writeBtn"/>
	</form>
</div>
<div class="list_wrap">
	<table>
		<colgroup>
			<col width="100px"/>
			<col width="100px"/>
			<col width="100px"/>
			<col width="100px"/>
			<col width="100px"/>
		</colgroup>
		<thead>
			<tr>
				<th>회원번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>생일</th>
				<th>가입일</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>
</div>
<div class="paging_wrap"></div>
</body>
</html>
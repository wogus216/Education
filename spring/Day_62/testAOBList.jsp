<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	if("${param.searchGbn}" != ""){
		$("#searchGbn").val("${param.searchGbn}");
	} 
	reloadList();
	
	$("#loginBtn").on("click",function(){
		location.href = "testAOBLogin";	
	}); //loginBtn end
	
	$("#logoutBtn").on("click",function(){
		location.href = "testAOBLogout";	
	}); //loginBtn end
	
	$("#searchBtn").on("click",function(){
		$("#page").val(1);
		$("#searchOldTxt").val($("#searchTxt").val());
		reloadList();
	});
	
	$(".paging_wrap").on("click","div",function(){
		$("#page").val($(this).attr("page"));
		$("#searchTxt").val($("#searchOldTxt").val());
		reloadList();
	});
	//작성
	$("#writeBtn").on("click",function(){
		if($.trim($("#obCon").val()) == ""){
			alert("내용을 넣어주세요");
			$("#obCon").focus();
		} else{
		var params = $("#actionForm").serialize();
			
			$.ajax({
				url: "testAOBWrites",
				type: "post",
				dataType: "json",
				data: params,
				success: function(res){
					console.log(res)
					if(res.Msg == "success"){
						location.href = "testAOBList";
					} else{
						alert("작성이 안됐습니다.");
						$("#sp_msg").html("작성이 안됐습니다.")
					}
				},
				error: function(request, status, error){
					console.log(error);
				}
			}); // ajax end
		}
});
}); // ready end

//목록 소환
function  reloadList(){
	var params = $("#actionForm").serialize();
	
	$.ajax({
		url : "testAOBLists",
		type: "post",
		dataType: "json",
		data: params,
		success: function(res){
			
			console.log(res)
			drawList(res.list);
			drawPaging(res.pb);
		},
		error: function(request, status, error){
			
			console.log(error)
		}
	
	});
}

//목록 그리기 
function drawList(list){
	var html= "";
	//" +  + "
	for(var d of list){
	html += "<tr obno=\"" + d.OB_NO + "\">";
	html += "<td>" + d.OB_NO +"</td>";
	html += "<td>" + d.M_NO + "</td>";
	html += "<td>" + d.M_NM + "</td>";
	html += "<td>" + d.OB_CON + "</td>";
	html +=  "<td>" + d.OB_DT + "</td>";
	html +=  "</tr>";
	}
	//비동기시 항상 고정으로 뜨는 친구에게 이벤트 걸어야한다 필수
	$("tbody").html(html);
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
<title>목록</title>
</head>
<body>
<c:choose>
	<c:when test="${empty sMNo}">
		<input type="button" value="로그인" id="loginBtn"/>
	</c:when>
	<c:otherwise>
		${sMNm}님 어서오슈<input type="button" value="로그아웃" id=logoutBtn/>
	</c:otherwise>
</c:choose>
<div class="write_area">
		<form action="#" id="actionForm" method="post">
			<!-- 기본값 : hidden, 검색이 달린 페이지 3요수 필수 !! -->
			<input type="hidden" id="searchGbn" name="searchGbn" value="${param.searchGbn}" />
			<input type="hidden" id="searchTxt" name="searchTxt" value="${param.searchTxt}" />
			<input type="hidden" id="page" name="page" value="${page}" />
			
			<!-- 글작성, 편집영역 -->
			<c:choose>
				<c:when test="${empty sMNo}">
					<input type="button" value="로그인" id="loginBtn"/>
				</c:when>
				<c:otherwise>
					<input type="hidden" name="mNo" value="${sMNo}"/>
					<input type="hidden" name="obNo" id="obNo" />
					${sMNm}<br/>
					<textarea rows="3" cols="50" id="obCon" name="obCon"></textarea>
					<input type="button" value="작성" id="writeBtn"/>
					<input type="button" value="수정" id="updateBtn"/>
					<input type="button" value="취소" id="cancelBtn"/>
				</c:otherwise>
			</c:choose>
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
				<th>댓글번호</th>
				<th>작성자번호</th>
				<th>작성자</th>
				<th>내용</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>
</div>
<div class="paging_wrap"></div>
</body>
</html>
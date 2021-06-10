<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#actionForm #updateBtn,#actionForm #cancelBtn{
	display : none;
} 
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//구분자 내용 남기기
	if("${param.searchGbn}" !=""){
		$("#searchGbn").val("${param.searchGbn}");
	}
	$("#logoutBtn").on("click",function(){
		location.href = "testLogout";
	});
	// id는 중복허용이 안되기 때문에 body로 바꿈 //
	$("body").on("click","#loginBtn",function(){
		location.href = "testLogin";
	});
	//작성버튼
	$("#writeBtn").on("click",function(){
			if($.trim($("#obCon").val()) == ""){
				alert("내용을 넣어주세요");
				$("#obCon").focus();
			} else{
				$("#actionForm").attr("action","testOWrite");
				$("#actionForm").submit();
			}
	});
	$("#searchBtn").on("click",function(){
		
		$("#page").val(1);
		$("#sg").val($("#searchGbn").val());
		$("#st").val($("#searchTxt").val());
	
		$("#actionForm").attr("action", "testO");
		$("#actionForm").submit();
	});
	
	//페이징 이벤트
	$("#pagingWrap").on("click","span",function(){
		$("#page").val($(this).attr("name"));
		
		$("#actionForm").attr("action", "testO");
		$("#actionForm").submit();
	});
	
	// 목록의 수정 버튼 클릭 
	$("table").on("click", "#updateBtn",function(){
		$("#actionForm #writeBtn").hide();
		$("#actionForm #updateBtn,#actionForm #cancelBtn").show();
			//button.td.     tr
		$("#obNo").val($(this).parent().parent().attr("name"));
		//nth-child : 몇 개 째
		console.log($(this).parent().parent().children(":nth-child(2)").html());
		// eq: 몇번 째 인덱스 요소
		console.log($(this).parent().parent().children(":eq(1)").html());
		console.log($(this).parent().parent().children().eq(1).html());
			
			$("#obCon").val($(this).parent().parent().children(":nth-child(2)").html());
	});
	
	//취소 버튼
		$("#actionForm #cancelBtn").on("click", function(){
			$("#obCon").val("");
			$("#obNo").val("");
			
			$("#actionForm #writeBtn").show();
			$("#actionForm #updateBtn,#actionForm #cancelBtn").hide();
		}); //취소 버튼
		
	// 업데이트
	$("#actionForm #updateBtn").on("click",function(){
		if($.trim($("#obCon").val()) == ""){
			alert("내용을 넣어주세요");
			$("#obCon").focus();
		} else{
			$("#actionForm").attr("action","testOUpdate");
			$("#actionForm").submit();
		}
	});
		
	//목록 삭제버튼 클릭
	$("table").on("click", "#deleteBtn",function(){
		if(confirm("삭제하시겠습니까?")) {
			//button.td.     tr
			$("#obNo").val($(this).parent().parent().attr("name"));
			
			$("#actionForm").attr("action","testODelete");
			$("#actionForm").submit();
		}
	});
}); //ready end
</script>
</head>
<body>
<c:choose>
<%-- 코어태그 안에 주석은 요렇게 --%>
<%-- empty : 비어있다. 반대 !붙여라--%>
	<c:when test="${empty sMNo}">
	<!-- 비로그인 -->
	<input type="button" value="로그인" id="loginBtn"/>
	</c:when>
	<c:otherwise>
		<%-- ${} 값 호출때 사용 --%>
		${sMNm}님 어서오세요.<input type="button" value="로그아웃" id="logoutBtn"/>
</c:otherwise>
</c:choose>
<div>
	<div class="write_area">
		<form action="#" id="actionForm" method="post">
			<!-- 기본값 : hidden, 검색이 달린 페이지 3요수 필수 !! -->
			<input type="hidden" id="sg" name="searchGbn" value="${param.searchGbn}" />
			<input type="hidden" id="st" name="searchTxt" value="${param.searchTxt}" />
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
	<div class="list_araa">
		<table border="2" cellspaing="0">
			<thead>
				<tr>
					<th>작성자</th>
					<th>내용</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="data" items="${list}">
					<tr name="${data.OB_NO}">
						<td>${data.M_NM}</td>
						<td>${data.OB_CON}</td>
						<td>
							<c:if test="${sMNo eq data.M_NO}">
								<input type="button" value="수정" id="updateBtn"/>
								<input type="button" value="삭제" id="deleteBtn"/>
							</c:if>
						</td>	
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="paging_area">
		<!-- 검색 -->
		<select id="searchGbn">
			<option value="0">작성자</option>			
			<option value="1">내용</option>			
		</select>
		<input type="text" id="searchTxt" value="${param.searchTxt}"/>
		<input type="button" value="검색" id="searchBtn"/><br/>
		<!-- 페이징 -->
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
	</div>
</div>
</body>
</html>
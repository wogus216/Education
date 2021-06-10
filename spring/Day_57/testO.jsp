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
			<!-- 기본값 : hidden -->

			<!-- 글작성, 편집영역 -->
			<c:choose>
				<c:when test="${empty sMNo}">
					<input type="button" value="로그인" id="loginBtn"/>
				</c:when>
				<c:otherwise>
					<input type="hidden" name="mNo" value="${sMNo}"/>
					${sMNm}<textarea rows="3" cols="50" id="obCon" name="obCon"></textarea>
					<input type="button" value="작성" id="writeBtn"/>
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
				<tr>
					<td>김태리</td>
					<td>아주좋아 오늘</td>
					<td>
						<input type="button" value="수정" id="updateBtn"/>
						<input type="button" value="삭제" id="deleteBtn"/>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="paging_area">
	</div>
</div>
</body>
</html>
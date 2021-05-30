<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="resources/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#backBtn").on("click",function(){
		//history.back(); // 브라우저 히스토리 기록 전단계로 이동
		//history.go(-1); // 브라우저 히스토리 기록 지정한 만큼 이동
		location.href = "test1" // 해당 주소로 이동
	});
});
</script>
</head>
<body>
${param.txt} <%-- ${param.~~~~} : 전 화면에서 넘어온 값 취득 --%>
${test}<%--param.이 안붙는 경우는 java에서 전송한 경우 --%>
<input type="button" value="뒤로가기" id="backBtn"/>
<br/>
<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="d" items="${data}">
		<tr>
			<td>${d.no}</td>
			<td>${d.title}</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</body>
</html>
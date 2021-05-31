<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="data" items="${list}">
			<tr>
				<td>${data.B_NO}</td>
				<td>${data.B_TITLE}</td>
				<td>${data.B_WRITER}</td>
				<td>${data.B_DT}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</body>
</html>
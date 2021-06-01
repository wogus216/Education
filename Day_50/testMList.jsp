<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
thead{
	background-color: red;
}
</style>
</head>
<body>
<table border="2" cellspacing="0">
	<thead>
		<tr>
			<th>회원번호</th>
			<th>아이디</th>
			<th>이름</th>
			<th>생년월일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="info" items="${list}">
			<tr>
				<td>${info.M_NO}</td>
				<td>${info.M_ID}</td>
				<td>${info.M_NM}</td>
				<td>${info.M_JOINDT}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</body>
</html>
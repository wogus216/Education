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
<%--  권한에 따라서 기능 보이게 하기 응용 가능 --%>
<%-- jsp 주석. core tag 안에서는 무조건 이 주석을 사용 --%>
<c:if test="${2 > 0 }">
2가0보다 크다.<br/>
</c:if>
<c:forEach var="i" begin="0" end="9" step="1">
<c:choose>
<%--  조건추가시 when을 추가해주면 된다. --%>
	<c:when test="${i  eq 0}">
	<b>${i}</b><br/>
	</c:when>
	<c:when test="${i % 2 eq 0}">
		${i}<br/>
	</c:when>
	<c:otherwise>
		<b>${i}</b><br/>
	</c:otherwise>
</c:choose>
</c:forEach>
<%-- 2단부터 9단까지 출력  core tab 와 el tag 활용 --%>
<c:forEach var="i" begin="2" end="9" step="1">
	<c:forEach var="j" begin="1" end="9" step="1">
		${i}*${j}=${i*j}<br/>
	</c:forEach>
	<br/>
</c:forEach>
<c:import url="test2.jsp"></c:import>
</body>
</html>
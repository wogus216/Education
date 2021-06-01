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
	
}); //ready end
</script>
</head>
<body>
번호: ${data.B_NO}<br/>
제목: ${data.B_TITLE}<br/>
작성자: ${data.B_WRITER}<br/>
작성일: ${data.B_DT}<br/>
내용<br/>
${data.B_CON}<br/>

</body>
</html>
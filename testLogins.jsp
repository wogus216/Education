<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
if("${res}" == "success") {
	location.href = "testO";
} else {
	alert("아이디 또는 비밀번호가 틀렸습니다.")
	history.back();
}
</script>
</head>
<body>

</body>
</html>
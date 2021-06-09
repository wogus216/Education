<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
// el tag를 script에서 사용 시 ""로  묵어야 함
// alert(오류발생);  <- 따옴표 없을 시 오류난다
// alert("오류발생");  <- 따옴표 있을 시
alert("${msg}");
history.back();
</script>
</head>
<body>

</body>
</html>
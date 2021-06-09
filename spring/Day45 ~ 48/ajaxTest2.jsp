<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#orderTable {
	border-collapse: collapse;
}

#orderTable td, #orderTable th {
	padding: 5px;
	border: 1px solid #444444;
	text-align: center;
}

#orderTable th {
	background-color: #A099FF;
}
</style>
<script type="text/javascript"
		src="resources/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$.ajax({
		url: "resources/json/test2.json",
		type: "get",
		dataType: "json",
		success: function(res) {
			console.log(res);
			var html = "";
			// thead
			html += "<tr>";
			for(var c of res.orderCol) {
				html += "<th>" + c + "</th>";
			}
			html += "</tr>";
			
			$("#orderTable thead").html(html);
			
			html = "";
			
			// tbody
			for(var o of res.order) {
				html += "<tr>";
				for(var c of res.orderCol) {
					html += "<td>" + o[c] + "</td>";
				}
				html += "</tr>";
			}
			
			$("#orderTable tbody").html(html);
		},
		error: function(request, status, error) { // 실패 시 다음 함수 실행
			console.log(request);
			console.log(status);
			console.log(error);
		}
	});
});
</script>
</head>
<body>
<table id="orderTable">
	<thead></thead>
	<tbody></tbody>
</table>
</body>
</html>








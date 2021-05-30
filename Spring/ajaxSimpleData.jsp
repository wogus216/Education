<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>심플데이터 실습</title>
<style type="text/css">
table{
	text-align: center;
}
table th {
	background-color: aqua;
}
</style>
<script type="text/javascript"
		src="resources/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
		url: "resources/json/simpleData.json",
		type: "get",
		dataType: "json",
		success: function(data){
			console.log(data);
		var html="";
		html += "<tr>";
		html += "<th>" + data.list[0].thname1+"</th>";
		html += "<th>" + data.list[0].thname2+"</th>";
		html += "<th>" + data.list[0].thname3+"</th>";
		html += "<th>" + data.list[0].thname4+"</th>";
		html += "<th>" + data.list[0].thname5+"</th>";
		html += "<th>" + data.list[0].thname6+"</th>";
		html += "<th>" + data.list[0].thname7+"</th>";
		html += "</tr>";
		
		$("#orderTable thead").html(html);
		
		var html="";
		
		for(var i = 1 ; i < data.list.length; i++){
		html += "<tr>";
		html += "<td>" + data.list[i].OrderDate+ "</td>";
		html += "<td>" + data.list[i].Region+"</td>";
		html += "<td>" + data.list[i].Rep+"</td>";
		html += "<td>" + data.list[i].Item+"</td>";
		html += "<td>" + data.list[i].Units+"</td>";
		html += "<td>" + data.list[i].UnitCos+"</td>";
		html += "<td>" + data.list[i].Total+"</td>";
		html += "</tr>";
		}
	
		$("#orderTable tbody").html(html);
		},
		error: function(request, status, error){
			console.log(request);
			console.log(status);
			console.log(error);
		}
	}); //ajax end
}); //ready end
</script>
</head>
<body>
<table id="orderTable" border="1">
	<thead></thead>
	<tbody>	</tbody>
</table>
</body>
</html>
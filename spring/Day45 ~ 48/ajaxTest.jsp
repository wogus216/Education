<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#weatherIcon{
	display: none;
}
</style>
<script type="text/javascript"
	src="resources/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#weatherIcon").hide();
	
	getWeather();
	
	$("#getBtn").on("click", function(){
			$.ajax({
				    url: "resources/json/test.json", // 접속 주소
				    type: "get", // 전송방식 : get,post
				    dataType: "json", // 받아올 데이터 형식
				    success: function(res){ //성공 시 다음 함수 실행 
				    	var html="";
				    
				    	for(var d of res.list){
				    			html += d.no+ "," + d.name + "<br/>"
				    	}
				    	
				    	$("#box").append(html)
				    },
				    error: function(request, status, error){ //실패시 다음 함수 실행
				    	console.log(reqest);
				    	console.log(status);
				    	console.log(error);
				    	
				    }
			});
		});
	});
	function getWeather(){
		$.ajax({ //get 방식은 ? 기준으로 주소와 데이터가 나뉜다.
				url: "https://api.openweathermap.org/data/2.5/onecall/timemachine", // 접속 주소
				type: "get", // 전송방식 : get,post
				dataType: "json", // 받아올 데이터 형식
				data: "lat=37.5683&lon=126.9778&dt=1622098592&appid=f532aa01d351de228cbeb0be0c5d16b0", 
			     //보낼 데이터(문자열 형태)
				success: function(res){  //성공 시 다음 함수 실행 
						 console.log(res);
						 console.log(res.main.temp);
						 console.log(res.weather[0].icon);
						 $("#weatherIcon").attr("src",
								 " http://openweathermap.org/img/wn/"
								 + res.weather[0].icon +  "@2x.png");
						 $("#temp").html(res.main.temp +"℃-"+ res.weather[0].description);
			   			 $("#weatherIcon").fadeIn("slow");
				},
				error: function(request, status, error){ //실패 시 다음 함수 실행
					console.log(request);				
					console.log(status);				
					console.log(error);				
				}
		});
	}
</script>
</head>
<body>
<div id="weatherWrap">
<img alt="날씨" id="weatherIcon" />
<br/>
<span id="temp"></span>
</div>
<input type="button" value="가져오기" id="getBtn"/>
<div id="box"></div>
</body>
</html>
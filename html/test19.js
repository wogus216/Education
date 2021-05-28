/**
 * 
 */
var imgs = ["가위.png","바위.png","보.png"];
var now =0;

var interval = null;
var timeout = null;

function playImg(){
	if(interval == null){
		timeout = setTimeout(fade, 2700);
		interval = setInterval(changeImg,3000);
	}
}

function changeImg(){
	now++;
	
	if(now == imgs.length){
		now = 0;
	}
	document.getElementById("img1").src = imgs[now];
	timeout = setTimeout(fade, 2700);
}

function stopImg(){
	clearInterval(interval);
	clearTimeout(timeout);
	interval = null;
}

function fade(){
	//fadeout 0.3s  --> 300 / 20 ==> 15, 1.0 / 20 = 0.05
	for(var i = 1;  i <= 20 ; i++){
		setTimeout(function(t){
			document.getElementById("img1").style.opacity = 1.0 - (0.05 * t)
		}, 15 * i, i);	
	}
	//fadeIn 0.3s
	for(var i = 1;  i <= 20 ; i++){
		setTimeout(function(t){
			document.getElementById("img1").style.opacity = 0.0 + (0.05 * t)
		}, 300 + (15 * i), i);	
	}
}
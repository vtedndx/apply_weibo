
//登录框
var loginWin;
var thebody;
function login(url, thetop){
	var width,height;
	var left,top;
	var close_btn_left,close_btn_top;
	//if (str=='sina'){
		width=600;
		height=445;
	//}
	loginWin = document.createElement("div");
	loginWin.className = "loginWin";
	loginWin.style.width = width+4+"px";
	loginWin.style.height = height+4+"px";
	loginWin.style.display = "block";
	loginWin.style.backgroundColor = "#FFFFFF";
	loginWin.style.zIndex = 9999;
	loginWin.style.position = "absolute";
	loginWin.style.border = "2px solid #FFFFFF";
	var left=0;
	thebody = document.getElementsByTagName("body")[0]
	left = (thebody.clientWidth - width) / 2 ;
	loginWin.style.left = left + "px";
	loginWin.style.top = thetop;
	var iframe = document.createElement("iframe");
	iframe.src = url;
	iframe.width = width;
	iframe.height = height;
	iframe.style.border = "0";
	iframe.style.marginLeft = "2px";
	iframe.style.marginTop = "2px";
	iframe.border = "0";
	iframe.scrolling = "no";
	iframe.frameBorder = "0";
	loginWin.appendChild(iframe);
	thebody.appendChild(loginWin);
}
function closeLogin(){
	thebody.removeChild(loginWin);
}
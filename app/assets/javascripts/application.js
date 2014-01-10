// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
function myScriptAjax(remote_url){
	$.ajax({
      url: remote_url,
      dataType: "script"
    });
}


/*创建阴影*/
function createShadow(){
	$('body').append('<div class="bodyShadow"></div>');
	$('.bodyShadow').css({'width':'100%','height':'100%','position':'absolute','top':'0','left':'0','z-index':'900','background-color':'#000','opacity':'0.6'});
}
function removeShadow(){
	$('.bodyShadow').remove();	
}

function close_easy_dialog(){
	easyDialog.close();
	removeShadow();
}

function img_load(t){
	var bq_jc = $("#biaoqing_jc");
	var this_offset = $(t).offset();
	var this_top = this_offset.top-20;
	var this_left = this_offset.left-bq_jc.width()/2;
	bq_jc.css({
		position:"absolute",
		top:this_top+44+"px",
		left:this_left+144+"px"
		}).css('z-index','2000000').show();
}
function biaoqing_click(current){
	var bq_jc=$("#biaoqing_jc_2");
	var this_offset=$(current).offset();
	var this_top=this_offset.top-20;
	var this_left=this_offset.left-bq_jc.width()/2;
	bq_jc.css({
		position:"absolute",
		top:this_top+"px",
		left:this_left+50+"px"
		}).css('z-index','20000000').show();
}

function goTo(domainUrl, parentUrl, iframeUrl){
	if(window.parent == window){
		window.location= domainUrl + "?" + iframeUrl;
	} else{
		var targetUrl = commonTo(parentUrl, iframeUrl);
		// window.parent.location = targetUrl;
		window.top.location.href = targetUrl;
	}
}
function openTo(domainUrl, parentUrl, iframeUrl){
	if(window.parent == window){
		window.open(domainUrl + "?" + iframeUrl);
	} else{
		var targetUrl = commonTo(parentUrl, iframeUrl);
		window.open(targetUrl);
	}
}

function goManager(domainUrl, iframeUrl){
	var url = ("http://e.weibo.com/epspcpage/location?frame_url=http%3a%2f%2fe.weibo.com%2fepspcpage%2fthirdapp%2Fapp%3Fappkey%3D"+iframeUrl).replace("&key=", "%26key%3D");
	if(window.parent == window){
		window.location = url;
	} else{
		window.top.location.href = url;
	}
}

function commonTo(parentUrl, iframeUrl){
	if(iframeUrl != ''){
		parentUrl += "?";
		parentUrl += iframeUrl;
	}
	return parentUrl;
}

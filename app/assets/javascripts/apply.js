function click_name(obj){
	$(obj).removeAttr("onclick");
	ajax_element("name");
	setTimeout(function(){
		$(obj).attr("onclick", "click_name(this)");
	},500);
}

function click_sex(obj){
	$(obj).removeAttr("onclick");
	ajax_element("sex");
	setTimeout(function(){
		$(obj).attr("onclick", "click_sex(this)");
	},500);
}

function click_age(obj){
  $(obj).removeAttr("onclick");
  ajax_element("age");
  setTimeout(function(){
    $(obj).attr("onclick", "click_age(this)");
  },500);
}

function click_birthday(obj){
  $(obj).removeAttr("onclick");
  ajax_element("birthday");
  setTimeout(function(){
    $(obj).attr("onclick", "click_birthday(this)");
  },500);
}

function click_tel(obj){
  $(obj).removeAttr("onclick");
  ajax_element("tel");
  setTimeout(function(){
    $(obj).attr("onclick", "click_tel(this)");
  },500);
}

function click_region(obj){
  $(obj).removeAttr("onclick");
  ajax_element("region");
  setTimeout(function(){
    $(obj).attr("onclick", "click_region(this)");
  },500);
}

function click_card(obj){
  $(obj).removeAttr("onclick");
  ajax_element("card");
  setTimeout(function(){
    $(obj).attr("onclick", "click_card(this)");
  },500);
}

function click_email(obj){
  $(obj).removeAttr("onclick");
  ajax_element("email");
  setTimeout(function(){
    $(obj).attr("onclick", "click_email(this)");
  },500);
}

function click_attention(obj){
  $(obj).removeAttr("onclick");
  ajax_element("attention");
  setTimeout(function(){
    $(obj).attr("onclick", "click_attention(this)");
  },500);
}

function click_line(obj){
  $(obj).removeAttr("onclick");
  ajax_element("line");
  setTimeout(function(){
    $(obj).attr("onclick", "click_line(this)");
  },500);
}

function click_single_line(obj){
  $(obj).removeAttr("onclick");
  ajax_element("single_line");
  setTimeout(function(){
    $(obj).attr("onclick", "click_single_line(this)");
  },500);
}

function click_writing(obj){
  $(obj).removeAttr("onclick");
  ajax_element("writing");
  setTimeout(function(){
    $(obj).attr("onclick", "click_writing(this)");
  },500);
}

function click_multiple(obj){
  $(obj).removeAttr("onclick");
  ajax_element("multiple");
  setTimeout(function(){
    $(obj).attr("onclick", "click_multiple(this)");
  },500);
}

function click_checkbox(obj){
  $(obj).removeAttr("onclick");
  ajax_element("checkbox");
  setTimeout(function(){
    $(obj).attr("onclick", "click_checkbox(this)");
  },500);
}

function click_radio(obj){
  $(obj).removeAttr("onclick");
  ajax_element("radio");
  setTimeout(function(){
    $(obj).attr("onclick", "click_radio(this)");
  },500);
}

function click_select(obj){
  $(obj).removeAttr("onclick");
  ajax_element("select");
  setTimeout(function(){
    $(obj).attr("onclick", "click_select(this)");
  },500);
}

function click_date(obj){
  $(obj).removeAttr("onclick");
  ajax_element("date");
  setTimeout(function(){
    $(obj).attr("onclick", "click_date(this)");
  },500);
}

function click_file(obj){
  $(obj).removeAttr("onclick");
  ajax_element("file");
  setTimeout(function(){
    $(obj).attr("onclick", "click_file(this)");
  },500);
}

function edit_name(obj){
  $("#"+obj+"_must").val();
}

function ajax_element(type){
	$.ajax({
    type: "GET",
    url: "/admin/page/add_element/"+type+"?cid="+$("#abc").val()+"&viewer="+$("#view").val()+"&esvd="+$("#esvd").val(),
    success: function(html){
    	var requisition_show_content=$('.requisition_show_content');
    	var careatSetting=$(html);
      requisition_show_content.append(careatSetting);
      careatSetting.hide();
      careatSetting.show('slow');
    	initHeight(careatSetting);

      careatSetting.find(".text_color").attr("style", "color:"+$("#writing_color_input").val());
      careatSetting.find(".line_color").attr("style", "background-color:"+$("#writing_color_input").val());
    }
  });
}

function del_element(id){
  thisparmodel=$("#div_"+id);
  thisheight=thisparmodel.height();
  uidraggable=thisparmodel.parents('.requisition_show');
  // adminMainbg=uidraggable.parents('.adminMain').find('img:first');
  adminMain=uidraggable.parents('.adminMain');
  adminMainbg=adminMain.find('img:first');
  h=adminMainbg.height()-(uidraggable.height()+uidraggable.position().top);
  thisparmodel.hide('slow',function(){
    thisheight=$(this).height()+15;
    adminMainHeight=adminMain.height();
    newadminMainHeight=adminMainHeight-thisheight;
    uidraggabletopheight=uidraggable.height()+uidraggable.position().top;
    adminMainbgheight=adminMainbg.height();
    if(uidraggabletopheight+h<adminMainbgheight){
      if(adminMainbgheight-uidraggabletopheight!==h){
        adminMain.css('height',newadminMainHeight);
        adminMainbg.stop(true,false).animate({'height':newadminMainHeight},500);  
      }
    }
    var thisDetach=$(this).detach();
  });
}

function out_element(id){
	$("#div_"+id).css('cursor','move').addClass('moveModel').find('.addOperating').show();
}

function in_element(id){
	$("#div_"+id).removeClass('moveModel').find('.addOperating').hide();
}

function initHeight(obj) {
  uidraggable = $('.requisition_show');
  adminMainbg = $('.adminMain').find('img:first');
  uidraggabletopheight=uidraggable.height()+uidraggable.position().top;
  adminMainbgheight=adminMainbg.height();
  h=adminMainbg.height()-(uidraggable.height()+uidraggable.position().top);
  adminMain=uidraggable.parents('.adminMain');
  // thisparmodel = ('.requisitionModel');
  obj.show('slow',function(){
    thisheight=$(this).height()+15;
    adminMainHeight=adminMain.height();
    newadminMainHeight=adminMainHeight+thisheight;
    uidraggabletopheight=uidraggable.height()+uidraggable.position().top;
    adminMainbgheight=adminMainbg.height();
    if((uidraggabletopheight+h)>=adminMainbgheight){
      if((adminMainbgheight-uidraggabletopheight)!==h){
        adminMain.css('height',newadminMainHeight);
        adminMainbg.stop(true,false).animate({'height':newadminMainHeight},500);  
      }
    }
  }); 

}
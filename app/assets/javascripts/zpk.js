// JavaScript Document



 
;(function($){
	//add option
		function addOption(appendName,index){
				careatOption=$('<option></option>');
				appendName.append(careatOption);
				appendName.find('option:last').text(index);
				appendName.find('option:last').attr('value',index);
		};
		function deleteOption(optionName){
				optionName.find('option:not(:first)').remove();	
		}
	//add province and city	
	var province=['北京','上海','天津','福建','海南','浙江','江西','广西','广东','重庆','宁夏','河北','陕西','辽宁','吉林','江苏','山东','湖南','四川','云南','甘肃','青海','安徽','贵州','山西','湖北','西藏','河南','新疆','澳门','香港','台湾','内蒙古','黑龙江','海外','其他'];
	var cities = {  

'北京' : ['东城区','西城区','崇文区','宣武区','朝阳区','丰台区','石景山区','海淀区','门头沟区','房山区','通州区','顺义区','昌平区','大兴区','怀柔区','平谷区','密云县','延庆县'],
'上海' : ['黄浦区','卢湾区','徐汇区','长宁区','静安区','普陀区','闸北区','虹口区','杨浦区','闵行区','宝山区','嘉定区','浦东新区','金山区','松江区','青浦区','南汇区','奉贤区','崇明县'],
'天津' : ['和平区','河东区','河西区','南开区','河北区','红桥区','塘沽区','汉沽区','大港区','东丽区','西青区','津南区','北辰区','武清区','宝坻区','宁河县','静海县','蓟县'],
'广西' : ['南宁','柳州','桂林','梧州','北海','防城港','钦州','贵港','玉林','百色','贺州','河池','南宁','柳州'],
'福建' : ['福州','厦门','莆田','三明','泉州','漳州','南平','龙岩','宁德'],
'海南' : ['海口','三亚','其他'],
'浙江' : ['杭州','宁波','温州','嘉兴','湖州','绍兴','金华','衢州','舟山','台州','丽水'],
'江西' : ['南昌','景德镇','萍乡','九江','新余','鹰潭','赣州','吉安','宜春','抚州','上饶'],
'广东' : ['广州','韶关','深圳','珠海','汕头','佛山','江门','湛江','茂名','肇庆','惠州','梅州','汕尾','河源','阳江','清远','东莞','中山','潮州','揭阳','云浮'],
'重庆' : ['万州区','涪陵区','渝中区','大渡口区','江北区','沙坪坝区','九龙坡区','南岸区','北碚区','万盛区','双桥区','渝北区','巴南区','黔江区','长寿区','綦江县','潼南县','铜梁县','大足县','荣昌县','璧山县','梁平县','城口县','丰都县','垫江县','武隆县','忠县','开县','云阳县','奉节县','巫山县','巫溪县','石柱土家族自治县','秀山土家族苗族自治县','酉阳土家族苗族自治县','彭水苗族土家族自治县','江津市','合川市','永川区','南川市'],
'宁夏' : ['银川','石嘴山','吴忠','固原'],
'河北' : ['石家庄','唐山','秦皇岛','邯郸','邢台','保定','张家口','承德','沧州','廊坊','衡水'],
'黑龙江' : ['哈尔滨','齐齐哈尔','鸡西','鹤岗','双鸭山','大庆','伊春','佳木斯','七台河','牡丹江','黑河','绥化','大兴安岭'],
'陕西' : ['西安','铜川','宝鸡','咸阳','渭南','延安','汉中','榆林','安康','商洛'],
'澳门' : ['澳门'],
'辽宁' : ['沈阳','大连','鞍山','抚顺','本溪','丹东','锦州','营口','阜新','辽阳','盘锦','铁岭','朝阳','葫芦岛'],
'吉林' : ['长春','吉林','四平','辽源','通化','白山','松原','白城','延边朝鲜族自治州'],
'江苏' : ['南京','无锡','徐州','常州','苏州','南通','连云港','淮安','盐城','扬州','镇江','泰州','宿迁'],
'山东' : ['济南','青岛','淄博','枣庄','东营','烟台','潍坊','济宁','泰安','威海','日照','莱芜','临沂','德州','聊城','滨州','菏泽'],
'湖南' : ['长沙','株洲','湘潭','衡阳','邵阳','岳阳','常德','张家界','益阳','郴州','永州','怀化','娄底','湘西土家族苗族自治州'],
'四川' : ['成都','自贡','攀枝花','泸州','德阳','绵阳','广元','遂宁','内江','乐山','南充','眉山','宜宾','广安','达州','雅安','巴中','资阳','阿坝','甘孜','凉山'],
'云南' : ['昆明','曲靖','玉溪','保山','昭通','楚雄','红河','文山','思茅','西双版纳','大理','德宏','丽江','怒江','迪庆','临沧'],
'甘肃' : ['兰州','嘉峪关','金昌','白银','天水','武威','张掖','平凉','酒泉','庆阳','定西','陇南','临夏','甘南'],
'青海' : ['西宁','海东','海北','黄南','海南','果洛','玉树','海西'],
'安徽' : ['合肥','芜湖','蚌埠','淮南','马鞍山','淮北','铜陵','安庆','黄山','滁州','阜阳','宿州','巢湖','六安','亳州','池州','宣城'],
'香港' : ['香港'],
'贵州' : ['贵阳','六盘水','遵义','安顺','铜仁','黔西南','毕节','黔东南','黔南'],
'台湾' : ['台北','高雄','其他'],
'山西' : ['太原','大同','阳泉','长治','晋城','朔州','晋中','运城','忻州','临汾','吕梁'],
'湖北' : ['武汉','黄石','十堰','宜昌','襄樊','鄂州','荆门','孝感','荆州','黄冈','咸宁','随州','恩施土家族苗族自治州'],
'西藏' : ['拉萨','昌都','山南','日喀则','那曲','阿里','林芝'],
'内蒙古' : ['呼和浩特','包头','乌海','赤峰','通辽','鄂尔多斯','呼伦贝尔','兴安盟','锡林郭勒盟','乌兰察布盟','巴彦淖尔盟','阿拉善盟'],
'河南' : ['郑州','开封','洛阳','平顶山','安阳','鹤壁','新乡','焦作','濮阳','许昌','漯河','三门峡','南阳','商丘','信阳','周口','驻马店'],
'新疆' : ['乌鲁木齐','克拉玛依','吐鲁番','哈密','昌吉','博尔塔拉','巴音郭楞','阿克苏','克孜勒苏','喀什','和田','伊犁','塔城','阿勒泰'],
'海外' : ['美国','英国','法国','俄罗斯','加拿大','巴西','澳大利亚','印尼','泰国','马来西亚','新加坡','菲律宾','越南','印度','日本','其他'],
'其他' : [''], }
	var provinceLength=province.length;
	//创建区县
		function createCity(careatProvinceName,careatCityName){
			if(typeof careatProvinceName=="string"){
				citiesSelected=cities[careatProvinceName];
				citiesLength=citiesSelected.length;
				for(i=0;i<citiesLength;i++){
					index=citiesSelected[i];
					addOption(careatCityName,index);
				}
			}else{
			provinceSelected=careatProvinceName.find('option:selected').val();
			citiesSelected=cities[provinceSelected];
			citiesLength=citiesSelected.length;			
			for(i=0;i<citiesLength;i++){
				index=citiesSelected[i];
				addOption(careatCityName,index);
			}
			}
		}	
	//设置省市区县
		function settingProvince(provinceName,cityName){
			var provinceSelectedArray=$province_select.find('option');
			provinceSelectedArray.each(function(index, element) {
                var thisSelectedText=$(this).text();
				if(thisSelectedText==provinceName){
					$province_select.val(provinceName)
				}
            });
			createCity(provinceName,cityName);
			if(cityName){
				$city_select.val(cityName);
			}
		}
	//年月日	
		function settingYMDay(month,year,dayOption){
			if(month=='1'||month=='3'||month=='5'||month=='7'||month=='8'||month=='10'||month=='12'){
					for(i=1;i<=31;i++){
						addOption(dayOption,i);
					};
				}else if(month=='4'||month=='6'||month=='9'||month=='11'){
					for(i=1;i<=30;i++){
						addOption(dayOption,i);
					};
				}else if(month=='2'){
					if((year%4==0&&year%100!=0)||year%400==0){
						for(i=1;i<=29;i++){
						addOption(dayOption,i);
					};
					}else{
						for(i=1;i<=28;i++){
						addOption(dayOption,i);
					};
					}
				}	
		}
	$.fn.extend({
		//鼠标点击显示隐藏
		holderContent:function(){
			$(this).each(function(index, element) {
                var thisHolderContent=$(this),tmpHolderContent=$(this).clone(true),hasHolderContent=$(this).attr('holder_content');
				if(hasHolderContent){
					tmpHolderContent.addClass('holderContentColor');
					tmpHolderContent.val(hasHolderContent);
					tmpHolderContent.show();
					$(this).before(tmpHolderContent);
					thisHolderContent.hide();
					tmpHolderContent.focus(function(){
							tmpHolderContent.hide();
							thisHolderContent.show();
							thisHolderContent.focus();
					});
					thisHolderContent.blur(function(){
						var thisVal=$(this).val();
						if(thisVal==''){
							$(this).hide();
							tmpHolderContent.show();
						};
					});		
				};
            });
		},
		//在指定位置添加自定义内容
		addContentSpecifiedLocation:function(addContentClass,toClassName){
			
			
			$(this).click(function(){
				uidraggable=toClassName.parents('.requisition_show');
				adminMainbg=uidraggable.parents('.adminMain').find('img:first');
				h=adminMainbg.height()-(uidraggable.height()+uidraggable.position().top);
				tmpClone=addContentClass.clone(true);
				toClassName.prepend(tmpClone);
				tmpClone.hide();	
				tmpClone.show('slow',function(){
					uidraggabletopheight=uidraggable.height()+uidraggable.position().top;
					adminMainbgheight=adminMainbg.height();
					if((uidraggabletopheight+h)>=adminMainbgheight){
						if((adminMainbgheight-uidraggabletopheight)!==h){
							adminMainbg.animate({'height':(uidraggabletopheight+h)},500);
							
						}
					}
				});	
				
			});
			
		},		
		//创建下拉年份		
		careatSelectDate:function(startYear,endYear,selectYear,selectMonth,selectDay){
			for(i=startYear;i<=endYear;i++){
				addOption(selectYear,i)
			};
			selectYear.focus(function(){
				deleteOption(selectMonth);
				deleteOption(selectDay);		
			});
			selectYear.blur(function(){
				thisSelectYearValue=selectYear.val();
				if(thisSelectYearValue=="选择"){
					return false;
				}else{
					for(i=1;i<=12;i++){
						addOption(selectMonth,i);
					};
				};
				return thisSelectYearValue;
			});
			selectMonth.focus(function(){
				deleteOption(selectDay);
			});
			selectMonth.blur(function(){
				thisSelectMonthValue=selectMonth.val();
				settingYMDay(thisSelectMonthValue,thisSelectYearValue,selectDay);
			});
		},
		//设置下拉年月日
		settingSelectDate:function(settingYear,settingMonth,settingDay){
			thisSettingSelect=$(this).find('select');
			thisSettingSelectYear=thisSettingSelect.eq(0);
			thisSettingSelectMonth=thisSettingSelect.eq(1);
			thisSettingSelectDay=thisSettingSelect.eq(2);
			if(arguments.length==1){
				thisSettingSelectYear.val(settingYear);
			}
			if(arguments.length==2){
				thisSettingSelectYear.val(settingYear);	
				for(i=1;i<=12;i++){
						addOption(thisSettingSelectMonth,i);
					};
				thisSettingSelectMonth.val(settingMonth);
			}
			if(arguments.length==3){
				thisSettingSelectYear.val(settingYear);	
				for(i=1;i<=12;i++){
						addOption(thisSettingSelectMonth,i);
					};
				thisSettingSelectMonth.val(settingMonth);
				thisSettingSelectMonthValue=thisSettingSelectMonth.val();
				thisSettingSelectYearValue=thisSettingSelectYear.val();
				settingYMDay(thisSettingSelectMonthValue,thisSettingSelectYearValue,thisSettingSelectDay);
				thisSettingSelectDay.val(settingDay);
			}
		},
		//创建省市区县
		careatProvinceCities:function(provinceName,cityName){

				for(i=0;i<provinceLength;i++){
					addOption(provinceName,province[i]);	
				};
				provinceName.focus(function(){
					cityName.find('option:not(:first)').remove();	
				});
				provinceName.blur(function(){
					createCity(provinceName,cityName);
				});
            
			
			
		},
		settingProvinceCity:function(setProvinceName,settingCityName){
			thisSelect=$(this).find('select');
			if(arguments.length==1){
				thisSelect.val(setProvinceName);
			}else if(arguments.length==2){
				thisSelectProvince=thisSelect.eq(0);
				thisSelectCity=thisSelect.eq(1);
				thisSelectProvince.val(setProvinceName);
				thisSelectProvinceValue=thisSelectProvince.val();
				createCity(thisSelectProvinceValue,thisSelectCity);
				thisSelectCity.val(settingCityName);
				thisSelect.each(function(index, element) {
					var thisSelectName=$(this).attr('name');
					if(thisSelectName=='province'){
						$(this).val(setProvinceName);
					}
					if(thisSelectName=='city'){
						$(this).val(settingCityName);
					}
				});	
			}
		},
		
		
		//settingProvince('北京');//定位到北京
		//settingProvince('北京','西城区');//定位到北京市西城区  
		
		
		
		
	});
})(jQuery);






/* =========================================================
 * bootstrap-modal.js v2.0.2
 * http://twitter.github.com/bootstrap/javascript.html#modals
 * =========================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ========================================================= */


!function( $ ){

  "use strict"

 /* MODAL CLASS DEFINITION
  * ====================== */

  var Modal = function ( content, options ) {
    this.options = options
    this.$element = $(content)
      .delegate('[data-dismiss="modal"]', 'click.dismiss.modal', $.proxy(this.hide, this))
  }

  Modal.prototype = {

      constructor: Modal

    , toggle: function () {
        return this[!this.isShown ? 'show' : 'hide']()
      }

    , show: function () {
        var that = this

        if (this.isShown) return

        $('body').addClass('modal-open')

        this.isShown = true
        this.$element.trigger('show')

        escape.call(this)
        backdrop.call(this, function () {
          var transition = $.support.transition && that.$element.hasClass('fade')

          !that.$element.parent().length && that.$element.appendTo(document.body) //don't move modals dom position

          that.$element
            .show()

          if (transition) {
            that.$element[0].offsetWidth // force reflow
          }

          that.$element.addClass('in')

          transition ?
            that.$element.one($.support.transition.end, function () { that.$element.trigger('shown') }) :
            that.$element.trigger('shown')

        })
      }

    , hide: function ( e ) {
        e && e.preventDefault()

        if (!this.isShown) return

        var that = this
        this.isShown = false

        $('body').removeClass('modal-open')

        escape.call(this)

        this.$element
          .trigger('hide')
          .removeClass('in')

        $.support.transition && this.$element.hasClass('fade') ?
          hideWithTransition.call(this) :
          hideModal.call(this)
      }

  }


 /* MODAL PRIVATE METHODS
  * ===================== */

  function hideWithTransition() {
    var that = this
      , timeout = setTimeout(function () {
          that.$element.off($.support.transition.end)
          hideModal.call(that)
        }, 500)

    this.$element.one($.support.transition.end, function () {
      clearTimeout(timeout)
      hideModal.call(that)
    })
  }

  function hideModal( that ) {
    this.$element
      .hide()
      .trigger('hidden')

    backdrop.call(this)
  }

  function backdrop( callback ) {
    var that = this
      , animate = this.$element.hasClass('fade') ? 'fade' : ''

    if (this.isShown && this.options.backdrop) {
      var doAnimate = $.support.transition && animate

      this.$backdrop = $('<div class="modal-backdrop ' + animate + '" />')
        .appendTo(document.body)

      if (this.options.backdrop != 'static') {
        this.$backdrop.click($.proxy(this.hide, this))
      }

      if (doAnimate) this.$backdrop[0].offsetWidth // force reflow

      this.$backdrop.addClass('in')

      doAnimate ?
        this.$backdrop.one($.support.transition.end, callback) :
        callback()

    } else if (!this.isShown && this.$backdrop) {
      this.$backdrop.removeClass('in')

      $.support.transition && this.$element.hasClass('fade')?
        this.$backdrop.one($.support.transition.end, $.proxy(removeBackdrop, this)) :
        removeBackdrop.call(this)

    } else if (callback) {
      callback()
    }
  }

  function removeBackdrop() {
    this.$backdrop.remove()
    this.$backdrop = null
  }

  function escape() {
    var that = this
    if (this.isShown && this.options.keyboard) {
      $(document).on('keyup.dismiss.modal', function ( e ) {
        e.which == 27 && that.hide()
      })
    } else if (!this.isShown) {
      $(document).off('keyup.dismiss.modal')
    }
  }


 /* MODAL PLUGIN DEFINITION
  * ======================= */

  $.fn.modal = function ( option ) {
    return this.each(function () {
      var $this = $(this)
        , data = $this.data('modal')
        , options = $.extend({}, $.fn.modal.defaults, $this.data(), typeof option == 'object' && option)
      if (!data) $this.data('modal', (data = new Modal(this, options)))
      if (typeof option == 'string') data[option]()
      else if (options.show) data.show()
    })
  }

  $.fn.modal.defaults = {
      backdrop: true
    , keyboard: true
    , show: true
  }

  $.fn.modal.Constructor = Modal


 /* MODAL DATA-API
  * ============== */

  $(function () {
    $('body').on('click.modal.data-api', '[data-toggle="modal"]', function ( e ) {
      var $this = $(this), href
        , $target = $($this.attr('data-target') || (href = $this.attr('href')) && href.replace(/.*(?=#[^\s]+$)/, '')) //strip for ie7
        , option = $target.data('modal') ? 'toggle' : $.extend({}, $target.data(), $this.data())

      e.preventDefault()
      $target.modal(option)
    })
  })

}( window.jQuery );


























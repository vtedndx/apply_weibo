#coding: utf-8
module ApplicationHelper

  def is_v(v)
    v.blank? ? 1 : v == "0" ? [2, 400] : [2, 400]
  end

  def is_girl_boy(sex)
    sex.blank? ? 1 : sex
  end

  def is_pro_city(pro, city)
    location = nil
    location = if !pro.blank? && !city.blank?
      "#{pro} #{city}"
    elsif !pro.blank?
      pro
    end
    location.blank? ? 1 : location
  end

  def weibo_link(rails_link)
    # return rails_link  # 需要包装链接时，注释掉本行即可
    #ex. rails_link = "/stars/view_more?abc=3&ee=17&more=no_more"
    #rails_link中不能有 . 和 |
    if rails_link =~ /\?/ && !@act.blank? && !@source.blank?
      rails_link += "&act_id=#{@act.id}&source=0"
    elsif !@act.blank? && !@source.blank?
      rails_link += "?act_id=#{@act.id}&source=0"
    end
    weibolink = "key=list" + rails_link.gsub(/\?/,":").gsub(/&/,"|").gsub(/_/,".").gsub(/\//,"_")
    return "javascript:goTo('#{DN_URL}', '#{@weibo_root}', '#{weibolink}')"
  end

  def weibo_manager_link(rails_link)
    rails_link += rails_link =~ /\?/ ? "&apply_id=#{@apply.id}" : "?apply_id=#{@apply.id}" if !@apply.blank?
    weibolink = "#{SNS["appkey"]}&key=list" + rails_link.gsub(/\?/,":").gsub(/&/,"|").gsub(/_/,".").gsub(/\//,"_")
    return "javascript:goManager('#{DN_URL}', '#{weibolink}')"
  end

  def format_friend(json)
    if !json.blank?
      if json["source"]["following"] && json["target"]["following"]
        return raw "<span class='activity_icon icon2'></span>互相关注"
      elsif json["target"]["following"]
        return raw "<span class='activity_icon icon1'></span>已关注您"
      else
        return raw "<span class='activity_icon icon4'></span>未关注您"
      end
    else
      return raw "<span class='activity_icon icon4'></span>帐户异常"
    end
  end

  def format_date(date)
    return date.strftime("%Y-%m-%d")
  end

  def manager_link(rails_link)
    and_sym = rails_link =~ /\?/ ? "&" : "?"
    rails_link += and_sym + "viewer=#{params[:viewer]}"
    rails_link += "&esvd=#{@esvd}" if @esvd
    apply_id = @apply.id if !@apply.blank?
    return (rails_link + "&apply_id=#{apply_id}")
  end

  def user_type(type)
    return raw({-1 => "", 0 => "<i class='icon_imperial_crown'></i>", 1 => "政府", 2 => "<img src='/assets/lanV.png'/>", 3 => "媒体", 4 => "校园", 5 => "网站", 6 => "应用", 7 => "<em class='icon_user_5'></em>", 8 => "<em class='icon_user_6'></em>", 200 => "<img src='/assets/daren.png'/>", 220 => "<img src='/assets/daren.png'/>", 400 => "<img src='/assets/littlePic.png'/>"}[type])
  end

  def encode_url(link)
    # company_str = @company ? "&remid=#{SinaClient.encryptstr(@company.cid)}" : ""
    return "#{@weibo_root}?key=list" + link.gsub(/\?/,":").gsub(/&/,"|").gsub(/_/,".").gsub(/\//,"_")
  end

  def resession_link(rails_link)
    @esvd = @user ? SinaClient.encryptstr(@user.sns_uid) : "" unless @esvd
    source = !@apply.blank?  ? "&apply_id=#{@apply.id}" : ""
    viewer = @user ? @user.sns_uid : ""

    if rails_link =~ /\?/
      return rails_link + "&cid=#{@company.cid}&esvd=#{@esvd}&viewer=#{viewer}" +  source
    else
      return rails_link + "?cid=#{@company.cid}&esvd=#{@esvd}&viewer=#{viewer}" +  source
    end
  end

  def format_http(link)
    if link =~ /http/
      return link
    else
      return "http://#{link}"
    end
  end

  def truncate_url(link)
    relink =  link.gsub(/^http:\/\//,"") 
    relink =  relink.gsub(/^www\./,"") if relink.start_with?('www.') && !relink.include?('/')
    return relink
  end


  def truncate_utf(text, length = 20, truncate_string = "...")
    l=0
    char_array=text.unpack("U*")
    char_array.each_with_index do |c,i|
      l = l+ (c<127 ? 0.5 : 1)
      if l>=length
        return char_array[0..i].pack("U*")+(i<char_array.length-1 ? truncate_string : "")
      end
    end
    return text
  end

  def set_config(key, value)
    self.config_hash ||= {}
    self.config_hash[key] ||= {}
    self.config_hash[key] = value
    self.save
  end

  def get_config(key)
    return nil if self.config_hash.blank?
    return self.config_hash[key]
  end


  def get_requisition_model(element,word_css)
    count = element.blank? ? 0 : element.element_id.to_s
    #    status = element.blank? ? 0 : element.status
    config_hash = {}
    config_hash = element.blank? ? {} : element.config_hash
    color= word_css.blank? ? "rgb(0, 0, 0)" : word_css
    result_string = ""
    unless element.blank?
      result_string = JSetting.send("icon_#{element.partial_name}_div",count,color,config_hash)
    end
    return result_string
  end
end

require 'net/http'
require 'uri'
require 'json'
require 'cgi'
require 'open-uri'

class SinaClient

  def self.message_new(id, text, token)
    oauth = SinaClient.gen_oauth(token)
    return WeiboV3::Base.new(oauth).messages_sent({})
  end

  def self.gen_oauth(token)
    oauth = WeiboV3::OAuth2.new.authorize_from_access(token,SNS['re_url'],SNS['appkey'],SNS['appsecret'])
  end
  
  def self.get_info(token, uid)
    oauth = SinaClient.gen_oauth(token) 
    info = JSON.parse(WeiboV3::Base.new(oauth).user(uid).body)
    return  info
  end


  def self.test_effective(uid,token)
    oauth = SinaClient.gen_oauth(token) 
    begin
      WeiboV3::Base.new(oauth).user(uid)
    rescue Exception => e
      return false
    end
    return true
  end

  def self.get_token_expire(token)
    oauth = SinaClient.gen_oauth(token)
    begin
      return JSON.parse(WeiboV3::Base.new(oauth).get_token_info(token).body)["expire_in"]
    rescue Exception => e
      return 0
    end
  end

  def self.get_followers(uid, token, page)
    oauth = SinaClient.gen_oauth(token) 
    query = { :uid => uid, :page => page }
    jsondata = JSON.parse(WeiboV3::Base.new(oauth).followers(query).body)
    return jsondata["users"] || {}
  end
  
  def self.attention_info(source_id, target_id, token)
    begin
      oauth = SinaClient.gen_oauth(token) 
      return JSON.parse(WeiboV3::Base.new(oauth).friendship_show({:source_id => source_id, :target_id => target_id}).body)
    rescue Exception => e
      return false
    end
  end

  def self.short_url(url, token)
    oauth = SinaClient.gen_oauth(token) 
    return JSON.parse(WeiboV3::Base.new(oauth).short_url({:url_long => URI.escape(url)}).body)["urls"][0]["url_short"]
  end

  def self.attention_sina(uid, token)
    oauth = SinaClient.gen_oauth(token) 
    return JSON.parse(WeiboV3::Base.new(oauth).friendship_create(uid).body)
  end

  #返回mid
  def self.get_querymid(id, token)
    oauth = SinaClient.gen_oauth(token)
    return JSON.parse(WeiboV3::Base.new(oauth).querymid({:id => id, :type => 1}).body)["mid"]
  end

  #add focus    #/2/location/geo/address_to_geo 地理位置 address_to_geo

  #地理位置转 lat, lng
  def self.get_geo(token, address, query={})
    oauth = SinaClient.gen_oauth(token) 
    info = JSON.parse(WeiboV3::Base.new(oauth).address_to_geo(address, query).body)
  end

  #加关注 #A关注B, 需要 B的uid和 A的token
  def self.add_focus(uid, token)
    oauth = SinaClient.gen_oauth(token) 
    begin
      content = WeiboV3::Base.new(oauth).friendship_create(uid)
    rescue
      return ""
    end  
    return content.status == 200 ? JSON.parse(content.body)["idstr"] : ""
  end

  def self.merge_data(d)
    data = Hashie::Mash.new
    data.merge!({:user_id=>d["user_id"]})
    data.merge!({:token_session_key=>d["oauth_token"]})
    return data
  end
  def self.merge_info(d)
    user_info = Hashie::Mash.new
    user_info.merge!({:user_id=>d["id"]})
    user_info.merge!({:head_url=>d["profile_image_url"]})
    if !d["gender"].nil? && !d["gender"].blank?
      user_info.merge!({:sex=>d["gender"]=='m' ? 1 : 0})
    else
      user_info.merge!({:sex=>2})
    end
    user_info.merge!({:fans_number=>d["followers_count"]})
    user_info.merge!({:location =>d["location"]})
    user_info.merge!({:friends_count =>d["friends_count"]})
    user_info.merge!({:statuses_count =>d["statuses_count"]})
    user_info.merge!({:description =>d["description"]})
    user_info.merge!({:remark =>d["remark"]})
    user_info.merge!({:name=>d["name"]})
    user_info.merge!({:verified_type=>d["verified_type"]})
    user_info.merge!({:weburl=>"http://weibo.com/"})
    return user_info
  end

  def self.parseSignedRequest(signed_request)
    code = signed_request.split(".")
    encoded_sig = code[0]
    payload = code[1]
    sig = base64decode(encoded_sig)
    data = base64decode(payload)
    d = JSON.parse(data)
    if d['algorithm'].upcase != "HMAC-SHA256"
      return '-1'
    end
    return merge_data(d)
  end
  def self.base64decode(str)
    length = str.length
    i = 4 - length%4
    str = str+'='*i
    str = str.gsub('-', '+').gsub('_',"/")
    str = Base64.decode64(str)
    return str
  end

  def self.put_url(value,imageurl,token)
    oauth = SinaClient.gen_oauth(token) 
    if !imageurl.blank?
      begin
        
        w = WeiboV3::Base.new(oauth).upload("#{URI.escape(value)}", open(imageurl)).body
        return w
      rescue Exception => e
        return WeiboV3::Base.new(oauth).update("#{value}",{}).body
      end
    else
      return WeiboV3::Base.new(oauth).update("#{value}",{}).body
    end
  end

  def self.put_file(value,imageurl,token)
    oauth = SinaClient.gen_oauth(token) 
    if !imageurl.blank?
      begin
        file_path = "#{Rails.root}/public/#{imageurl}".gsub(/\?\w*/, "")
        file = File.open file_path, "rb"
        w = WeiboV3::Base.new(oauth).upload("#{URI.escape(value)}",file).body
        return w
      rescue Exception => e
        return WeiboV3::Base.new(oauth).update("#{value}",{}).body
      end
    else
      return WeiboV3::Base.new(oauth).update("#{value}",{}).body
    end
  end

  # 发固定图片微薄 # 参数file = File.open("asdf/adsf.png", "rb")
  def self.send_with_pic(content, file,token )
    str = CGI::escape(content)
    oauth = SinaClient.gen_oauth(token) 
    begin
      return WeiboV3::Base.new(oauth).upload(str,file)
    rescue Exception => e
      return WeiboV3::Base.new(oauth).update(content,{})
    end
  end

  def self.get_user_info(token,user_id)
    oauth = SinaClient.gen_oauth(token) 
    
    info = JSON.parse(WeiboV3::Base.new(oauth).user(user_id).body)
    return  merge_info(info)
  end
  # #获取关注人的列表
  #  def self.friends_timeline(token,query)
  #    oauth = WeiboV3::OAuth2.new.authorize_from_access(token,r_url)
  #   info = JSON.parse(WeiboV3::Base.new(oauth).friends_timeline(query).body)
  #  end

  # 获取双向关注人的列表
  def self.friends_bilateral(token, query)
    oauth = SinaClient.gen_oauth(token) 
    info = JSON.parse(WeiboV3::Base.new(oauth).friends_bilateral(query).body)
  end

  def self.user_tag(token, uid)
    oauth = SinaClient.gen_oauth(token) 
    info = JSON.parse(WeiboV3::Base.new(oauth).user_tag(uid).body)
  end

  def self.put_status(status,token  )
    oauth = SinaClient.gen_oauth(token) 
    WeiboV3::Base.new(oauth).update(status)
  end

  def self.repost_tweet(token, w_id,content)
    oauth = SinaClient.gen_oauth(token) 
    #WeiboV3::Base.new(oauth).user("1556711993").body
    WeiboV3::Base.new(oauth).repost(w_id,{:status=>content,:is_comment=>0})
  end
  
  def self.comment_tweet(token, w_id,c_coment)
    oauth = SinaClient.gen_oauth(token) 
    WeiboV3::Base.new(oauth).comment(w_id,c_coment)
  end

  def self.sae_post(opts={})
      post_link = opts.delete("post_link")
      res = Net::HTTP.post_form(URI.parse(post_link), opts)
      #return JSON.parse(res.body)
      begin
        return JSON.parse(res.body)
      rescue Exception => e
         puts e.to_s+"====111=="
         return []
      end
  end

  def self.search_weibo(adv_keyword,per_page,page)
    post_link = "http://1.5yiweibosearch1.sinaapp.com/api.php"
      opts = {"post_link" => post_link, "method" => 'search_statuses',  "q" => adv_keyword, "count" => per_page}
      opts["page"] = page
       #statuses = self.sae_post(opts)['statuses']
      begin
        statuses = self.sae_post(opts)['statuses']
      rescue Exception => e
        statuses = {}
      end
  end
  
  def self.newpass(len)
    chars = ("a".."z").to_a + ("A".."Z").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end
  
  def self.newrand(len)
    chars = ("a".."z").to_a + ("A".."Z").to_a
    str = ""
    1.upto(len){ |i| str += chars[rand(chars.size-1)].to_s }
    return str
  end
  
  def self.encryptstr(str)
    arr = str.to_s.split("")
    enstr = ""
    arr.each_with_index do |s, i|
      enstr += newrand(i%2 + 1) + s
    end
    return enstr
  end
  
  def self.decryptstr(enstr)
    str = ""
    en_arr = enstr.split("").in_groups_of(5)
    en_arr.each do |bindarr|
      str += bindarr[1].to_s + bindarr[4]
    end
    return str
  end
  
  def self.encryptuid(str)
    en_recursion(str.split(""))
  end

  def self.en_recursion(array, length = array.length, index = 0, restr = "")
    if length == index
      return restr
    else
      current_value = array[index].to_i
      restr += (current_value*3+7).to_s + newrand(index%2+1)
      return en_recursion(array, length, index+1, restr)
    end
  end

  def self.decryptuid(enstr)
    de_recursion(enstr.scan(/\d+/).each{|m| m[0]})
  end

  def self.de_recursion(array, length = array.length, index = 0, restr = "")
    if length == index
      return restr
    else
      current_value = array[index].to_i
      restr += ((current_value.to_i-7)/3).to_s
      return de_recursion(array, length, index+1, restr)
    end
  end
  # def self.encryptuid(str)
  #   arr = str.split("").collect{ |e| ((e.to_i + 7)%10).to_s }
  #   enstr = ""
  #   arr.each_with_index do |s, i|
  #     enstr += newrand(i%2 + 1) + s
  #   end
  #   return enstr
  # end
  
  # def self.decryptuid(enstr)
  #   strarr = []
  #   en_arr = enstr.split("").in_groups_of(5, false)
  #   en_arr.each do |bindarr|
  #     strarr << bindarr[1] if bindarr[1]
  #     strarr << bindarr[4] if bindarr[4]
  #   end
  #   return strarr.collect{ |e| (e.to_i + 3)%10 }.join("")
  # end
end

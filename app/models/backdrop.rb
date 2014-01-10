class Backdrop < ActiveRecord::Base
  # attr_accessible :title, :body
  has_attached_file :avatar, 
  { 
      :storage => :upyun, 
      # Please set these four options found in your upyun account.
      :upyun_bucketname => 'weibo-wall',
      :upyun_username => 'jker',
      :upyun_password => 'qq123456',
      :upyun_domain => 'weibo-wall.b0.upaiyun.com'
    }
  before_create :randomize_file_name

  def self.save_back_image(file)
    file.content_type = MIME::Types.type_for(file.original_filename).to_s
    back = Backdrop.new
    back.avatar = file
    back.save
    back
  end

  def get_image(type = nil)
    if type
      return "http://"+self.avatar.url.gsub(/\?\d*/, "")+"!#{type}"
    else
      return "http://"+self.avatar.url
    end
  end


private  
  def randomize_file_name  
    #archives 就是你在 has_attached_file :archives 使用的名字  
    extension = File.extname(avatar_file_name).downcase  
   #你可以改成你想要的文件名，把下面这个方法的第二个参数随便改了就可以了。  
    self.avatar.instance_write(:file_name, "p_i_#{Time.now.strftime("%Y%m%d%H%M%S")}#{extension}")  
  end  
end

class Attach < ActiveRecord::Base
  # attr_accessible :title, :body
  has_attached_file :avatar
  before_create :randomize_file_name


  def self.img_save(apply_ele)
    if apply_ele
      apply_ele.each do |ele|
        if ele[1]["type"] == "file" && !apply_ele[ele[0]]["value"].blank?
          a_img = []
          img  = Attach.new
          img.avatar = apply_ele[ele[0]]["value"]
          img.save
          a_img << img.id << apply_ele[ele[0]]["value"].original_filename
          apply_ele[ele[0]]["value"] = a_img
        end
      end
    end
    return apply_ele
  end

private
  def randomize_file_name  
    #archives 就是你在 has_attached_file :archives 使用的名字  
    extension = File.extname(avatar_file_name).downcase  
   #你可以改成你想要的文件名，把下面这个方法的第二个参数随便改了就可以了。  
    self.avatar.instance_write(:file_name, "p_i_#{Time.now.strftime("%Y%m%d%H%M%S")}#{extension}")  
  end  

end

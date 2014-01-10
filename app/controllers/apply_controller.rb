class ApplyController < ApplicationController
	before_filter :find_apply
	include ApplicationHelper
  def index
  	if @apply
      @situation = params[:situation]
      @lists = List.where("apply_info_id = ? and status = 2", @apply.id).includes(:user)
  	end
  end

  def submit_form
    users = RedisClient.get_apply_to_user_array(@apply.id)
    if users.include?(@user.id.to_s)
      redirect_to resession_link("/apply/index?situation=exist")
    else
      list = params[:list]

      focus_on(list)

      list = Attach.img_save(list)      

      PostInfo.save_content(list, @apply.company_id, @apply.id, @user.id)
      RedisClient.update_apply_to_user_count(@apply.company_id, @apply.id) 
      RedisClient.update_apply_to_user(@apply.id, @user.id)
      redirect_to resession_link("/apply/index?situation=sucess")
    end
  end


private

  def change_content(content, img)
    src_content = content

    img.each do |key, val|
      img_new = [] 
      img_new << val[0].id << val[1] << val[0].avatar.url << key
      src_content["#{key}"] = img_new
    end
    return src_content
  end
  
  def focus_on(elements)
    if elements
      elements.each do |ele|
        if ele[1]["type"] == "attention" && @company != @user
          SinaClient.add_focus(@company.cid, @user.sns_token) 
        end
      end
    end
  end
end

class PostInfo < ActiveRecord::Base
  attr_accessible :apply_info_id, :comany_id, :user_id, :content
  belongs_to  :apply_info 
  belongs_to  :comany
  belongs_to	:user
  serialize :content
  scope :get_list,->(company_id, apply_info_id) { where("company_id = ? and apply_info_id = ?", company_id, apply_info_id) }
  scope :get_list_users,->(company_id, apply_info_id, user_ids) { where("company_id = ? and apply_info_id = ? and user_id in(?)", company_id, apply_info_id, user_ids) }
  
  def self.save_content(content, company_id, apply_info_id, user_id)
    post = PostInfo.new
    post.apply_info_id = apply_info_id
    post.company_id = company_id
    post.user_id = user_id
    post.content = content
    post.status = 0 
    post.save
  end
end

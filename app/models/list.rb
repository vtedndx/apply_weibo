class List < ActiveRecord::Base
  attr_accessible :apply_info_id, :company_id, :status, :user_id
  belongs_to  :apply_info 
  belongs_to  :user
  belongs_to  :company
  scope :get_status,->(status) { where("status in(?)", status).includes(:user) }
  scope :get_ids, ->(ids) { where("id in(?)", ids).includes(:user) }
  scope :get_list,->(company_id, apply_info_id) { where("company_id = ? and apply_info_id = ?", company_id, apply_info_id) }
  scope :get_id,->(company_id, apply_info_id, id) { where("company_id = ? and apply_info_id = ? and id = ?", company_id, apply_info_id, id) }
  scope :get_u_id, ->(company_id, apply_info_id, user_id) { where("company_id = ? and apply_info_id = ? and user_id = ?", company_id, apply_info_id, user_id) }

  def self.save_list(company_id, apply_info_id, user_id)
  	list = List.new
  	list.company_id = company_id
  	list.apply_info_id = apply_info_id
  	list.user_id = user_id
  	list.status = 0
  	list.save
  	list
  end

  def del_list
  	self.update_attribute :status, 1
  end

  def add_list
    self.update_attribute :status, 0
  end

  def self.release_list(company_id, apply)
  	list = List.get_list(company_id, apply.id).get_status([0, 2])
  	list.each do |l|
  		l.status = 2
  		l.save
  	end

    apply.set_config("release", list.collect(&:id))
  end
end

class ApplyInfo < ActiveRecord::Base
  attr_accessible :backdrop_id, :company_id, :config_hash, :img_url, :name, :share, :status
  has_many :apply_elements
  has_many :lists
  has_many :post_infos
  scope :get_id, ->(company_id, id) { where("company_id = ? and id = ?", company_id, id) }
  scope :get_status, ->(status) { where("status in(?)", status) }
  scope :get_apply, ->(company_id, status) { where("company_id = ? and status in(?)", company_id, status) }
  serialize :config_hash
  
  include ApplicationHelper 

  def get_image(type = nil)
    if type
      return self.img_url.gsub(/\?\d*/, "")+"!#{type}"
    else
      return self.img_url
    end
  end

  def self.save_apply(company, title, share)
  	ai = ApplyInfo.new
  	ai.company_id = company.id
  	ai.name = title
  	ai.share = share
    hash = {}
    hash["top_left"] = "left: 162px; top: 65px;"
    hash["form_color"] = "#0000ff"
    hash["writing_color"] = "#ff0000"
    hash["button_color"] = "#00ff00"
    hash["opacity"] = "60"
    hash["height"] = "height: 785px;"
    hash["img_show"] = "0"
    ai.config_hash = hash
  	ai.status = 0
  	ai.save
  	ai
  end

  def set_config(key, value, key_2 = nil)
    self.config_hash ||= {}
    self.config_hash[key] ||= {}
    if !key_2.blank?
      self.config_hash[key][key_2] = value
    else
      self.config_hash[key] = value
    end
    self.save
  end

  def save_config(form_color, writing_color, button_color, opacity, height, top_left, list)
    self.config_hash["form_color"] = form_color
    self.config_hash["writing_color"] = writing_color
    self.config_hash["button_color"] = button_color
    self.config_hash["opacity"] = opacity
    self.config_hash["height"] = height
    self.config_hash["top_left"] = top_left
    self.config_hash["list"] = list
    self.save
  end

  def get_config(key_1, key_2 = nil)
    return nil if self.config_hash.blank?
    return self.config_hash[key_1][key_2] if !key_2.blank?
    return self.config_hash[key_1]
  end

  def save_back(img)
    self.update_attribute :backdrop_id, img.id
    self.update_attribute :img_url, img.get_image
  end

  def edit_apply(title)
    self.update_attribute :name, title
  end

  def del_apply
    self.update_attribute :status, 1
  end
end

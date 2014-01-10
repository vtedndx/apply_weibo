class Company < ActiveRecord::Base
  attr_accessible :cid, :config_hash, :expires_at, :sns_token, :sns_uimg, :sns_uname, :sub_appkey
  serialize :config_hash

  def self.find_or_create_by_cid(cid)
    company = Company.find_by_cid(cid) 
    if company
      return company
    else
      company = Company.new
      company.cid = cid
      # company.init_config
      company.save
      return company
    end
  end

  def self.save_user_company(user, token)
    company = Company.find_by_cid(user.sns_uid)
    if company
      company.sns_uname = user.sns_uname
      company.sns_uimg = user.sns_uimg
      company.sns_token = token
      company.save
    else
      return company
    end
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

  def save_company_info(signed)
    signed_token = signed["token_session_key"]
    user_info = SinaClient.get_user_info(signed_token, signed["user_id"])
    self.update_attributes(:sns_uname => user_info["name"], :sns_uimg => user_info["head_url"])
  end
end

class User < ActiveRecord::Base
  attr_accessible :description, :expires_at, :fans, :friends, :label, :location, :remark, :sns_token, :sns_uid, :sns_uimg, :sns_uname, :statuses, :verified_type, :gender
  scope :is_v, ->(value) { where("verified_type in(?)", value)}
  scope :not_v, ->(value) {where("verified_type not in(?)", value)}
  scope :girl_boy, ->(sex) { where("gender = ?", sex) }
  scope :province_city, ->(location) { where("location = ?", location) }
  scope :no_value, ->(value) { where("1 = ?", value) }



  def self.find_or_create_by(sns_uid)
    user = User.where(:sns_uid => sns_uid).first
    user ||= User.create(:sns_uid => sns_uid)
    return user
  end
  
  def self.save_user_oauth(viewer, tokenString)
    user = User.find_by_sns_uid(viewer)
    user ||= User.create(:sns_uid => viewer)
    uid_token = SinaClient.parseSignedRequest(tokenString)
    token = uid_token[:token_session_key]
    uid = uid_token["user_id"]

    if token.blank?
      Rails.logger.info "-----1-----"
      #Rails.logger.info "----token--- ----------------------- -- - - - - -- -new uid/cid"
      user.sns_token = ""
      user.save
      return user
    elsif user.expires_at.blank? || user.expires_at < Time.now + 1.day
      #Rails.logger.info "----token--- ----------------------- -- - - - - -- -not new, but need save"
  Rails.logger.info "----2-----"
      sns_user = SinaClient.get_user_info(token, uid)
      expire_in = SinaClient.get_token_expire(token)
      expire_at = Time.now + (expire_in-300).seconds
      user.save_info(sns_user, expire_at, token)
      Rails.logger.info "-----#{user.sns_token}-----"
      Company.save_user_company(user, token)
      return user
    elsif user.sns_token != token
      #Rails.logger.info "----token--- ----------------------- -- - - - - -- -old user, new cid,  need not  save"
  Rails.logger.info "----3-----"
      user.sns_token = token 
      user.save
      Rails.logger.info "-----#{user.sns_token}-----"
      return user
    else
      #Rails.logger.info "----token--- ----------------------- -- - - - - -- -all same"
  Rails.logger.info "----4---#{token}--#{user.sns_token}"
      return user
    end
    return user
  end

  def save_info(sns_user, expire_at, token)
    self.sns_uid = sns_user["user_id"]
    self.sns_token = token
    self.sns_uname = sns_user["name"]
    self.sns_uimg = sns_user["head_url"]
    self.fans = sns_user["fans_number"]
    self.location = sns_user["location"]
    self.friends = sns_user["friends_count"]
    self.statuses = sns_user["statuses_count"]
    self.description = sns_user["description"]
    self.verified_type = sns_user["verified_type"]
    self.gender = sns_user["sex"]
    self.expires_at = expire_at
    self.save
  end

  def self.sina_get_user_info(tokenString)
  	uid_token = SinaClient.parseSignedRequest(tokenString)
  	return SinaClient.get_user_info(uid_token["token_session_key"], uid_token["user_id"])
  end

  def self.save_or_update_user(sns_user, token)
    user = User.find_by_sns_uid(sns_user["user_id"])
    user ||= User.new

    expire_in = SinaClient.get_token_expire(token)
    expire_at = Time.now + (expire_in-300).seconds
    user.save_info(sns_user, expire_at, token)
    return user
  end

  def token_valid?
    return !self.sns_token.blank? && self.expires_at && self.expires_at > Time.now
  end
end

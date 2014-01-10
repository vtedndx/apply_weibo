class Visitor < ActiveRecord::Base
  attr_accessible :sns_uid, :sns_uimg, :sns_uname, :company_id


  def self.default_uimg
    "http://img.t.sinajs.cn/t4/style/images/face/male_medium.png"
  end


  def self.weibo_home(sns_uid)
    "http://www.weibo.com/u/#{sns_uid}"
  end

  def weibo_home
    "http://www.weibo.com/u/#{self.sns_uid}"
  end

  def self.add_record(company_id, sns_uid)
    ex = Visitor.exists?(:company_id => company_id, :sns_uid => sns_uid)
    if !ex
      vi = Visitor.new(:company_id => company_id, :sns_uid => sns_uid)
      vi.save
    end
  end





end

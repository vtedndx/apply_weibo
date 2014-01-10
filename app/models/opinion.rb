class Opinion < ActiveRecord::Base
  attr_accessible :company_id, :desp, :sns_uimg, :sns_uname

  def self.save_opinion(company, desp)
  	o = Opinion.new
  	o.desp = desp
  	o.company_id = company.id
  	o.sns_uimg = company.sns_uimg
  	o.sns_uname = company.sns_uname
  	o.save
  end
end

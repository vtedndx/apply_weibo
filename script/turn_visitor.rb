




ans = PostInfo.where("id > 0").order("id ASC")
users = User.where("id in(?)", ans.collect{|e|e.user_id})
ans.each do |an|
	user = users.select{|e|e.id == an.user_id}.first
	if user
		vi = Visitor.where(:company_id => an.company_id , :sns_uid => user.sns_uid).first
		vi ||= Visitor.new(:company_id => an.company_id , :sns_uid => user.sns_uid)
		vi.sns_uimg = user.sns_uimg
		vi.sns_uname = user.sns_uname
		vi.save
		puts "====saving=====#{vi.id}"
	end
end


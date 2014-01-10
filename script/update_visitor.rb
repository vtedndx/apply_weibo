
#do every_ 5minutes
$log = File.open("#{Rails.root.to_s}/log/update_visitor.log", "a+")

@user = User.where("sns_token != '' and sns_token is not null and expires_at > ? ", Time.now).first
@token = @user.sns_token

vis = Visitor.where("sns_uimg is null").limit(200)
vis.each do |vi|
	info = SinaClient.get_info(@token, vi.sns_uid)
	vi.sns_uimg = info["profile_image_url"]
	vi.sns_uname = info["name"]
	vi.save
end


$log.puts "===============#{Time.now.to_s}===============do about vis.size = #{vis.size}========"
$log.close
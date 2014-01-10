

ef = File.open("#{Rails.root}/ea.txt", "a+")
enf = File.open("#{Rails.root}/eb.txt", "a+")

arr  = []
File.open("#{Rails.root}/email_no.txt", "r") do |file|
	file.each_line do |line|
		arr << line.gsub(/\n/,"")
	end
end

coms = Company.where("cid not in (?)" , arr )
coms.each do |com|
		if com.config_hash["email"].to_s =~ /@/
			ef.puts com.config_hash["email"]
			enf.puts com.config_hash["email"] + "_" + com.sns_uname.to_s
		else
		end
end

ef.close 
enf.close 
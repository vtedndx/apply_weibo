class RedisClient
	def self.update_or_get_apply_id(company_id)
		$redis.zincrby("apply", 1, company_id)
		return $redis.zscore("apply", company_id).to_i
	end

	def self.update_apply_to_user_count(company_id, apply_id)
		$redis.zincrby("#{company_id}_a_uc", 1, apply_id)
	end

	def self.get_apply_to_user_count(company_id, apply_id)
		$redis.zscore("#{company_id}_a_uc", apply_id).to_i
	end

	def self.update_apply_to_user(apply_id, user_id)
		$redis.zincrby("#{apply_id}_a_u", 1, user_id)
	end

	def self.get_apply_to_user_array(apply_id)
		$redis.zrange("#{apply_id}_a_u", 0, -1).to_a
	end

	def self.get_apply_to_user_array_order(apply_id)
		$redis.zrevrange("#{apply_id}_a_u", 0, -1).to_a
	end
end

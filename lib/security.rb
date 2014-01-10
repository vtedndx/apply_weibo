
class Security
	
	#define your SECURITY_KEY in initializers
	SECURITY_KEY = '40de872eed7970964c0ef81567b2c6f95448b257d1a2fc4c0fa7b5a78eef68e0f21d087dcd6b3542'

	def self.encrypt_str(str)
		enstr = Digest::SHA1.hexdigest(SECURITY_KEY + str)
	end
	
	def self.check(enstr, str)
		enstr == Digest::SHA1.hexdigest(SECURITY_KEY + str)
	end

	
end

class User < ActiveRecord::Base

	validates_presence_of :name
	validates_presence_of :email
	validates_presence_of :password_digest

	validates_uniqueness_of :email

	def generate_token
		Digest::SHA2.hexdigest([Time.now, rand].join)[0..10]
	end
end

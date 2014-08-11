class User < ActiveRecord::Base
	has_many :postings
	has_many :comments

	validates_presence_of :name
	validates_presence_of :email
	validates_uniqueness_of :email
	validates_presence_of :password

	# has_secure_password
end

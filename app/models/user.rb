class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :admin
#  has_secure_password

#   default_scope :conditions => 'admin is not null' 

   acts_as_authentic do | config |
    config.logged_in_timeout = 2.minutes
   end


  before_save { |user| user.email = email.downcase }
#  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

 # private
 # def create_remember_token
 #   self.remember_token = SecureRandom.urlsafe_base64
 # end
end

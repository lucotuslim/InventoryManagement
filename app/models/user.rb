class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :admin

  attr_accessor :updating_password
#  has_secure_password

#   default_scope :conditions => 'admin is not null' 

   acts_as_authentic do | config |
    config.logged_in_timeout = 15.minutes
   end

  before_save { |user| user.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 } , :if => :should_validate_password?
  validates :password_confirmation, presence: true , :if => :should_validate_password?


  def should_validate_password?
    updating_password || new_record?
  end

end

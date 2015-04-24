class User < ActiveRecord::Base
  before_save { email.downcase! }
  validates :name, presence: true, length: {maximum: 20}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, uniqueness: { case_sensitive: false },
   presence: true, length: {maximum: 52}, 
      format: { with: VALID_EMAIL_REGEX }
  has_secure_password
  validates :password, length: {minimum: 6}
end

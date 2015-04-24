class User < ActiveRecord::Base
  validates :name, presence: true, length: {maximum: 20}
  validates :email, presence: true, length: {maximum: 52}
end

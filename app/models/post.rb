class Post < ActiveRecord::Base
  # set relationships of models
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  # create validations requiring and restricting inputs
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  # validates_exclusion_of :format, :in => ("##") :if User.role?
end

class User < ActiveRecord::Base
  # create relationship to posts corresponding posts delete when user destroyed
  has_many :posts, dependent: :destroy
  # turns all email inputs to lowercase format for save
  before_save { email.downcase! }
  # prevents name larger than 20 characters and requires name
  validates :name, presence: true, length: {maximum: 20}
  # regex preventing improper format of email input, require and limit length to 50 including url
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, uniqueness: { case_sensitive: false },
   presence: true, length: {maximum: 52}, 
      format: { with: VALID_EMAIL_REGEX }
      # uses b crypt and password digest and requires minimum of 6 characters
  has_secure_password
  validates :password, length: {minimum: 6}, allow_blank: true
# create feed
  def feed
    posts
  end
  # add picture uploader for user image
  mount_uploader :picture, PictureUploader
  # validate :picture_size

  private
  # cancelled call due to error, defined size limitations
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end

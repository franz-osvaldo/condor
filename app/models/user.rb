class User < ApplicationRecord
  belongs_to :occupation
  has_many :bug_reports
  has_many :borrowed_tools
  has_many :returned_tools
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name,  presence: true,
            length: {maximum: 50}
  validates :email, presence: true,
            length: {maximum: 250},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  validates :password, presence: true,
            length: { minimum: 6 }
  before_save { self.email = email.downcase }
  has_secure_password

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/images/:style/user_missing.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

end


class User < ActiveRecord::Base
  attr_accessor :password
  validates :name, presence: true
  validates :lastName, presence: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, confirmation: true
  validates :email, uniqueness: true
  validates :email_confirmation, presence: true
  belongs_to :level
  belongs_to :success
  belongs_to :address
  has_many :services
  def self.authenticate_safely(email, password)
    where("email = ? AND password = ?", email, password).first
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
end

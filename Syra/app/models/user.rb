class User < ActiveRecord::Base
  attr_accessor :password
  #attr_accessible :name, :email, :password, :password_confirmation
  
  validates :name, presence: true
  validates :lastName, presence: true
  #validates :password, confirmation: true
  #validates :password_confirmation, presence: true
  validates :email, confirmation: true
  validates :email, uniqueness: true
  validates :email_confirmation, presence: true
  belongs_to :level
  belongs_to :success
  belongs_to :address
  has_many :services
  def self.authenticate_safely(user_name, password)
       where("user_name = ? AND password = ?", user_name, password).first
  end

end

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
  has_and_belongs_to_many :hobbies
  def self.authenticate_safely(email, password)
    where("email = ? AND password = ?", email, password).first
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  before_save :encrypt_password

  def has_password?(password_soumis)
    encrypted_password == encrypt(password_soumis)
  end

    private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    
end

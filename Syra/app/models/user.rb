class User < ActiveRecord::Base
  attr_accessor :password
  validates :name, presence: true ,:presence => {:message => 'Vous devez indiquer un prénom'}
  validates :lastName, presence: true ,:presence => {:message => 'Vous devez indiquer un nom'}
  validates :password, confirmation: true, :confirmation => {:message => 'Les mots de passe ne correspondent pas'}
  validates :password_confirmation, presence: true , :presence => {:message => 'Vous devez confirmer votre mot de passe'}
  validates :email, confirmation: true, :confirmation => {:message => 'Les emails ne correspondent pas'}
  validates :email, uniqueness: true , :uniqueness => {:message => 'Votre email est déjà pris'}
  validates :email_confirmation, presence: true , :presence => {:message => 'Vous devez confirmer votre email'}
  belongs_to :level
  belongs_to :success
  belongs_to :address
  has_many :services
  has_and_belongs_to_many :hobbies
  def self.authenticate_safely(email, password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(password)    
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

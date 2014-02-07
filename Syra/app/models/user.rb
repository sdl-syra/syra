class User < ActiveRecord::Base

  has_many :relationships, :dependent => :destroy, :foreign_key => "follower_id"
  has_many :following, :through => :relationships, :source => :followed

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :password
  validates :name, presence: true ,:presence => {:message => 'Vous devez indiquer un prénom'}
  validates :lastName, presence: true ,:presence => {:message => 'Vous devez indiquer un nom'}
  validates :password, confirmation: true, :confirmation => {:message => 'Les mots de passe ne correspondent pas'}
  validates :password_confirmation, presence: true , :presence => {:on => :create, :message => 'Vous devez confirmer votre mot de passe'}
  validates :email, confirmation: true, :confirmation => {:message => 'Les emails ne correspondent pas'}
  validates :email, uniqueness: true , :uniqueness => {:message => 'Votre email est déjà pris'}
  validates :email_confirmation, presence: true , :presence => {:on => :create, :message => 'Vous devez confirmer votre email'}
  belongs_to :level
  belongs_to :success
  belongs_to :address 
  has_many :services
  has_and_belongs_to_many :hobbies
  has_many :authentifications, :dependent => :delete_all
  
  def apply_omniauth(auth)
    
    self.email = auth['extra']['raw_info']['email']
    self.name = auth['extra']['raw_info']['first_name']
    self.lastName = auth['extra']['raw_info']['last_name']
    
    authentifications.build(:provider => auth['provider'], :uid => auth['uid'])
  end

  def self.authenticate_facebook(email)
    user = find_by_email(email)
    return nil  if user.nil?
    return user
  end

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

  def following?(followed)
    relationships.find_by_followed_id(followed)
  end
  
  def follow!(followed)
    relationships.create!(:followed_id => followed.object_id)
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

class User < ActiveRecord::Base

  has_many :relationships, :dependent => :destroy, :foreign_key => "follower_id"
  has_many :reverse_relationships, :dependent => :destroy, :foreign_key => "followed_id",:class_name => "Relationship"
  has_many :following, :through => :relationships, :source => :followed
  has_many :follower, :through => :reverse_relationships, :source => :follower
  has_many :services
  has_many :propositions

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
  validates :phone, allow_nil: true, numericality: { only_integer: true, :message => "Format incorrect" }, :length => { :minimum => 10, :maximum =>10, :message => "Format incorrect" }
  validates :accept_conditions, :inclusion => {:in => [true]}
  belongs_to :level
  belongs_to :success
  belongs_to :address
  has_many :services
  has_and_belongs_to_many :hobbies
  has_many :authentifications, :dependent => :delete_all
  acts_as_birthday :birthday
  def apply_omniauth(auth)

    self.email = auth['extra']['raw_info']['email']
    self.name = auth['extra']['raw_info']['first_name']
    self.lastName = auth['extra']['raw_info']['last_name']
    
    #a reparer quand l'image sera op
    self.avatar = auth[:info][:image]
    #self.save

    authentifications.build(:provider => auth['provider'], :uid => auth['uid'])
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def self.authenticate_facebook(email)
    user = find_by_email(email)
    return nil  if user.nil?
    return user
  end

  def self.authenticate_safely(email, password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(password,user.encrypted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  before_save :encrypt_password

  def has_password?(password_soumis,password)
    password == encrypt(password_soumis)
  end

  def following?(followed)
    relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
    relationships.create!(:followed_id => followed)
  end

  def followedBy?(follower)
    Relationship.find_by follower_id: follower, followed_id: self.id
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  private

  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password) if not password.nil?
  end

  def encrypt(string)
    secure_hash(string)
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

end

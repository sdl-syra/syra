class User < ActiveRecord::Base

  has_many :relationships, :dependent => :destroy, :foreign_key => "follower_id"
  has_many :reverse_relationships, :dependent => :destroy, :foreign_key => "followed_id",:class_name => "Relationship"
  has_many :following, :through => :relationships, :source => :followed
  has_many :follower, :through => :reverse_relationships, :source => :follower
  has_many :services
  has_many :propositions
  has_many :reports

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :password
  validates_presence_of :name
  validates_presence_of :lastName
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_length_of :password, :minimum => 8, :on => :create
  validates :accept_conditions, :inclusion => {:in => [true]}

  belongs_to :level
  belongs_to :address

  has_and_belongs_to_many :hobbies
  has_and_belongs_to_many :badges
  
  
  has_many :authentifications, :dependent => :delete_all

  def apply_omniauth(auth)

    self.email = auth['extra']['raw_info']['email']
    self.name = auth['extra']['raw_info']['first_name']
    self.lastName = auth['extra']['raw_info']['last_name']
    
    #a reparer quand l'image sera op
    #puts "test"
    self.avatar = auth[:info][:image] 
    self.save

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
    rs = relationships.create!(:followed_id => followed)
    rs.favorite = false
    rs.save
  end

  def favor!(followed)
    rs = relationships.where(:followed_id => followed,:follower_id => self.id).first
    rs.favorite = true
    rs.save

  end
  
  def unfollow!(followed)
    relationships.where(:followed_id => followed).destroy_all
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

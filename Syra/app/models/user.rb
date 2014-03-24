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
  validates :phone, allow_nil: true, numericality: { only_integer: true, :message => "Format incorrect" }
  validates :accept_conditions, :inclusion => {:in => [true]}
  belongs_to :level
  belongs_to :success
  belongs_to :address 
  has_many :services
  has_and_belongs_to_many :hobbies
  has_many :authentifications, :dependent => :delete_all
  acts_as_birthday :birthday 
  
  mount_uploader :avatar, ProfilAvatarUploader 
  
  before_save :default_values
  after_save :delete_default_image
  
  def default_values    
    if self.avatar_changed? and self.avatar_was.to_s!="/assets/image/avatar_profil_default.png"
      delete_old_images
    end
  end
  
  # supprime les images contenues dans le dossier
  def delete_old_images  
    imgDir = "public/uploads/user/avatar/" + self.id.to_s
    accepted_formats = [".jpg", ".jpeg", ".png", ".gif"]
    # pour chaque fichier
    Dir.foreach(imgDir) do |file|
       if accepted_formats.include? File.extname(file.to_s)
          File.unlink("#{imgDir}/#{file}")
       end
    end
  end
  
  # supprime l'image uploade(grand format) pour ne conserver que les versions "thumb" et "index"
  def delete_default_image 
    if self.avatar_url.to_s!="/assets/image/avatar_profil_default.png"
      imgDir = "public/uploads/user/avatar/" + self.id.to_s
      accepted_formats = [".jpg", ".jpeg", ".png", ".gif"]
      # pour chaque fichier
      Dir.foreach(imgDir) do |file|
         if !file.to_s.include?("thumb_") and !file.to_s.include?("index_") and accepted_formats.include? File.extname(file.to_s)
              File.unlink("#{imgDir}/#{file}")
         end
      end
    end
  end
  
  def apply_omniauth(auth)
    
    self.email = auth['extra']['raw_info']['email']
    self.name = auth['extra']['raw_info']['first_name']
    self.lastName = auth['extra']['raw_info']['last_name']
    self.remote_avatar_url = auth[:info][:image]
    
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
    relationships.create!(:followed_id => followed)
  end

  def followedBy?(follower)
   Relationship.find_by follower_id: follower, followed_id: self.id
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

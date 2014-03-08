class Service < ActiveRecord::Base
  include ActiveModel::Dirty

  validates :title, presence: true ,:presence => {:message => 'Vous devez indiquer un titre'}
  validates :category_id, presence: true ,:presence => {:message => 'Vous devez choisir une catégorie'}
  validates :description, presence: true ,:presence => {:message => 'Vous devez indiquer une description'}
  validates :address, presence: true ,:presence => {:message => 'Vous devez indiquer une adresse'}
  validates :price, presence: true ,:presence => {:message => 'Vous devez indiquer un prix'}
  validates :price, :numericality => {:only_integer => true}, :numericality => {:message => '$("input.numeric").numeric() à intégrer'}

  # belongs_to :address
  belongs_to :category
  belongs_to :user
  
  mount_uploader :image, ServiceImageUploader
  
  before_save :default_values
  after_save :delete_default_image
  
  def default_values    
    # self.address = self.user.address if self.address.nil?
    self.isGiven = 0 if self.isGiven.nil?
    self.isFinished = 0 if self.isFinished.nil?
    if self.image_changed? and self.image_was.to_s!="/uploads/service/image/placeholder/default.png"
      delete_old_images
    end
  end
  
  # supprime les images contenues dans le dossier
  def delete_old_images  
    imgDir = "public/uploads/service/image/" + self.id.to_s
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
    if self.image_url.to_s!="/uploads/service/image/placeholder/default.png"
      imgDir = "public/uploads/service/image/" + self.id.to_s
      accepted_formats = [".jpg", ".jpeg", ".png", ".gif"]
      # pour chaque fichier
      Dir.foreach(imgDir) do |file|
         if !file.to_s.include?("thumb_") and !file.to_s.include?("index_") and accepted_formats.include? File.extname(file.to_s)
              File.unlink("#{imgDir}/#{file}")
         end
      end
    end
  end
  
end

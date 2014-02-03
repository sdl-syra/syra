class Service < ActiveRecord::Base

  validates :title, presence: true ,:presence => {:message => 'Vous devez indiquer un titre'}
  validates :category_id, presence: true ,:presence => {:message => 'Vous devez choisir une catégorie'}
  validates :description, presence: true ,:presence => {:message => 'Vous devez indiquer une description'}
  validates :price, presence: true ,:presence => {:message => 'Vous devez indiquer un prix'}
  validates :price, :numericality => {:only_integer => true}, :numericality => {:message => '$("input.numeric").numeric() à intégrer'}

  belongs_to :address
  belongs_to :category
  belongs_to :user
  
  before_save :default_values
  def default_values
    self.isGiven = 0 if self.isGiven.nil?
    self.isFinished = 0 if self.isFinished.nil?
  end
end

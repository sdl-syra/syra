class Service < ActiveRecord::Base
  include ActiveModel::Dirty
  paginates_per 2

  validates :title, presence: true ,:presence => {:message => 'Vous devez indiquer un titre'}
  validates :category_id, presence: true ,:presence => {:message => 'Vous devez choisir une catégorie'}
  validates :description, presence: true ,:presence => {:message => 'Vous devez indiquer une description'}
  validates :address_id, presence: true ,:presence => {:message => 'Vous devez indiquer une adresse'}
  validates :price, presence: true ,:presence => {:message => 'Vous devez indiquer un prix'}
  validates :price, :numericality => {:only_integer => true}, :numericality => {:message => '$("input.numeric").numeric() à intégrer'}

  belongs_to :address
  belongs_to :category
  belongs_to :user
  has_many :propositions


end

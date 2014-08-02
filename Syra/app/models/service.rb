class Service < ActiveRecord::Base
  include ActiveModel::Dirty
  paginates_per 2

  validates :title, presence: true ,:presence => {:message => 'Vous devez indiquer un titre'}
  validates :category_id, presence: true ,:presence => {:message => 'Vous devez choisir une catégorie'}
  validates :isGiven, :inclusion => { :in => [true,false], :message => 'Vous devez choisir un type de service'}
  validates :description, presence: true ,:presence => {:message => 'Vous devez indiquer une description'}
  validates :address_id, presence: true ,:presence => {:message => 'Vous devez indiquer une adresse'}
  validates :price, presence: true ,:presence => {:message => 'Vous devez indiquer un prix'}
  validates :price, :inclusion => { :in => 1..1.0/0, :message => "Vous devez indiquer un prix supérieur à 0"}
#  validates :price, :numericality => {:only_integer => true}, :numericality => {:message => '$("input.numeric").numeric() à intégrer'}

  belongs_to :address
  belongs_to :category
  belongs_to :user
  has_many :propositions


end

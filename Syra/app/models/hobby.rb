class Hobby < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :treads
end

class Service < ActiveRecord::Base
  belongs_to :address
  belongs_to :category
  belongs_to :user
end

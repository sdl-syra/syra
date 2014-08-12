class Tread < ActiveRecord::Base
  belongs_to :hobby
  belongs_to :user
  has_many :replies
end

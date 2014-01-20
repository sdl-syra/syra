class User < ActiveRecord::Base
  belongs_to :level
  belongs_to :success
  belongs_to :address
end

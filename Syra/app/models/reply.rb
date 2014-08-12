class Reply < ActiveRecord::Base
  belongs_to :tread
  belongs_to :user
end

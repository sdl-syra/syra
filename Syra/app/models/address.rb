class Address < ActiveRecord::Base
  validates :number, allow_nil: true, numericality: { only_integer: true, :message => "Format incorrect" }
  validates :postalCode, allow_nil: true, numericality: { only_integer: true, :message => "Format incorrect" }
end

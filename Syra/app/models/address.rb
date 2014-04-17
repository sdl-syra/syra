class Address < ActiveRecord::Base

	def <=> (another_address)
		self.distance <=> another_address.distance
	end
end
class Category < ApplicationRecord
	extend FriendlyId
	mount_uploader :image, CategoryUploader

	friendly_id :name, use: :slugged
	has_many :works

	def self.sort_by_position
		order(position: :asc)
	end

end

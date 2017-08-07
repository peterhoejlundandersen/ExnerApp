class Image < ApplicationRecord
	mount_uploader :image, ImageUploader
	belongs_to :image_category
	#scope
	default_scope { order(:position) }
	scope :published, -> { where(draft: false) }
end

class Image < ApplicationRecord
	mount_uploader :image, ImageUploader
	belongs_to :image_category
	default_scope { order(:position) }
end

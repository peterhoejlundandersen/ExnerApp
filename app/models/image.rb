class Image < ApplicationRecord
	mount_uploader :image, ImageUploader
	belongs_to :image_category
end

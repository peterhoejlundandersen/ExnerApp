class Image < ApplicationRecord
	mount_uploader :image, ImageUploader
	belongs_to :image_category
	validates :image, presence: true
end

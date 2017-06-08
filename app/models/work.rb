class Work < ActiveRecord::Base
	extend FriendlyId
	mount_uploader :overview_img, OverviewImgUploader
	friendly_id :name, use: :slugged
	belongs_to :category
	has_many :infos
	has_many :image_categories
	has_many :images, through: :image_categories
	accepts_nested_attributes_for :image_categories, allow_destroy: true
	accepts_nested_attributes_for :infos, allow_destroy: true
end

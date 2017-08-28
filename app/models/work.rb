class Work < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	mount_uploader :overview_img, OverviewUploader
	belongs_to :category
	has_many :infos
	has_many :image_categories, -> { order(position: :asc) } 
	has_many :images, through: :image_categories
	accepts_nested_attributes_for :image_categories, allow_destroy: true
	accepts_nested_attributes_for :infos, allow_destroy: true
	default_scope { order(position: :asc)}
end

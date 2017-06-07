class Work < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	belongs_to :category
	has_many :image_categories
	has_many :images, through: :image_categories
	has_many :infos
	accepts_nested_attributes_for :image_categories, allow_destroy: true
	accepts_nested_attributes_for :infos, reject_if: :all_blank, allow_destroy: true
end

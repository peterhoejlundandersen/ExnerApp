class Work < ActiveRecord::Base
	belongs_to :category
	has_many :image_categories
	has_many :images, through: :image_categories
	accepts_nested_attributes_for :image_categories
end

class ImageCategory < ApplicationRecord
	belongs_to :work
	has_many :images
	accepts_nested_attributes_for :images
end

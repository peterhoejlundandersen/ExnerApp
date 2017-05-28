class ImageCategory < ApplicationRecord
	validates_presence_of :name
	belongs_to :work
	has_many :images
	accepts_nested_attributes_for :images
end

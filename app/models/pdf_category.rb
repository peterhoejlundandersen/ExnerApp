class PdfCategory < ApplicationRecord

	has_many :pdfs, dependent: :destroy
	
	accepts_nested_attributes_for :pdfs


end

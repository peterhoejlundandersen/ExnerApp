class PdfCategory < ApplicationRecord

	has_many :pdfs
	
	accepts_nested_attributes_for :pdfs


end

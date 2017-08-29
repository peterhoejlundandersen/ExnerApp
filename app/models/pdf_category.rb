class PdfCategory < ApplicationRecord
	extend FriendlyId
	friendly_id :title, use: [:slugged]

	has_many :pdfs, dependent: :destroy
	
end

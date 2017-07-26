class PdfCategory < ApplicationRecord
	extend FriendlyId
	friendly_id :title, use: [:slugged, :finders]

	has_many :pdfs, dependent: :destroy
	
end

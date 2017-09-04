class PdfCategory < ApplicationRecord
	extend FriendlyId
	friendly_id :title, use: [:slugged]

	has_many :pdfs, dependent: :destroy
	default_scope { where.not(id: [1,2])}	
end

class PdfCategory < ApplicationRecord
	extend FriendlyId
	friendly_id :title, use: [:slugged]

	has_many :pdfs, -> {order(:position)}
	default_scope { where.not(id: [1,2])}
end

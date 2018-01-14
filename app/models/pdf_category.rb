class PdfCategory < ApplicationRecord
	extend FriendlyId
	friendly_id :title, use: [:slugged]

	has_many :pdfs
  scope :not_about, -> { where.not(id: [1, 2]) }
end

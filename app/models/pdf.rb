class Pdf < ApplicationRecord
	extend FriendlyId
	friendly_id :title, use: [:slugged, :finders]
	belongs_to :pdf_category
end

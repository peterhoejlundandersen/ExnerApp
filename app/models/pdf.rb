require 'elasticsearch/model'

class Pdf < ApplicationRecord
  include Searchable

	mount_uploader :image, PdfImageUploader
	extend FriendlyId
	friendly_id :title, use: [:slugged, :finders]
	belongs_to :pdf_category
  default_scope { order(date: :asc)  }

  # For concern Searchable in the top!
  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :title
      indexes :date
    end
  end
end

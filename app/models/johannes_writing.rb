class JohannesWriting < ApplicationRecord
	extend FriendlyId
	friendly_id :title, use: :slugged
	mount_uploader :pdf, PdfUploader

end

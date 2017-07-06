class Pdf < ApplicationRecord
	mount_uploader :file, PdfUploader
	belongs_to :pdf_category
end

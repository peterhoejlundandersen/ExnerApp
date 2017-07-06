class PdfCategoriesController < ApplicationController
	include PdfCategoriesHelper
	layout "works"

	def index
		@categories = PdfCategory.all.includes(:pdfs)
	end

	def show

	end

	def new

	end

	def edit

	end

	def upload_pdfs
		
		path = "/Users/bruger/Desktop/DENHER"

		Dir.foreach(path) do |category_path|

			next if folder_or_file_excluded? category_path
			pdf_category = PdfCategory.create!(title: category_path)

			Dir.open("#{path}/#{category_path}") do |file_path|  

				next if folder_or_file_excluded? file_path

				pdf_file_without_file_ending = remove_last_obj_in_arr file_path.split(".")
				words = pdf_file_without_file_ending.split(" ")
				first = words.first

					new_pdf = Pdf.new(
								title: words[1..-1].join(" "),
								date: Time.new(first),
								pdf_category_id: pdf_category.id,
								)

						new_pdf.file = file_path
						new_pdf.save!

			end # file_path

		end # category_path
		redirect_to root_path
	end


	private 


	def is_integer? thing
		thing.to_i.to_s == thing
	end 

	def remove_last_obj_in_arr array
		new_array = array.first array.size - 1
		new_array.join(".")
	end

	def folder_or_file_excluded? folder_file
		list = %w(Fravalgt Fravalg Valgt fra fravalg fravalgt JPEG . .git DS_Store .. .DS_Store image_upload.rb)
		list.include? folder_file	
	end

	def pdf_params
		params.require(:pdf_category).permit(:title, pdf_attributtes: [:title, :file])
	end
end

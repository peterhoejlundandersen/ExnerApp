class PdfCategoriesController < ApplicationController
	include PdfCategoriesHelper
	layout false
	layout "works", except: [:show]

	def index
		@pdfs = Pdf.all
	end

	def show
		pdf_viewer = "/pdfjs/web/viewer.html?file="
		url = Pdf.find(params[:id]).file
		@pdf_url = pdf_viewer + url
	end

	def new

	end

	def edit

	end

	def upload_pdfs_via_s3 

		s3 = Aws::S3::Resource.new
		objects = s3.bucket('exnerbilleder').objects(prefix: "pdf/")

		objects.each do |object|
			next if object.key == "pdf/"

			category_title = object.key.split("/")[-2]

			@pdf_category ||= Pdf.new			

			unless @pdf_category.title == category_title
				@pdf_category = PdfCategory.create!(title: category_title) 
			end
			#Pdf title
			file_name_with_ending = object.key.split("/")[-1]
			file_name_array = file_name_with_ending.split(".")
			file_name_without_ending = remove_last_obj_of_arr file_name_array
			#Pdf path
			amazon_bucket_path = "https://s3.eu-west-2.amazonaws.com/exnerbilleder/"
			encode_object_key = URI.encode(object.key)
			amazon_url = amazon_bucket_path + encode_object_key

			Pdf.create!(
					title: file_name_without_ending, 
					pdf_category_id: @pdf_category.id,
					file: amazon_url
					)
			binding.pry

		end

		head :ok
	end

	def upload_pdfs
		
		path = "/Users/bruger/Desktop/DENHER"

		Dir.foreach(path) do |category_path|

			puts "*" * 30
			puts "FØR pdf_category create"
			puts "*" * 30

			next if folder_or_file_excluded? category_path
			pdf_category = PdfCategory.create!(title: category_path)

			puts "*" * 30
			puts "EFTER pdf_category create"
			puts "*" * 30

			Dir.foreach("#{path}/#{category_path}") do |file_path|  

				next if folder_or_file_excluded? file_path

				new_pdf = Pdf.new(
							title: file_path,
							pdf_category_id: pdf_category.id,
							)

				File.open("#{path}/#{category_path}/#{file_path}") do |file_from_path|
					new_pdf.file = file_from_path
					new_pdf.save!
					binding.pry
				end

			end # file_path

		end # category_path
		redirect_to root_path
	end


	private 

	def remove_last_obj_of_arr array
		new_array = array.first array.size - 1
		new_array.join()

	end

	def is_integer? thing
		thing.to_i.to_s == thing
	end 

	def folder_or_file_excluded? folder_file
		list = %w(. .git DS_Store .. .DS_Store)
		list.include? folder_file	
	end

	def pdf_params
		params.require(:pdf_category).permit(:title, pdf_attributtes: [:title, :file])
	end
end

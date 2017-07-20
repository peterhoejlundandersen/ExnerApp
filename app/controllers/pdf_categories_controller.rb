class PdfCategoriesController < ApplicationController
	access all: [:show, :index], user: {except: [:destroy]}, site_admin: :all
	layout false
	layout "works", except: [:show]

	def index
		unless params[:category_id] == "0"
			@pdf_categories = PdfCategory.all
			@pdfs = Pdf.where(pdf_category_id: params[:category_id])
		else 
			@pdf_categories = PdfCategory.all
			@pdfs = Pdf.all
		end
	end

	def show
		pdf_viewer = "/pdfjs/web/viewer.html?file="
		pdf = Pdf.find(params[:id])
		@pdf_category = pdf.pdf_category
		pdf == Pdf.last  ? @next_pdf = Pdf.first : @next_pdf = Pdf.find(pdf.id + 1) 
		pdf == Pdf.first ? @prev_pdf = Pdf.last : @prev_pdf = Pdf.find(pdf.id - 1)
		@pdf_url = pdf_viewer + pdf.file
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
			next if folder_or_file_excluded? object.key.split("/").last 

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
			amazon_url = object.public_url

			first_num_or_letters = file_name_without_ending.split(" ").first

			if is_integer? first_num_or_letters
				date_from_file = first_num_or_letters
				date_from_file = date_from_file.to_i
				file_name_without_ending = file_name_without_ending.split(" ")[1..-1].join(" ")
			elsif ( first_num_or_letters.split(".").length > 1 ) && ( is_integer? first_num_or_letters.split(".").first )
				date_from_file = first_num_or_letters.split(".")
				date_from_file.map! { |date| date.to_i }
				file_name_without_ending = file_name_without_ending.split(" ")[1..-1].join(" ")
			else
				date_from_file = nil
			end 

			Pdf.create!(
					title: file_name_without_ending, 
					pdf_category_id: @pdf_category.id,
					date: date_from_file.nil? ? nil : DateTime.new(*date_from_file),
					file: amazon_url
					)

		end

		redirect_to pdf_categories_path
	end


	private 

	def remove_last_obj_of_arr array
		new_array = array.first array.size - 1
		new_array.join(".")

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

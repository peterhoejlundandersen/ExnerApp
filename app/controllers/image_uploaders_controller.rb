class ImageUploadersController < ApplicationController
	layout "works"
	access site_admin: :all


	def uploader
		
	end

	def create	

		Dir.foreach(path) do |category_folder|  
			next if folder_or_file_excluded? category_folder

			category = Category.find_by_name category_folder

			Dir.foreach(path + "/" + category_folder) do |work_folder|  
				next if folder_or_file_excluded? work_folder
				next if is_text_document? work_folder
				@work = create_work work_folder, category, category_folder

				image_categories = []
				work_folder_path = "#{path}/#{category_folder}/#{work_folder}"

				Dir.foreach(work_folder_path) do |image_category_folder| 
					next if folder_or_file_excluded? image_category_folder
					next if is_text_document? image_category_folder
					next if images_accepted? image_category_folder.split(".")[-1]
				  image_categories << image_category_folder 

				end 

				if image_categories.empty?
					image_category = ImageCategory.new(name: "Alle")
					image_category.work = @work
					image_category.save!
					Dir.foreach(work_folder_path) do |image_path|
					  next if folder_or_file_excluded? image_path
					  next if is_text_document? image_path
					  next unless images_accepted? image_path.split(".")[-1]
					  image = Image.new
					  image.image_category = image_category
					
					  	File.open("#{work_folder_path}/#{image_path}") do |f|
					  	  image.image = f
					  	end
					  	binding.pry
					  	if image_path.include? "START"
						  	File.open("#{work_folder_path}/#{image_path}") do |f|
						  	  @work.overview_img = f 
						  	  @work.save!
						  	  
						  	end
					  	end

					  image.save!
					end

				else
					image_categories.each do |image_category_path| #For hver billedekategori
						binding.pry
					  image_category = ImageCategory.new(name: image_category_path)
					  image_category.work = @work #Hvis der ikke er nogle billede underkategorier
					  image_category.save
					  Dir.foreach("#{work_folder_path}/#{image_category_path}") do |image_file|
					  	binding.pry
					    next if folder_or_file_excluded? image_file
					    next if is_text_document? image_file
					    next if image_file.empty? 

					    image = Image.new
					   	image.image_category = image_category

					    # GEMMER BILLEDET
					    File.open("#{work_folder_path}/#{image_category_path}/#{image_file}") do |f|
					      image.image = f
					    end

				      	if image_file.include? "START"
				    	  	File.open("#{work_folder_path}/#{image_category_path}/#{image_file}") do |f|
				    	  	  @work.overview_img = f 
				    	  	  @work.save!
				    	  		binding.pry
				    	  	  
				    	  	end
				      	end

					    image.save!
					  end # image_file

					end # new_image_category - image_Category_path

				end # image_categories.empty?

			end # work_folder

		end #category_folder
		redirect_to oversigt_path
	end

	private

	def create_work folder, parent_category, parent_category_folder
		work = Work.new()
		words = folder.split(" ")
		if is_an_integer? words[0]
			work.sagsnr = words[0].to_i 		
			work.name = words[1..-1].join(" ")
		else
			work.name = words.join(" ")
		end
		work.category = parent_category 
		look_for_description folder, "#{path}/#{parent_category_folder}"
		work.description = @description
		work.address = @address
		work.save
		work
	end

	def is_an_integer? input
		input.to_i.to_s == input
	end

	def look_for_description(folder, path)
				Dir.glob("#{path}/*.txt") do |file| #kører igennem tekstfiler i den samme mappe
				file_name_without_path = file.split("/")[-1] #Den fjerner path til filen
				file_name = file_name_without_path.split(".") #Del filendelsen og navnet op
				file_name.pop(1) # Fjern endelsen
				file_name = file_name.join(".") # Sæt sammen igen (Hvis der nu er "." i et navn)
					if folder == file_name #hvis identisk navn, tilføj beskrivelse
						# Den fucking ENCODING LØSTE FUCKING PROBLEMET - OMG! 

						@description = ""
						File.foreach(file, encoding: 'iso-8859-1') do |line|
							words = line.split(" ")
							@address = nil
							if words[0] == "Adresse:"
								words.shift
								@address = words.join(" ")
								next
							end
							@description << line
						end
					end
				end
	end 

	def path
	"/Users/bruger/Desktop/EXNER FORSØG 3"
	end

	def is_text_document? folder_or_file
		if folder_or_file.split(".")[-1] == "txt" || folder_or_file.split(".")[-1] == "text"
			true 
		end
	end

	def folder_or_file_excluded? folder_file
		list = %w(Fravalgt Fravalg Valgt fra fravalg fravalgt . .git DS_Store .. .DS_Store image_upload.rb)
		list.include? folder_file	
	end

	def images_accepted? image_file_ending
	%w(gif jpg png tif jpeg tiff JPG TIF TIFF PNG JPEG).include? image_file_ending
	end





end

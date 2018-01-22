class StaticPagesController < ApplicationController
	before_action :authenticate_user!, except: [:danmarkskort, :frontpage, :about, :get_geo_json]
	layout "works", except: [:frontpage]

	def danmarkskort
		if params[:id].nil?
			data = get_geo_json MapInfo.all
			@no_popup = true
		else #
			map_info = Work.find(params[:id]).map_info
			arr = []
			arr << map_info
			arr += MapInfo.where.not(id: map_info.id)
			data = get_geo_json arr
			@breadcrumb_child = {title: map_info.title, path: "danmarkskort_path(#{map_info.id})"}
		end
			@breadcrumb_parent = {title: "Danmarkskort", path: "danmarkskort_path()"}
		@json_data = data.to_json
	end


	def frontpage
		if FrontpageText.all.any?
			@text = FrontpageText.last
		else
			@text = nil
		end
			render layout: "frontpage"
	end

	def contact
	end

	def about
		@header_title = "Om Inger & Johannes"
	end

	def new_frontpage_text
		@text = FrontpageText.new()
	end

	def edit_frontpage_text
		@text = FrontpageText.find(params[:text_id])
	end

	def create_frontpage_text
		@text = FrontpageText.new(frontpage_text_params)
		if @text.save
			redirect_to root_path
		else
			redirect_to root_path, notice: "Noget gik galt!"
		end
	end
	def update_frontpage_text
		@text = FrontpageText.find(params[:id])
		if @text.update(frontpage_text_params)
			redirect_to root_path
		else
			redirect_to root_path, notice: "Noget gik galt!"
		end
	end


	private

	def get_geo_json records
		new_data = records.map do |f|
			next if f.lat_y.blank? || f.lat_x.blank?
			{
				type: "Feature",
				"geometry": {
					"type": "Point",
					"coordinates": [f.lat_y,f.lat_x]
				},
				"properties": {
					"id": f.id,
					"description": f.text,
					"title": f.title,
					"sagsnr": f.sagsnr,
					"link": f.link,
					"address": f.address
				}
			}
		end
		return new_data.compact # remove nil objects made by next
	end

	def frontpage_text_params
		params.require(:frontpage_text).permit(:text)
	end

end

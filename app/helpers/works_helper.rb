module WorksHelper

	def logged_in_work_helper 

			buttons = (link_to "Slet værket", work_path(@work), method: :delete, data: {confirm: "Er du sikker på, at du vil slette værket?"}, class: "btn btn-warning") + (
			link_to "Rediger værk", edit_work_path(@work), class: "btn btn-secondary")
			
			content_tag :div, buttons, class: "col-lg-12" 

	end

	def info_helper work
		info = ""
		info << "Sagsnr: #{work.sagsnr.to_s}<br>" if work.sagsnr.present?
		info << "Adresse: #{work.address}<br>" if work.address.present?
		info << "Konkurrenceår: #{work.competition.to_s}<br>" if work.competition.present?
		info << "Indvielse: #{work.opening_year.to_s}<br>" if work.opening_year.present?
		work.infos.each {|i| info << "#{i.title} <br>" } unless work.infos.empty?
		return info
	end

	def img_cat_col_helper img_cat_num
		case img_cat_num
		when 1
			"img-cat-1"
		when 2
			"img-cat-2"
		when 3
			"img-cat-3"
		when 4
			"img-cat-4"
		when 5
			"img-cat-5"
		when 6
			"img-cat-6"
		end

	end
end

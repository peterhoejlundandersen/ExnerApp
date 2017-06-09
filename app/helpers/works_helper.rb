module WorksHelper

	def logged_in_work_helper 

			buttons = (link_to "Slet værket", work_path(@work), method: :delete, data: {confirm: "Er du sikker på, at du vil slette værket?"}, class: "btn btn-warning") + (
			link_to "Rediger værk", edit_work_path(@work), class: "btn btn-secondary")
			
			content_tag :div, buttons, class: "col-lg-12" 

	end

	def info_helper work
		info = "<h2>Information</h2><br>"
		info << "Sagsnr: #{work.sagsnr.to_s}<br>" if work.sagsnr
		info << "Adresse: #{work.address}<br>" if work.address
		info << "Konkurrenceår: #{work.competition.to_s}<br>" if work.competition
		info << "Indvielse: #{work.opening_year.to_s}<br>" if work.opening_year
		work.infos.each {|i| info << "#{i.title} <br>" } unless work.infos.empty?
		content_tag :div, info.html_safe, class: "info-kort"
	end

	def img_cat_col_helper img_cat_num
		case img_cat_num
		when 1
			12
		when 2
			6
		when 3
			4
		when 4
			3
		when 5
			2
		end

	end
end

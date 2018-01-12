module ApplicationHelper

  def helper_breadcrumb_default page_params
    title_par, title_child = [{}, {}]
    case page_params[:controller]
    when 'about'
      title_par[:title], title_par[:path] = 'Om', 'om_path()'
      title_child = nil
    when 'facts'
      title_par[:title], title_par[:path] = 'Om', 'om_path()'
      title_child[:title], title_child[:path] = 'Fakta', 'facts_path()'
    when 'categories'
      title_par[:title], title_par[:path] = 'Oversigt', 'oversigt_path()'
      title_child = nil
    when 'videos'
      title_par[:title], title_par[:path] = 'Om', 'om_path()'
      title_child[:title], title_child[:path] = 'Video', 'videos_path()'
    else
      title_par[:title], title_par[:path] = 'Oversigt', 'oversigt_path()'
      title_child = nil
    end
    return title_par, title_child
  end

	def header_title_helper
		default = "I&J EXNER"
		if @header_title
			default + " | " + @header_title
		else
			default
		end
	end

	def alert_notice_helper
		if flash[:notice]
			content_tag :p, flash[:notice], class: "alert text-center alert-success"
		elsif flash[:alert]
			content_tag :p, flash[:alert], class: "alert text-center alert-danger"
		end
	end

	def active_helper? path
		"active" if current_page? path
	end
end


module WorksHelper

  def logged_in_work_helper
    button = (link_to "Rediger værk", edit_work_path(@work), class: "btn btn-secondary")
    content_tag :div, button, class: "col-lg-12"
  end

end

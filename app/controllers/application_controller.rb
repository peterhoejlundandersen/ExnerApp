class ApplicationController < ActionController::Base
	before_action :authenticate_user!, only: :sorting_objects
  protect_from_forgery with: :exception
  SITE_TITLE = "Inger og Johannes Exner"

  def meta_title title
    [title, SITE_TITLE].reject(&:empty?).join(" | ")
  end

  def deparameterize str
    str.split("-").join("  ").humanize
  end


  def sorting_objects
    params[:_json].each do |dataset|
      if !dataset[:id].nil? && !dataset[:order_i].nil?
        record = case dataset[:type]
        when "work"
          Work.find(dataset[:id].to_i)
        when "image-cat"
          ImageCategory.find(dataset[:id].to_i)
        when "image"
          Image.find(dataset[:id].to_i)
        else
          nil
        end
        position = dataset[:order_i].to_i
        record.update_attribute(:position, position) unless record.nil?
      end
    end
  end

end

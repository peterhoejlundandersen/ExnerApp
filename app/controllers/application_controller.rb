class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def sorting_objects
    params[:_json].each do |dataset|
      if !dataset[:id].nil? && !dataset[:order_i].nil?
        params_now = dataset.permit(:order_i, :id)
        position = params_now[:order_i].to_i
        work = Work.find(params_now[:id].to_i)
        work.update_attribute(:position, position)
      end
    end
  end

end

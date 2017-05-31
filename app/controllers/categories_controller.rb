class CategoriesController < ApplicationController
  def index
  	@category = Category.friendly.find(params[:category_name])
  	@works = @category.works.order(sagsnr: :desc)
  end
end

class CategoriesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :get_default_categories]
  layout "works"
  def new
    @category = Category.new
  end

  def edit
    @category = Category.friendly.find(params[:id])
  end

  def create
    @category = Category.new(cat_params)
    if @category.save
      redirect_to oversigt_path, notice: "#{@category.name} er blevet gemt"
    else
      redirect_to oversigt_path, alert: "Din kategori blev IKKE gemt, skriv til hilsenit@gmail.com"
    end
  end

  def update
    @category = Category.friendly.find(params[:id])
    @category.remove_image! if params[:category][:image]
    if @category.update(cat_params)
      redirect_to oversigt_path, notice: "#{@category.name} er blevet opdateret"
    else
      redirect_to oversigt_path, alert: "Din kategori blev IKKE opdateret, skriv til hilsenit@gmail.com"
    end
  end

  def index
    @categories = Category.where.not(id: [15, 18, 13, 21, 22, 23]) # Not design and om categories
    @header_title = "Oversigt"
    logged_in = current_user
    default_categories = get_default_categories
    respond_to do |format|
      format.html
      format.json { render json: { categories: @categories, user_logged_in: logged_in, cat_default: default_categories } }
    end
  end

  def destroy
    @category = Category.friendly.find(params[:id])
    deleted_name = @category.name
    if @category.destroy
      redirect_to oversigt_path, notice: "#{deleted_name} er blevet slettet"
    else
      redirect_to oversigt_path, alert: "Din kategori blev IKKE slettet, skriv til hilsenit@gmail.com"
    end

  end

  private

  def get_default_categories
    default_categories = {
       image: view_context.image_path('johannes-tekster'),
       slug: "johannes-exners-tekster/0",
       name: "Johannes' tekster",
       id: 999 # For image load in angular
      },
      {
       image: view_context.image_path('om-inger-og-johannes'),
       slug: "om",
       name: "Om Inger og Johannes",
       id: 9999 # For image load in angular
      }
      return default_categories
  end

  def cat_params
    params.require(:category).permit(:name, :image, :remove_image)
  end

end

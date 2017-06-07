class WorksController < ApplicationController
  access all: [:show, :index], user: {except: [:destroy]}, site_admin: :all

  layout "works"  
  def index
  @category = Category.friendly.find(params[:category_name])
  @works = @category.works.order(sagsnr: :desc)   
  @header_title = @category.name
  end  

  def new
    @work = Work.new()
    @categories = Category.all
  end

  def edit
    @work = Work.friendly.find(params[:id])
    @categories = Category.all

  end

  def update
    @work = Work.friendly.find(params[:id])
  
    if @work.update(work_params)
  
      flash[:success] = "Værket #{@work.name} er nu blevet opdateret."  
      redirect_to @work
    end


  end
  
  def create

   @work = Work.new(work_params)

   @work.category_id = Category.find(1).id

	  if @work.save
  
	    flash[:succes] = "Dit værk #{@work.name} er nu blevet oprettet."
	    redirect_to @work
	  else
	    render 'new'
	  end

  end

  def show 
   @work = Work.friendly.find(params[:id])
   @image_categories = @work.image_categories


 end

 def destroy
   @work = Work.friendly.find(params[:id])
   work_category = @work.category_id
   work_name = Work.name
   if @work.destroy
    flash[:succes] = "#{work_name} er nu blevet slettet"
   redirect_to kategori_oversigt_path(work_category)
  end

 end

 

 def category_show
 	# Dette kunne gøres for at lave et kategory each field som menu
 	# @work = Category.find(category_slug: params[:category]).works 
 end


 private


 def prepare_save
   @work.image_categories.each do |img_cat| 
    img_cat.save
    binding.pry
      if images = Image.where(image_category_id: img_cat.id)
        img_cat.images << images
      end 
    end
 end
 
 def work_params
   params.require(:work).permit(
    :name, 
    :sagsnr, 
    :category_id,
    :description, 
    :address,
    {infos_attributes: 
      [:id, :title, :work_id, :_destroy]},
    {image_categories_attributes: 
      [:id, :work_id, :name, 
        images_attributes: 
        [:id, :image, :photographer, :image_description]]}) 
 end
end

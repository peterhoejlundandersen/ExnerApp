class WorksController < ApplicationController
  include WorksHelper


  def new
    @work = Work.new(info: [""])
    1.times {
    @work.image_categories.build
    @work.image_categories.last.images.build
  }
  end

  def edit
    @work = Work.find(params[:id])

  end

  def update
    @work = Work.find(params[:id])

    if @work.update(work_params)
      byebug
      flash[:success] = "Værket #{@work.name} er nu blevet opdateret."  
      redirect_to @work
    end


  end
  
  def create

   @work = Work.new(work_params)
   byebug
   @work.category_id = Category.find(1).id

	  if @work.save
      byebug
	    flash[:succes] = "Dit værk #{@work.name} er nu blevet oprettet."
	    redirect_to @work
	  else
	    render 'new'
	  end

  end

  def show 
   @work = Work.find(params[:id])
   @image_categories = @work.image_categories


 end

 def index
   @works = Work.all
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
   params.require(:work).permit(:name, :sagsnr, :category_id,
    :description, :address,
    {info: []}, {image_categories_attributes: 
      [:id, :work_id, :name, images_attributes: 
        [:id, :image, :photographer, :image_description]]}) 
 end
end

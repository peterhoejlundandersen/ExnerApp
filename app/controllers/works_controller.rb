class WorksController < ApplicationController
  include WorksHelper

  def new
    @work = Work.new(info: [""])
    2.times {
    @work.image_categories.build
    @work.image_categories.last.images.build
  }
  end

  def edit
    @work = Work.find(params[:id])

  end

  def update
    work = Work.find(params[:id])
    if work.update_attributes(work_params)
      flash[:success] = "Værket #{work.name} er nu blevet opdateret."  
    end
    redirect_to work
  end
  
  def create

   @work = Work.new(work_params)
   binding.pry
   # @work.save
  #  params["work"]["images_attributes"].each do |img|
  #   image_object = Image.new
  #   binding.pry
  #   image_object.image = img
  #   @work.images << image_object
  # end
  #   binding.pry

  if @work.save
   binding.pry
    flash[:succes] = "Dit værk #{@work.name} er nu blevet oprettet."
    redirect_to @work
  else
    redirect_to :back
  end

    # else
    #   flash[:error] = "Det kunne desværre ikke lade sig gøre, at gemme værket."
    #   redirect_to :back
    # end
  end

  def show 
   @work = Work.find(params[:id])
   @image_categories = @work.image_categories


 end

 def index
   @works = Work.all
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
      [:work_id, :name, images_attributes: 
        [:image, :photographer, :image_description]]}) 
 end
end

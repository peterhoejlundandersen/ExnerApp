class WorksController < ApplicationController
  access all: [:show, :index], user: {except: [:destroy]}, site_admin: :all
  layout "works"  

  def index
    if params[:vaerker_cat] == "design"
      set_design_categories
      render 'categories/design_categories_overview'
    else
      @category = Category.friendly.find(params[:vaerker_cat])
      @header_title = @category.name
      @works = @category.works
    end
  end  

  def sort
    params[:order].each do |key, value|
      Work.find(value[:id]).update(position: value[:position])
    end 
    render nothing: true   
  end


  def new
    @work = Work.new()
    @categories = Category.all
  end

  def edit
    @work = Work.friendly.find(params[:id])
    @categories = Category.all
  end

  
  def create
   @work = Work.new(work_params)
   if @work.save!

     flash[:succes] = "Dit værk #{@work.name} er nu blevet oprettet."
     redirect_to @work
   else
     redirect_to works_path
   end

 end

 def show 
   @work = Work.friendly.find(params[:id])
   unless @work.image_categories.first.images.empty?
    @image_categories = @work.image_categories.includes(:images).where(images: {draft: false}).order("images.position")
    @first_image = @image_categories.order(:position).first.images.published.first
    @work_cat = @work.category
    render 'show'
  else 
      # For work without images
      render 'show_no_images'
    end 
  end

  def sort_images
    params[:order].each do |key, value|
      if value[:type] == "ImageCategory"
        ImageCategory.find(value[:id]).update(position: value[:position])
      else
        Image.find(value[:id]).update(position: value[:position])
      end
    end
    render nothing: true
  end

  def destroy
   @work = Work.friendly.find(params[:id])
   work_category = @work.category_id
   work_name = Work.name
     if @work.destroy
      flash[:succes] = "#{work_name} er nu blevet slettet"
      redirect_to works_path(work_category.name.parameterize)
    end

  end

  def update

    @work = Work.friendly.find(params[:id])
    
    if @work.update(work_params)

      save_overview_img_if_checkbox_checked @work

      flash[:success] = "Værket #{@work.name} er nu blevet opdateret."  
      redirect_to work_path(@work)


    else
      redirect_to kategori_oversigt_path(@work.category_id)
    end


  end

private

def set_design_categories
 @categories = []
 @categories << Category.find(13)
 @categories << Category.find(15)
 @categories << Category.find(18)
end

def save_overview_img_if_checkbox_checked work
 params[:work][:image_categories_attributes].values.each do |img_cat|
   img_cat[:images_attributes].values.each do |img|
     if img[:is_review_img] == "1"
       #Kalder den work_params, saa den vil blive redigeret
       work.overview_img = Image.find(img[:id]).image
       work.save!
       return work

     end
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
    :competition,
    :opening_year,
    :overview_img,
    :position,
    {infos_attributes: 
      [:id, :work_id, :title, :_destroy]},
      {image_categories_attributes: 
        [:id, :work_id, :name, :_destroy,
          images_attributes: 
          [:id, :image, :photographer, :image_description, :is_review_img, :draft, :_destroy]]}) 
  end
end

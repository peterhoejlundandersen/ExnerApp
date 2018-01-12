class WorksController < ApplicationController

  access all: [:show, :index, :design_index, :new_image, :new_image_category, :overview_img], user: {except: [:destroy]}, site_admin: :all
  layout "works"

  def new_image
    @new_image = Image.find(params[:id])
    respond_to do |format|
      format.js { render 'works/js/new_image' }
    end
  end

  def new_image_category
    @new_thumb_images = ImageCategory.find(params[:id]).images
    if params[:start_or_end] == "end"
      @first_image = @new_thumb_images.last
    else
      @first_image = @new_thumb_images.first
    end
    respond_to do |format|
      format.js { render 'works/js/new_image_category' }
    end
  end

  def index
      if params[:noload] == "true" # Skal ikke vise nogle værker ved besøg af Design siden
        params[:vaerker_cat] = "design"
        set_design_categories params[:vaerker_cat], true #Setting @works, @categories, @category and @onload
        render_design = true
      elsif ["design", "belysning-og-andet", "kirkeinventar", "orgler"].include? params[:vaerker_cat]
        params[:vaerker_cat] = "belysning-og-andet" if params[:vaerker_cat] == "design"
        is_organs = true if params[:vaerker_cat] == "orgler"
        set_design_categories params[:vaerker_cat] #Setting @works, @categories, @category and @onload
        @breadcrumb_child = {title: @category.name, path: 'vaerker_path("' + @category.slug + '")'}
        render_design = true
      elsif ["handtegninger", "fotos", "livet-i-tre-huse"].include? params[:vaerker_cat]
        @pagination = true
        @no_padding_top = true
        set_about_categories params[:vaerker_cat] # @prev, @category, and @next
        @works = @category.works
      else
        @category = Category.friendly.find(params[:vaerker_cat])
        @works = @category.works
      end
      @breadcrumb_parent = render_design ?
        {title: "Design", path: 'vaerker_path("belysning-og-andet", noload: "true")'} :
        {title: @category.name, path: 'vaerker_path("' + @category.name.parameterize + '")'}
      respond_to do |format|
        format.html { render render_design ? "categories/design_categories_overview" : "works/index" }
        format.json { render json: {category: @category, works: @works, organs: is_organs} }
      end
  end

  def design_index
    @category = Category.find(params[:vaerker_cat])
    @category_id = "##{@category.id}"
    @works = @category.works
    respond_to do |format|
      format.js
    end
  end

  def sort
    params[:order].each do |key, value|
      if value[:type] == "Category"
        Category.find(value[:id]).update(position: value[:position])
      elsif value[:type] == "Pdf"
        Pdf.find(value[:id]).update(position: value[:position])
      elsif value[:type] == "PdfCategory"
        PdfCategory.find(value[:id]).update(position: value[:position])
      else
        Work.find(value[:id]).update(position: value[:position])
      end
    end
    head :ok
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
    if @work.image_categories.present? # En underlig fejl med manglende work_id
      @work.image_categories.each do |img_cat|
        img_cat.work = @work
      end
    end
    last_work_in_category = Category.find(@work.category.id).works.last
    if last_work_in_category.nil? || last_work_in_category.position.nil?
      @work.position = 1
    else
      @work.position = last_work_in_category.position + 1 # Den bliver lagt oven i de andre værker, så den får en position
    end
    if @work.save!
      flash[:succes] = "Dit værk #{@work.name} er nu blevet oprettet."
      redirect_to @work
    else
      redirect_to works_path
    end

  end

  def show
    unless request.format == "json"
      @work = Work.friendly.find(params[:id])
      unless @work.image_categories.first.nil?# Når et værk bliver oprettet uden billedekategori, så får den nil i .first
        @first_image_category = @work.image_categories.first
        category = @work.category
        @breadcrumb_parent = {title: category.name, path: "vaerker_path('#{category.slug}')"}
        @breadcrumb_child = {title: @work.name, path: "work_path('#{@work.friendly_id}')" }

        unless @first_image_category.images.empty?
          # HUSK AT GØRE NOGET VED DEM HER, NÅR JSOr ANGULAR VIRKER!
          @work_cat = @work.category
        else
          # For work without images
          render 'show_no_images'
        end
      else
        render 'show_no_images'
      end
    else # unless request.format
      image_cat = ImageCategory.find(params[:image_category_id])
      work = image_cat.work
      cat = work.category
      work_info = return_work_info work
      work_description = work.description
      images = image_cat.images.published
      image_cats = work.image_categories
      image_cats_index = (image_cats.length < 2) ? -1 : 0
      large_image = images.first
      work_title = work.name

      prev_work, next_work = work.position.nil? ? ["", ""] : get_next_and_previous_work(cat.works, work)

      respond_to do |format|
        format.json {
          render json: {
            images: images,
            image_cats: image_cats,
            large_image: large_image,
            image_cats_index: image_cats_index,
            work_info: {short: work_info, description: work_description},
            pagination: {prev: prev_work, next: next_work},
            parent_cat: {slug: cat.slug, name: cat.name},
            work_title: work_title
          }
        }
      end

    end
  end

  def sort_images
    params[:order].each do |key, value|
      if value[:type] == "ImageCategory"
        ImageCategory.find(value[:id]).update(position: value[:position])
      elsif value[:type] == "Category"
        Category.find(value[:id]).update(position: value[:position])
      else
        Image.find(value[:id]).update(position: value[:position])
      end
    end
    render nothing: true
  end

  def destroy
    @work = Work.friendly.find(params[:id])
    work_category_id = @work.category_id
    work_name = Work.name
    if @work.destroy
      redirect_to vaerker_path(work_category_id), notice: "#{@work.name} er nu blevet slettet."
    end
  end

  def update
    @work = Work.friendly.find(params[:id])
    if @work.update(work_params)
      flash[:success] = "Værket #{@work.name} er nu blevet opdateret."
      redirect_to work_path(@work)
    else
      redirect_to kategori_oversigt_path(@work.category_id)
    end
  end

  def get_overview_img
    image = Image.find(params[:id])
    respond_to do |format|
      format.json {render json: image}
    end
  end

  def save_overview_img
    work = Work.find(params[:work_id])
    image = Image.find(params[:image_id])
    work.overview_img = image.image
    work.save!
  end

  private

  def set_about_categories cat_params
    @next, @prev = [{}, {}]
    case cat_params
    when 'handtegninger'
      @prev = {title: "Livet i tre huse", path: "vaerker_path('livet-i-tre-huse')"}
      @next = {title: "Artikler", path: "artikler_path()"}
      @category = Category.friendly.find(cat_params)
    when 'fotos'
      @prev = {title: "Fakta", path: "facts_path()"}
      @next = {title: "Video", path: "videos_path()"}
      @category = Category.friendly.find(cat_params)
    else
      @prev = {title: "Tidslinje", path: 'tidslinje_path()'}
      @next = {title: "Håndtegninger", path: "vaerker_path('handtegninger')"}
			@category = Category.friendly.find(cat_params)

    end
  end

  def set_design_categories cat_param, noload=false
    @categories = []
    @categories << Category.find(13)
    @categories << Category.find(15)
    @categories << Category.find(18)
    if noload
      @noload = true
    else
      @category = Category.friendly.find(cat_param)
      @works = @category.works
    end
  end

  def get_next_and_previous_work(works, current_work)
    next_work = works.detect { |w| w.position > current_work.position }
    prev_work = works.reverse.detect { |w| w.position < current_work.position }
    [prev_work, next_work]
  end

  def return_work_info work
    info = []
    info << "Sagsnr: #{work.sagsnr.to_s}" unless work.sagsnr.nil?
    info << "Adresse: #{work.address}" unless work.address.empty?
    info << "Konkurrenceår: #{work.competition.to_s}" unless work.competition.nil?
    info << "Indvielse: #{work.opening_year.to_s}" unless work.opening_year.nil?
    work.infos.each {|i| info << "#{i.title}" } unless work.infos.empty?
    return info.empty? ? false : info
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

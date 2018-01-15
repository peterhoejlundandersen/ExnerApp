class PdfsController < ApplicationController
  layout "works", except: :show
	layout 'pdf_show', only: :show

  def show
    pdf_viewer = "/pdfjs/web/viewer.html?file="
    pdf = Pdf.friendly.find(params[:id])
    @pdf_category = pdf.pdf_category
    pdfs = @pdf_category.pdfs.where.not(show_not: true)
    @prev_pdf, @next_pdf = get_next_and_previous_pdf(pdfs, pdf)
    @pdf_url = pdf_viewer + pdf.file
    @pdf_file_url = pdf.file # For printinh
    @header_title = pdf.title
  end

  def get_next_and_previous_pdf(pdfs, current_pdf)
    prev_pdf = pdfs.reverse.detect { |w| w.id < current_pdf.id }
    next_pdf = pdfs.detect { |w| w.id > current_pdf.id }
    [prev_pdf, next_pdf]
  end

  def edit
    @pdf = Pdf.friendly.find(params[:id])
    @pdf_category = @pdf.pdf_category
    @categories = PdfCategory.all
		render 'edit', layout: 'works'
  end

  def update
    @pdf = Pdf.friendly.find(params[:id])
    @pdf.remove_image! if params[:pdf][:image]
    params[:pdf][:date] = Time.new(params[:pdf][:date].to_i, 10, 10) unless params[:pdf][:date].empty?
    if @pdf.update!(pdf_params)
      flash[:notice] = "\"#{@pdf.title}\" er blevet opdateret."
      redirect_to show_this_pdf_category_path(@pdf.pdf_category_id)
    else
      flash[:notice] = "Der gik noget galt. Prøv igen."
      render "edit"
    end
  end

  def new
    @pdf_category = PdfCategory.find(params[:pdf_category_id])
    @pdf = Pdf.new()
		render 'new', layout: 'works'
  end

	def destroy
		@pdf = Pdf.find(params[:id])
		if @pdf.destroy
			flash[:notice] = "'#{@pdf.title}' er blevet slettet"
      redirect_to show_this_pdf_category(@pdf.pdf_category_id)
		else
			flash.now[:alert] = "Der gik noget galt. Prøv igen. "
			render :edit
		end
	end

  def create
    @pdf = Pdf.new(pdf_params)
    @pdf.date = Time.new(params[:pdf][:date].to_i) unless params[:pdf][:date].empty?
    if @pdf.save
      flash[:notice] = "Din artikel blev gemt"
      redirect_to show_this_pdf_category(@pdf.pdf_category_id)
    else
      flash.now[:alert] = "Noget gik galt, prøv igen"
      render :new
    end
  end

  private

  def pdf_params
    params.require(:pdf).permit(:title, :pdf_category_id, :image, :show_not, :date)
  end
end

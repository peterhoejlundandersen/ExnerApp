class PdfsController < ApplicationController
  layout "works", except: :show

  def show
    pdf_viewer = "/pdfjs/web/viewer.html?file="
    pdf = Pdf.friendly.find(params[:id])
    @pdf_category = pdf.pdf_category
    if @pdf = Pdf.exists?(pdf.id + 1)
      pdf == Pdf.last  ? @next_pdf = Pdf.first : @next_pdf = Pdf.find(pdf.id + 1)
    end
    if @pdf = Pdf.exists?(pdf.id - 1)
      pdf == Pdf.first ? @prev_pdf = Pdf.last : @prev_pdf = Pdf.find(pdf.id - 1)
    end
    @pdf_url = pdf_viewer + pdf.file
    @pdf_file_url = pdf.file # For printinh
    @header_title = pdf.title
  end

  def edit
    @pdf = Pdf.friendly.find(params[:id])
    @pdf_category = @pdf.pdf_category
    @categories = PdfCategory.all
  end

  def update
    @pdf = Pdf.friendly.find(params[:id])
    @pdf.remove_image! if params[:pdf][:image]
    params[:pdf][:date] = Time.new(params[:pdf][:date].to_i, 10, 10) unless params[:pdf][:date].empty?
    byebug
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

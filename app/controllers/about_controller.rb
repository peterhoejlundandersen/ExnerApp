class AboutController < ApplicationController
  layout 'works'
  before_action :set_parent_breadcrumb

  def index
    @fact = Fact.last unless Fact.last.nil?
  end

  def artikler
    @artikler_dansk = Pdf.where(pdf_category_id: [2])
    @artikler_udenlandsk = Pdf.where(pdf_category_id: [1])
    @breadcrumb_child = {title: "Artikler", path: "artikler_path()"}
  end

  def tidslinje
    @breadcrumb_child = {title: "Artikler", path: "tidslinje_path()"}
  end

  def haandtegninger
    @category = Category.find(21)
    @works = @category.works
    @breadcrumb_child = {title: "Håndtegninger", path: "haandtegninger_path()"}
    respond_to do |format|
      format.html
      format.json { render json: {category: @category, works: @works} }
    end
  end

  def trehuse
    @breadcrumb_child = {title: "Livet i tre huse", path: "tre_huse_path()"}
  end

  def fotos
    @breadcrumb_child = {title: "Fotos", path: "fotos_path()"}
  end

  def set_parent_breadcrumb
    @breadcrumb_parent = {title: "Om", path: "om_path()"}
  end
end

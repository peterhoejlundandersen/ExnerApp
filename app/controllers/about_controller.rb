class AboutController < ApplicationController
  layout 'works'
  before_action :set_parent_breadcrumb


  def index
    @meta_title = meta_title "Om"
    @meta_description = "Siden 'Om' indeholder Inger og Johannes' personlige tegninger, skitser og historier. Derudover er der i årenes løb blevet produceret en hel del film og artikler om arkitektparret, som også har hjemme her."
    @fact = Fact.last unless Fact.last.nil?
  end

  def artikler
    @meta_title = meta_title "Artikler af andre forfattere"
    @artikler_dansk = Pdf.where(pdf_category_id: [2])
    @artikler_udenlandsk = Pdf.where(pdf_category_id: [1])
    @breadcrumb_child = {title: "Artikler", path: "artikler_path()"}
  end

  def tidslinje
    @meta_title = meta_title "Tidslinje"
    @breadcrumb_child = {title: "Tidslinje", path: "tidslinje_path()"}
  end

  def set_parent_breadcrumb
    @breadcrumb_parent = {title: "Om", path: "om_path()"}
  end
end

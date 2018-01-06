class AboutController < ApplicationController
  layout 'works'
  def index
    @fact = Fact.first unless Fact.first.nil?
  end

  def artikler
    @artikler = Pdf.where.not(pdf_category_id: [1,2])
  end

  def tidslinje
  end

  def haandtegninger
  end

  def trehuse
  end

  def fotos
  end
end

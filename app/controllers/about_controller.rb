class AboutController < ApplicationController
  layout 'works'
  def index
    @fact = Fact.first unless Fact.first.nil?
  end

  def artikler
    @artikler = Pdf.where(id: [1,2])
  end

end

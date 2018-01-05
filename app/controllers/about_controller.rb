class AboutController < ApplicationController
  layout 'works'
  def index
    @fact = Fact.first unless Fact.first.nil?
  end

end

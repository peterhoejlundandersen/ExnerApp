class SearchController < ApplicationController

  def search
    @works = params[:q].nil? ? [] : Work.search(params[:q])
    binding.pry
  end
end

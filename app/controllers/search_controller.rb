class SearchController < ApplicationController
  layout "works"

  def search

    is_integer = Integer(params[:q]) rescue false

    if params[:q].nil? || params[:q].empty?
      @works = []
    elsif is_integer
      @works = Work.where('opening_year = ?', "#{params[:q]}")
      flash[:notice] = "Intet matcher søgningen \"#{params[:q]}\", desværre" unless @works.any?
    else
      @works = Work.where('name LIKE ?', "%#{params[:q]}%")
      flash[:notice] = "Intet matcher søgningen \"#{params[:q]}\", desværre" unless @works.any?
    end
  end



end

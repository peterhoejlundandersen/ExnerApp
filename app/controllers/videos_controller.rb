class VideosController < ApplicationController
  layout 'works'
  def new
    @video = Video.new
  end

  def edit
  end

  def index
  end
end

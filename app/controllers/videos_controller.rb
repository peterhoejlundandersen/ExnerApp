class VideosController < ApplicationController
  layout 'works'
  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:notice] = "#{@video.title} er blevet oprettet."
      redirect_to videos_path()
    else
      flash.now[:notice] = "Noget gik galt, prøv igen. Er titlen skrevet ind?"
      render :new
    end
  end

  def edit
  end

  def index
    @videos = Video.all
  end

  private
  def video_params
    params.require(:video).permit(:title, :description, :only_link, :video_url, :link)
  end
end

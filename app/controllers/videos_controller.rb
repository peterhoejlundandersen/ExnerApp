class VideosController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  layout 'works'
  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:notice] = "'#{@video.title}' er blevet oprettet."
      redirect_to videos_path()
    else
      flash.now[:notice] = "Noget gik galt, prøv igen. Er titlen skrevet ind?"
      render :new
    end
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    if @video.update(video_params)
      flash[:notice] = "'#{@video.title}' er opdateret"
      redirect_to videos_path();
    else
      flash.now[:notice] = "Noget gik galt, prøv igen."
      render :edit
    end
  end

  def index
    @videos = Video.all
  end

  def destroy
    @video = Video.find(params[:id])
    if @video.destroy
      flash[:alert] = "'#{@video.title}' er blevet slettet."
      redirect_to videos_path()
    else
      flash.now[:notice] = "Noget gik galt, prøv igen."
    end
  end

  private
  def video_params
    params.require(:video).permit(:title, :description, :only_link, :video_url, :link)
  end
end

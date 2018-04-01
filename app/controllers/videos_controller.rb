class VideosController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  layout 'works'

  def index
    @meta_title = meta_title "Videoer"
    @meta_description = "Underneden finder du gamle og nyere videoer om arkitektparret. Nogle er egne optagelse, mens andre er lavet af professionelle produktioner såsom f.eks. TV2 Østjylland."
    @videos = Video.all
  end

  def new
    @video = Video.new
  end

  def create
    params[:video][:year] = Time.new(params[:video][:year].to_i, 10, 10) unless params[:video][:year].empty?
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
    params[:video][:year] = Time.new(params[:video][:year].to_i, 10, 10) unless params[:video][:year].empty?
    if @video.update(video_params)
      flash[:notice] = "'#{@video.title}' er opdateret"
      redirect_to videos_path();
    else
      flash.now[:notice] = "Noget gik galt, prøv igen."
      render :edit
    end
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
    params.require(:video).permit(:title, :description, :only_link, :video_url, :link_image, :link, :link_anker, :year)
  end
end

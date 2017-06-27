class JohannesWritingsController < ApplicationController

	layout "works", except: [:show]
	def index
		@johannes_writings = JohannesWriting.all

	end

	def new
		@johannes_writing = JohannesWriting.new
	end

	def create
		@johannes_writing = JohannesWriting.new(johannes_writing_params)

		if @johannes_writing.save!
			redirect_to johannes_writings_path(), notice: "#{@johannes_writing.title} blev gemt"
		else
			puts "Aj!"	
		end
		
	end
	def show
		@johannes_writing = JohannesWriting.friendly.find(params[:id])
		render layout: false
	end

	private

	def johannes_writing_params
		params.require(:johannes_writing).permit(:title, :pdf)
	end


	private
end

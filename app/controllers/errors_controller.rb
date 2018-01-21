class ErrorsController < ApplicationController
	layout 'works'
  def show
    @status_code = params[:code] || 500
  end
end

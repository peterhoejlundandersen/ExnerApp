class FactsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  layout 'works'
  def new
    @fact = Fact.new
  end

  def create
    @fact = Fact.new(fact_params)
    if @fact.save!
      flash[:notice] = "'#{@fact.title}' er blevet oprettet."
      redirect_to facts_path()
    else
      flash.now[:alert] = "Noget gik galt, har du udfyld titlen?"
      render :new
    end
  end

  def edit
    @fact = Fact.first # Der bliver kun lavet ét!
  end

  def update
    @fact = Fact.last
    if @fact.update(fact_params)
      flash[:notice] = "'#{@fact.title}' er blevet opdateret"
      redirect_to facts_path()
    else
      flash.now[:alert] = "Noget gik galt. Har du udfyldt titlen. Prøv igen."
      render :edit
    end
  end

  def index
    @fact = Fact.last
  end

  private

  def fact_params
    params.require(:fact).permit(:title, :text)
  end
end

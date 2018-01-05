class FactsController < ApplicationController
  layout 'works'
  def new
    @fact = Fact.new
  end

  def create
    @fact = Fact.new(fact_params)
    if @fact.save!
      flash[:notice] = "'#{@fact.title}' er blevet oprettet."
      redirect_to fact_path(@fact.id)
    else
      flash.now[:alert] = "Noget gik galt, har du udfyld titlen?"
      render :new
    end
  end

  def edit
    @fact = Fact.first # Der bliver kun lavet ét!
  end

  def update
    @fact = Fact.first
    if @fact.update(fact_params)
      flash[:notice] = "'#{@fact.title}' er blevet opdateret"
      redirect_to fact_path(@fact.id)
    else
      flash.now[:alert] = "Noget gik galt. Har du udfyldt titlen. Prøv igen."
      render :edit
    end
  end

  def show
    @fact = Fact.first
  end

  private

  def fact_params
    params.require(:fact).permit(:title, :text)
  end
end

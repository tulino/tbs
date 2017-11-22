class DecisionsController < ApplicationController
  before_action :set_decision, only: %i[show edit update destroy]

  def index
    if params[:search]
      @decisions = Decision.search(params[:search]).order('name ASC')
    else
      @decisions = Decision.order('name ASC')
    end
  end

  def new
    @decision = Decision.new
    authorize @decision
  end

  def create
    authorize Decision
    @decision = Decision.create(decision_params)
    if @decision.save
      redirect_to @decision
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    authorize @decision
    if @decision.update(decision_params)
      redirect_to @decision
    else
      render 'edit', alert: 'kayıt basarısız'
    end
  end

  def destroy
    @decision.destroy
    redirect_to @decision
  end

  private

  def decision_params
    params.require(:decision).permit(:name, :file)
  end

  def set_decision
    @decision = Decision.find(params[:id])
  end
end

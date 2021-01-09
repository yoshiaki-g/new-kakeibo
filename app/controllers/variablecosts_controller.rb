class VariablecostsController < ApplicationController
  before_action :set_variablecost, only: [:edit, :show, :update, :destroy]

  def index
    @variablecosts = Variablecost.order(created_at: :asc)
  end

  def new
    @variablecost = Variablecost.new
  end

  def create
    @variablecost = Variablecost.new(variablecost_params)
    if @variablecost.save
      redirect_to variablecosts_path, notice: "収入を登録しました"
    else
      render "new"
    end
  end

  def edit
  end

  def show
  end

  def update
    if @variablecost.update(variablecost_params)
      redirect_to variablecosts_path, notice: "収入を登録しました"
    else
      render 'edit'
   end
  end

  def destroy
    @variablecost.destroy
    redirect_to variablecosts_path, notice: "収入を削除しました"
  end

  private
  def variablecost_params
    params.require(:variablecost).permit(:name, :year_month, :value, :description)
  end

  def set_variablecost
    @variablecost = Variablecost.find(params[:id])
  end

end

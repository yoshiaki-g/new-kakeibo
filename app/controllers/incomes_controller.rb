class IncomesController < ApplicationController
  before_action :set_income, only: [:edit, :show, :update, :destroy]

  def index
    @incomes = Income.order(created_at: :asc)
  end

  def new
    @income = Income.new
  end

  def create
    # binding.pry
    @income = Income.create(income_params)
    if @income.save
      redirect_to action: :index, notice: "収入を登録しました"
    else
      render action: :new, notice: "登録に失敗しました"
    end
  end

  def edit
  end

  def show
  end

  def update
    if @income.update(income_params)
      redirect_to incomes_path, notice: "収入を登録しました"
    else
      render 'edit'
   end
  end

  def destroy
    @income.destroy
    redirect_to incomes_path, notice: "収入を削除しました"
  end

  private
  def income_params
    params.require(:income).permit(:name, :year_month, :value, :description)
  end

  def set_income
    @income = Income.find(params[:id])
  end

end

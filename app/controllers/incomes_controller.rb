class IncomesController < ApplicationController
  before_action :set_income, only: [:edit, :show, :update, :destroy]

  def index
    @incomes = Income.order(created_at: :asc)
  end

  def new
    @income_form = IncomeForm.new
  end

  def create
    binding.pry
    @income_form = IncomeForm.new(income_form_params)
    if @income.save
      redirect_to incomes_path, notice: "収入を登録しました"
    else
      render root_path
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
  def income_form_params
    params.require(:income_form).permit(:name, :description, :year_month, :value, :description).merge(income_id: params[:income_id])
  end

  def set_income
    @income = Income.find(params[:id])
  end

end

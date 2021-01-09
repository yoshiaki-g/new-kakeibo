class IncomeValuesController < ApplicationController
  before_action :set_income_value, only: [:edit, :update, :destroy]

  def index
    @income_values = IncomeValue.order(year_month: "ASC")
  end

  def new
    year_month_day = params[:year_month] + "-01"
    @year_month = year_month_day.to_date
 
    @incomes = Income.order(created_at: :asc)
    @income_value = IncomeForm.new
  end

  def create
    @income_value = IncomeValue.new(income_value_params)
    binding.pry
    if @income_value.save
      redirect_to :income_values, notice: "登録しました"
    else
      redirect_to :income_values, notice: "登録に失敗しました"
    end
  end

  def edit
    @income = Income.find(@income_value.income_id)
  end

  def update
    @income_value.assign_attributes(params[:income_value])
    if @income_value.save
      redirect_to :income_values, notice: "情報を更新しました"
    else
      render "edit"
    end
  end

  def destroy
    @income_value.destroy
    redirect_to :income_values, notice: "データを削除しました。"
  end

  private
  def income_value_params
    params.require(:income_value).permit(:year_month, :value, :description).merge(income_id: params[:income_id])
  end

  def income_form_params
    params.require(:income_form).permit(:name, :description, :year_month, :value, :description).merge(income_id: params[:income_id])
  end

  def set_income_value
    @income_value = IncomeValue.find(params[:id])
  end

end

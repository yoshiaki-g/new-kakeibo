class IncomesController < ApplicationController
  before_action :set_income, only: [:edit, :show, :update, :destroy]
  before_action :confirmation

  def index
    incomes = Income.where(user_id: current_user.id)
    @incomes = incomes.order(created_at: :asc)
  end

  def new
    @income = Income.new
  end

  def create
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
    params.require(:income).permit(:name, :year_month, :value, :description).merge(user_id: current_user.id)
  end

  def set_income
    @income = Income.find(params[:id])
  end

  def confirmation
    unless user_signed_in?
      redirect_to root_path
    end
  end

end

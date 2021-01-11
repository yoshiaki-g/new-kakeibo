class FixedcostsController < ApplicationController
  before_action :set_fixedcost, only: [:edit, :show, :update, :destroy]
  before_action :confirmation

  def index
    fixedcosts = Fixedcost.where(user_id: current_user.id)
    @fixedcosts = fixedcosts.order(created_at: :asc)
  end

  def new
    @fixedcost = Fixedcost.new
  end

  def create
    @fixedcost = Fixedcost.create(fixedcost_params)
    if @fixedcost.save
      redirect_to action: :index, notice: "固定費を登録しました"
    else
      render action: :new, notice: "登録に失敗しました"
    end
  end
  def edit
  end

  def show
  end

  def update
    if @fixedcost.update(fixedcostv_params)
      redirect_to fixedcosts_path, notice: "固定費を登録しました"
    else
      render 'edit'
   end
  end

  def destroy
    @fixedcost.destroy
    redirect_to fixedcosts_path, notice: "固定費を削除しました"
  end

  private
  def fixedcost_params
    params.require(:fixedcost).permit(:name, :year_month, :value, :description).merge(user_id: current_user.id)
  end

  def set_fixedcost
    @fixedcost = Fixedcost.find(params[:id])
  end

  def confirmation
    unless user_signed_in?
      redirect_to root_path
    end
  end

end

require 'rails_helper'

RSpec.describe Fixedcost, type: :model do
  before do
    user = FactoryBot.create(:user)
    @fixedcost = FactoryBot.build(:fixedcost, user_id: user.id)
  end

  describe '固定費登録機能' do
    context '固定費登録がうまくいくとき' do
      it 'name,year_month,value,description,user_idが存在すれば登録できる' do
        expect(@fixedcost).to be_valid
      end
      it 'descriptionが空でも保存はできる' do
        @fixedcost.description = ""
        expect(@fixedcost).to be_valid
      end
    end

    context '固定費登録がうまくいかないとき' do
      it "nameがないと出品できない" do
        @fixedcost.name = ""
        @fixedcost.valid?
        expect(@fixedcost.errors.full_messages).to include("Name can't be blank")
      end
      it "year_monthがないと出品できない" do
        @fixedcost.year_month = ""
        @fixedcost.valid?
        expect(@fixedcost.errors.full_messages).to include("Year month can't be blank")
      end
      it "valueがないと出品できない" do
        @fixedcost.value = ""
        @fixedcost.valid?
        expect(@fixedcost.errors.full_messages).to include("Value can't be blank")
      end
      it "userが紐付いていないと保存できない" do
        @fixedcost.user_id = ""
        @fixedcost.valid?
        expect(@fixedcost.errors.full_messages).to include("User can't be blank")
      end
      it "valueが1未満だと出品できない" do
        @fixedcost.value = "0"
        @fixedcost.valid?
        expect(@fixedcost.errors.full_messages).to include("Value must be greater than or equal to 1")
      end
      it "valueが9999999より大きいと出品できない" do
        @fixedcost.value = "10000000"
        @fixedcost.valid?
        expect(@fixedcost.errors.full_messages).to include("Value must be less than or equal to 9999999")
      end
      it "valueは半角数字出ないと出品できない" do
        @fixedcost.value = "５００"
        @fixedcost.valid?
        expect(@fixedcost.errors.full_messages).to include("Value is not a number")
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Income, type: :model do
  before do
    user = FactoryBot.create(:user)
    @income = FactoryBot.build(:income, user_id: user.id)
  end

  describe '収入登録機能' do
    context '収入登録がうまくいくとき' do
      it 'name,year_month,value,description,user_idが存在すれば登録できる' do
        expect(@income).to be_valid
      end
      it 'descriptionが空でも保存はできる' do
        @income.description = ""
        expect(@income).to be_valid
      end
    end

    context '収入登録がうまくいかないとき' do
      it "nameがないと出品できない" do
        @income.name = ""
        @income.valid?
        expect(@income.errors.full_messages).to include("Name can't be blank")
      end
      it "year_monthがないと出品できない" do
        @income.year_month = ""
        @income.valid?
        expect(@income.errors.full_messages).to include("Year month can't be blank")
      end
      it "valueがないと出品できない" do
        @income.value = ""
        @income.valid?
        expect(@income.errors.full_messages).to include("Value can't be blank")
      end
      it "userが紐付いていないと保存できない" do
        @income.user_id = ""
        @income.valid?
        expect(@income.errors.full_messages).to include("User can't be blank")
      end
      it "valueが1未満だと出品できない" do
        @income.value = "0"
        @income.valid?
        expect(@income.errors.full_messages).to include("Value must be greater than or equal to 1")
      end
      it "valueが9999999より大きいと出品できない" do
        @income.value = "10000000"
        @income.valid?
        expect(@income.errors.full_messages).to include("Value must be less than or equal to 9999999")
      end
      it "valueは半角数字出ないと出品できない" do
        @income.value = "５００"
        @income.valid?
        expect(@income.errors.full_messages).to include("Value is not a number")
      end
    end
  end
end

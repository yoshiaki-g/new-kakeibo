require 'rails_helper'

RSpec.describe Variablecost, type: :model do
  before do
    user = FactoryBot.create(:user)
    @variablecost = FactoryBot.build(:variablecost, user_id: user.id)
  end

  describe '変動費登録機能' do
    context '変動費登録がうまくいくとき' do
      it 'name,year_month,value,description,user_idが存在すれば登録できる' do
        expect(@variablecost).to be_valid
      end
      it 'descriptionが空でも保存はできる' do
        @variablecost.description = ""
        expect(@variablecost).to be_valid
      end
    end

    context '変動費登録がうまくいかないとき' do
      it "nameがないと出品できない" do
        @variablecost.name = ""
        @variablecost.valid?
        expect(@variablecost.errors.full_messages).to include("Name can't be blank")
      end
      it "year_monthがないと出品できない" do
        @variablecost.year_month = ""
        @variablecost.valid?
        expect(@variablecost.errors.full_messages).to include("Year month can't be blank")
      end
      it "valueがないと出品できない" do
        @variablecost.value = ""
        @variablecost.valid?
        expect(@variablecost.errors.full_messages).to include("Value can't be blank")
      end
      it "userが紐付いていないと保存できない" do
        @variablecost.user_id = ""
        @variablecost.valid?
        expect(@variablecost.errors.full_messages).to include("User can't be blank")
      end
      it "valueが1未満だと出品できない" do
        @variablecost.value = "0"
        @variablecost.valid?
        expect(@variablecost.errors.full_messages).to include("Value must be greater than or equal to 1")
      end
      it "valueが9999999より大きいと出品できない" do
        @variablecost.value = "10000000"
        @variablecost.valid?
        expect(@variablecost.errors.full_messages).to include("Value must be less than or equal to 9999999")
      end
      it "valueは半角数字出ないと出品できない" do
        @variablecost.value = "５００"
        @variablecost.valid?
        expect(@variablecost.errors.full_messages).to include("Value is not a number")
      end
    end
  end
end

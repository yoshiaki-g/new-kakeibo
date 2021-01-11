require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー登録機能' do
    context '新規登録がうまくいくとき' do
      it "name,email,password,password_confirmationが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end
    context '新規登録がうまくいかないとき' do
      it "nameは空だと登録できない" do
        @user.name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Name can't be blank")
      end
      it "emailは空だと登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "emailは一意性である" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "emailは@を含む必要がある" do
        @user.password = "kkkgmail.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "passwordは空だと登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordは6文字以上でないと登録できない" do
        @user.password = "0000a0"
        @user.password_confirmation = "0000a0"
        expect(@user).to be_valid
      end
      it "passwordは半角英数字でないと登録できない" do
        @user.password = "Ａbenjvj2"
        @user.password_confirmation = "Ａbenjvj2"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角英数字で入力してください")
      end
      it "passwordは2回入力しないと登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "passwordは数字のみの場合は登録できない" do
        @user.password = "12345678"
        @user.password_confirmation = "12345678"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角英数字で入力してください")
      end
      it "passwordは半角英字のみの場合は登録できない" do
        @user.password = "abcdef"
        @user.password_confirmation = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角英数字で入力してください")
      end
    end
  end
end

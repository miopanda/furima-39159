require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "全項目が存在し、かつ条件を満たしていれば登録できる" do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it "nicknameが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "重複したemailが存在する場合は登録できない" do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "emailは@を含まないと登録できない" do
        @user.email = "testmail"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが5文字以下では登録できない" do
        @user.password = "12345"
        @user.password_confirmation = "12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)", "Password is invalid")
      end
      it "passwordが129文字以上では登録できない" do
        @user.password = Faker::Lorem.characters(number: 129, min_alpha: 1, min_numeric: 1)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end
      it "passwordに1文字もアルファベットが含まれない場合は登録できない" do
        @user.password = "123456"
        @user.password_confirmation = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it "passwordに1文字も数字が含まれない場合は登録できない" do
        @user.password = "aaabbb"
        @user.password_confirmation = "aaabbb"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it "passwordは全て半角でなければ登録できない" do
        @user.password = "aaa000あ"
        @user.password_confirmation = "aaa000あ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it "passwordとpassword_confirmationが不一致では登録できない" do
        @user.password = "aaa000"
        @user.password_confirmation = "aaaa000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "first_nameが空では登録できない" do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", "First name is invalid")
      end
      it "last_nameが空では登録できない" do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", "Last name is invalid")
      end
      it "first_nameが半角（Alphabet）では登録できない" do
        @user.first_name = "TARO"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
      it "first_nameが半角（ｶﾀｶﾅ）では登録できない" do
        @user.first_name = "ﾀﾛｳ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
      it "last_nameが半角（Alphabet）では登録できない" do
        @user.last_name = "YAMADA"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end
      it "last_nameが半角（ｶﾀｶﾅ）では登録できない" do
        @user.last_name = "ﾔﾏﾀﾞ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end
      it "first_name_kanaが空では登録できない" do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank", "First name kana is invalid")
      end
      it "last_name_kanaが空では登録できない" do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank", "Last name kana is invalid")
      end
      it "first_name_kanaが半角（ｶﾀｶﾅ）では登録できない" do
        @user.first_name_kana = "ﾀﾛｳ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end
      it "first_name_kanaが全角（かたかな）では登録できない" do
        @user.first_name_kana = "たろう"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end
      it "last_name_kanaが半角（ｶﾀｶﾅ）では登録できない" do
        @user.last_name_kana = "ﾔﾏﾀﾞ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end
      it "last_name_kanaが全角（かたかな）では登録できない" do
        @user.last_name_kana = "やまだ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end
      it "birthが空では登録できない" do
        @user.birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth can't be blank")
      end
    end
    
  end
end

require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do

  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item, user_id: user.id)
    @order_shipping_address = FactoryBot.build(:order_shipping_address, user_id: user.id, item_id: item.id)
  end

  describe '商品購入機能' do
    context '商品の購入ができるとき' do
      it '全項目が存在しており、かつ条件を満たしていれば保存できる' do
        expect(@order_shipping_address).to be_valid
      end
      it 'buildingは空でも保存できる' do
        @order_shipping_address.building = ''
        expect(@order_shipping_address).to be_valid
      end
    end
    context '商品の購入ができないとき' do
      it "tokenが空では登録できない" do
        @order_shipping_address.token = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Token can't be blank")
      end
      it "postal_codeが空では登録できない" do
        @order_shipping_address.postal_code = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Postal code can't be blank", "Postal code is invalid. Include hyphen(-)")
      end
      it "postal_codeはハイフンを含まない場合は登録できない" do
        @order_shipping_address.postal_code = '1234567'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it "postal_codeは「3桁ハイフン4桁」でない場合は登録できない" do
        @order_shipping_address.postal_code = '123-45678'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it "postal_codeは半角文字列でない場合は登録できない" do
        @order_shipping_address.postal_code = '１２３−４５６７'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it "prefecture_idが1では登録できない" do
        @order_shipping_address.prefecture_id = 1
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it "cityが空では登録できない" do
        @order_shipping_address.city = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("City can't be blank")
      end
      it "addressが空では登録できない" do
        @order_shipping_address.address = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Address can't be blank")
      end
      it "phone_numberが空では登録できない" do
        @order_shipping_address.phone_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it "phone_numberにハイフンが含まれる場合は登録できない" do
        @order_shipping_address.phone_number = '090-1122-3344'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number is invalid. Input only number")
      end
      it "phone_numberが9桁以下の場合は登録できない" do
        @order_shipping_address.phone_number = '090112233'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number is invalid. Input only number")
      end
      it "phone_numberが12桁以上の場合は登録できない" do
        @order_shipping_address.phone_number = '090123456789'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number is invalid. Input only number")
      end
      it "phone_numberが半角数値以外の値を含む場合は登録できない" do
        @order_shipping_address.phone_number = 'aaa11112222'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number is invalid. Input only number")
      end
    end
  end
end

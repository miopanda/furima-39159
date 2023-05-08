FactoryBot.define do
  factory :order_shipping_address do

    token                 {"tok_abcdefghijk00000000000000000"}
    postal_code           {'123-4567'}
    city                  {'渋谷区'}
    address               {'神南1-12-16'}
    building              {'アジアビル9F'}
    phone_number          {'09011223344'}
    prefecture_id         {Faker::Number.between(from: 2, to: 48)}

  end
end
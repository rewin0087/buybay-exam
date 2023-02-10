FactoryBot.define do
  factory :product do
    name { Faker::Appliance.equipment }
    price { Faker::Number.decimal(l_digits: 3) }
  end
end

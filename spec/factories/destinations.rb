FactoryBot.define do
  factory :destination do
    name { Faker::Appliance.equipment }
    categories { [] }
    references { [] }
  end
end

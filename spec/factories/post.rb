FactoryBot.define do
  factory :post do
    content{Faker::Lorem.characters(number:10)}
  end
end
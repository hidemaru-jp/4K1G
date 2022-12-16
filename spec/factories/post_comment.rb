FactoryBot.define do
  factory :post_comment do
    comment { Faker::Quote.yoda }
  end
end
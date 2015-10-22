FactoryGirl.define do
  factory :project do
    name { "#{Faker::Hacker.adjective} #{Faker::Hacker.adjective} #{Faker::Hacker.noun}" }
    user { create(:user) }
    description { Faker::Lorem.sentence(12) }
    category { %w{electronics software home-improvement crafts}.sample }
  end
end

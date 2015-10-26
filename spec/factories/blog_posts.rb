# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blog_post do
    text { Faker::Lorem.paragraph(rand(5)+1) }
  end
end

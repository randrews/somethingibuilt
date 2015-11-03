FactoryGirl.define do
  factory :project do
    name { "#{Faker::Hacker.adjective} #{Faker::Hacker.adjective} #{Faker::Hacker.noun}" }
    user { create(:user) }
    description { Faker::Lorem.sentence(12) }
    category { %w{electronics software home-improvement crafts}.sample }
    cover_image { create(:image) }

    after(:create) do |project|
      create_list(:blog_post, rand(5)+2, project: project)
      create_list(:image, rand(3)+1, project: project)
      project.cover_image.update_attribute(:project, project)
    end
  end
end

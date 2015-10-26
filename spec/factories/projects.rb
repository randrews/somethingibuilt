FactoryGirl.define do
  factory :project do
    name { "#{Faker::Hacker.adjective} #{Faker::Hacker.adjective} #{Faker::Hacker.noun}" }
    user { create(:user) }
    description { Faker::Lorem.sentence(12) }
    category { %w{electronics software home-improvement crafts}.sample }
    thumbnail {
      files = [ 'public/project-placeholder1.jpg',
        'public/project-placeholder2.jpg',
        'public/project-placeholder3.jpg',
        'public/project-placeholder4.jpg' ]
      File.open(files.sample)
    }

    after(:create) do |project|
      create_list(:blog_post, rand(5)+2, project: project)
    end
  end
end

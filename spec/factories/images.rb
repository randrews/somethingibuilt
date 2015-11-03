# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :image do
    image {
      files = [ 'public/project-placeholder1.jpg',
        'public/project-placeholder2.jpg',
        'public/project-placeholder3.jpg',
        'public/project-placeholder4.jpg' ]
      File.open(files.sample)
    }

    name { Faker::Lorem.sentence }
  end
end

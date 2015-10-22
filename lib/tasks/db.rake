# Encoding: utf-8

namespace :db do

  desc "Fill database with trial data"
  task :populate => :environment do
    require 'factory_girl'

    Rake::Task['db:reset'].invoke
    Rake::Task['db:seed'].invoke

    users = (1..10).map{|_| FactoryGirl.create(:user) }
    users.each do |user|
      rand(5).times{ FactoryGirl.create(:project, user: user) }
    end
  end
end

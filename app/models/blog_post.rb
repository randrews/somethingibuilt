class BlogPost < ActiveRecord::Base
  belongs_to :project

  validates :project_id, presence: true
  validates :text, presence: true
end

class Project < ActiveRecord::Base
  belongs_to :user
  has_many :blog_posts
  has_attached_file :thumbnail, styles: {thumb: "100x100>"}
  validates_attachment :thumbnail, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  def self.categories
    %w{electronics software home-improvement crafts}.map{|c| [c.titleize, c] }
  end
end

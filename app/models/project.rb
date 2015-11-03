class Project < ActiveRecord::Base
  belongs_to :user
  has_many :blog_posts
  has_many :images
  belongs_to :cover_image, class: Image

  def self.categories
    %w{electronics software home-improvement crafts}.map{|c| [c.titleize, c] }
  end

  def thumbnail_url
    if cover_image.present?
      cover_image.image.url(:thumb)
    else
      nil
    end
  end

  def cover_image_url
    if cover_image.present?
      cover_image.image.url
    else
      ''
    end
  end
end

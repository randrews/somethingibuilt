class Project < ActiveRecord::Base
  belongs_to :user
  has_many :blog_posts
  has_many :images
  belongs_to :cover_image, class: Image

  validates :name, presence: true
  validates :category, presence: true
  validates :description, presence: true
  validates :name, uniqueness: {scope: :user_id}

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

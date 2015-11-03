class Image < ActiveRecord::Base
  belongs_to :project
  validates :name, uniqueness: {scope: :project_id}
  validates :name, presence: true
  has_attached_file :image, styles: {thumb: "100x100>"}
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end

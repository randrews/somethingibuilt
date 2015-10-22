class Project < ActiveRecord::Base
  belongs_to :user
  has_attached_file :thumbnail, styles: {thumb: "100x100>"}
  validates_attachment :thumbnail, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end

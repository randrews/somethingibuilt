# Encoding: utf-8

class Image < ActiveRecord::Base
  belongs_to :project
  if Rails.env.production?
    has_attached_file(:image, styles: {thumb: "100x100>"},
                      storage: :s3,
                      s3_credentials: {
                        bucket: ENV['S3_BUCKET'],
                        access_key_id: ENV['ACCESS_KEY_ID'],
                        secret_access_key: ENV['SECRET_ACCESS_KEY']
                      })

  else
    has_attached_file(:image, styles: {thumb: "100x100>"})
  end

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates_attachment :image, presence: true
  validates :project, presence: true
end

class RemoveProjectImage < ActiveRecord::Migration
  def change
    remove_attachment :projects, :thumbnail
    add_column :projects, :cover_image_id, :integer
  end
end

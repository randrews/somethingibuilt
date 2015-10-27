class AddUnfinishedPostToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :unfinished_post, :text
  end
end

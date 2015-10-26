class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.text :text
      t.integer :project_id

      t.timestamps
    end
  end
end

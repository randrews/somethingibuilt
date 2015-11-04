class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.attachment :image
      t.integer :project_id
      t.text :name

      t.timestamps
    end
  end
end

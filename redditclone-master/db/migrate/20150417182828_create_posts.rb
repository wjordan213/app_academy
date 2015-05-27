class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :content
      t.integer :sub_id, null: false
      t.string :url_attrib

      t.timestamps null: false
    end

    add_index :posts, :sub_id
    add_index :posts, :user_id
    add_index :posts, :title
  end
end

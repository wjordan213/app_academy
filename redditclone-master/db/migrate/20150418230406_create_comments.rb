class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :author_id, null: false
      t.integer :post_id, null: false

      t.timestamps null: false
    end

    add_index :comments, :post_id
  end
end

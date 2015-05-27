class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :description

      t.timestamps null: false
    end

    add_index :subs, :user_id
    add_index :subs, :title
  end
end

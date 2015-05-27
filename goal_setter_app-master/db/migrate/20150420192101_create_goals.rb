class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.integer :user_id, null: false
      t.text :notes
      t.date :due_date
      t.string :private_or_public, null: false

      t.timestamps null: false
    end

    add_index :goals, :user_id
    add_index :goals, :due_date
  end
end

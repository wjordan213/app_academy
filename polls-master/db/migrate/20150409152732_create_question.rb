class CreateQuestion < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :poll_id
      t.text :question

      t.timestamps
    end
    add_index :questions, :poll_id
    add_index :questions, :question
  end
end

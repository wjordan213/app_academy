class User < ActiveRecord::Migration
  def change
    remove_column :users, :name
    remove_column :users, :email
    add_column :users, :username, :string, uniqueness: true, presence: true
  end
end

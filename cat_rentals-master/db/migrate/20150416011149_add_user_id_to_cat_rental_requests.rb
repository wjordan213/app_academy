class AddUserIdToCatRentalRequests < ActiveRecord::Migration
  def change
    add_column :cat_rental_requests, :user_id, :integer
    add_index :cat_rental_requests, :user_id
    change_column_null :cat_rental_requests, :user_id, false
  end
end

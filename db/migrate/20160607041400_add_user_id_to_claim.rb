class AddUserIdToClaim < ActiveRecord::Migration
  def change
    add_column :claims, :user_id, :string
  end
end

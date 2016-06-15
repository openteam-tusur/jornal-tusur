class AddTomeToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :tome, :integer
  end
end

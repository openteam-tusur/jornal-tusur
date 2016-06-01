class AddSlugToIssue < ActiveRecord::Migration
  def up
    add_column :issues, :slug, :string
    add_index :issues, :slug, unique: true
    Issue.find_each(&:save)
  end

  def down
    remove_index :issues, :slug
    remove_column :issues, :slug
  end
end

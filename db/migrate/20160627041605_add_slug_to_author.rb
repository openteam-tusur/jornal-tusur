class AddSlugToAuthor < ActiveRecord::Migration
  def up
    add_column :authors, :slug, :string
    add_index :authors, :slug, unique: true
  end

  def down
    remove_index :authors, :slug
    remove_column :authors, :slug
  end
end

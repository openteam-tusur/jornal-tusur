class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :ru_title
      t.string :en_title

      t.timestamps null: false
    end
  end
end

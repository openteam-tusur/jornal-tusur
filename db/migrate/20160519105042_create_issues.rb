class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.integer :year
      t.integer :number
      t.integer :through_number
      t.integer :part

      t.timestamps null: false
    end
  end
end

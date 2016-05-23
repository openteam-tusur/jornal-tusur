class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :issue, index: true, foreign_key: true
      t.text :title_ru
      t.text :title_en
      t.text :annotation_ru
      t.text :annotation_en
      t.integer :page_from
      t.integer :page_to

      t.timestamps null: false
    end
  end
end

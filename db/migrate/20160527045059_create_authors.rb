class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.integer :directory_id
      t.string :ru_surname
      t.string :ru_name
      t.string :ru_patronymic
      t.string :en_surname
      t.string :en_name
      t.string :en_patronymic
      t.text :post
      t.string :phone
      t.string :email

      t.timestamps null: false
    end
  end
end

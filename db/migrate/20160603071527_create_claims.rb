class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.string :surname
      t.string :name
      t.string :patronymic
      t.string :phone
      t.string :email
      t.text :address
      t.text :workplace
      t.attachment :file

      t.timestamps null: false
    end
  end
end

class AddAasmStateToClaim < ActiveRecord::Migration
  def change
    add_column :claims, :aasm_state, :string
  end
end

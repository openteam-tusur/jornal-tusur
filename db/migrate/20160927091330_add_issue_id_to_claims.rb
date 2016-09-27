class AddIssueIdToClaims < ActiveRecord::Migration
  def change
    add_reference :claims, :issue, index: true, foreign_key: true
  end
end

class AddAttachmentPosterToIssues < ActiveRecord::Migration
  def self.up
    change_table :issues do |t|
      t.attachment :poster
    end
  end

  def self.down
    remove_attachment :issues, :poster
  end
end

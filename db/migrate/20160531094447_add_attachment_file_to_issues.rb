class AddAttachmentFileToIssues < ActiveRecord::Migration
  def self.up
    change_table :issues do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :issues, :file
  end
end

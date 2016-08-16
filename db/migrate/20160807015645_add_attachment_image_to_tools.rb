class AddAttachmentImageToTools < ActiveRecord::Migration
  def self.up
    change_table :tools do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :tools, :image
  end
end

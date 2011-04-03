class AddPostIdToLabels < ActiveRecord::Migration
  def self.up
    add_column :labels, :post_id, :integer
  end

  def self.down
    remove_column :labels, :post_id
  end
end

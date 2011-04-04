class RemoveLabels < ActiveRecord::Migration
  def self.up
    remove_column :posts, :labels
  end

  def self.down
    add_column :posts, :labels, :string
  end
end

class RemoveLabelForeignKey < ActiveRecord::Migration
  def self.up
    remove_column :labels, :post_id
  end

  def self.down
    add_column :labels, :post_id
  end
end

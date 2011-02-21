class AddUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :users, :email, :unique => true
    add_index :users, :display_name, :unique => true
  end

  def self.down
    remove_index :users, :email
    remove_index :users, :display_name
  end
end

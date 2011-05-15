class AddAccessSecretToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :access_secret, :string
  end

  def self.down
    remove_column :users, :access_secret
  end
end

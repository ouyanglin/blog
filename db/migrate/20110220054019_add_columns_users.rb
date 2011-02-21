class AddColumnsUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.column(:encrypted_password, :string)
      t.column(:salt, :string)
    end
  end

  def self.down
    change_table :users do |t|
      t.remove(:encrypted_password, :salt)
    end
  end
end

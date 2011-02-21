class ChangeAdmin < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.change_default(:admin, false)
    end
  end

  def self.down
    change_table :users do |t|
      t.change_default(:admin, nil)
    end
  end
end

class AddLabelsColumn < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.column(:labels, :string)
    end
  end

  def self.down
    change_table :posts do |t|
      t.remove(:labels)
    end
  end
end

class CreateLabelPosts < ActiveRecord::Migration
  def self.up
    create_table :label_posts do |t|
      t.integer :label_id
      t.integer :post_id

      t.timestamps
    end

    add_index :label_posts, :label_id
    add_index :label_posts, :post_id
    add_index :label_posts, [:label_id, :post_id], :unique => true
  end

  def self.down
    drop_table :label_posts
  end
end

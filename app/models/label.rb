class Label < ActiveRecord::Base
  has_many :label_posts, :foreign_key => "label_id", :dependent => :destroy
  has_many :posts, :through => :label_posts, :source => :post
end

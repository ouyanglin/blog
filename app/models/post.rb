class Post < ActiveRecord::Base
  attr_accessor :label
  attr_accessible :title, :body

  belongs_to :user
  has_many :label_posts, :foreign_key => "post_id", :dependent => :destroy
  has_many :labels, :through => :label_posts, :source => :label

  validates :title,   :presence => true
  validates :body,    :presence => true
  validates :user_id, :presence => true

  default_scope :order => 'posts.created_at DESC'
end

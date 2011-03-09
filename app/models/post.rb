class Post < ActiveRecord::Base
  attr_accessible :title, :body, :labels

  belongs_to :user

  validates :title,   :presence => true
  validates :body,    :presence => true
  validates :user_id, :presence => true

  default_scope :order => 'posts.created_at DESC'
end
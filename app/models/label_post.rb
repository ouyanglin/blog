class LabelPost < ActiveRecord::Base
  attr_accessible :post_id, :label_id

  belongs_to :post
  belongs_to :label
end

class Comment < ActiveRecord::Base
  attr_accessible :approved, :body, :post_id
  belongs_to :post
end

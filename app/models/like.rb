class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :comment

  enum liked: { not_liked: 0, liked: 1 }
end

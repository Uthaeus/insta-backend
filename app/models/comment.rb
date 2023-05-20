class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :topic

  validates_presence_of :content

  has_many :comments, dependent: :destroy
  has_many :topics, dependent: :destroy
end

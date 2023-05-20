class Topic < ApplicationRecord
  belongs_to :post
  belongs_to :user
  belongs_to :comment

  validates_presence_of :title

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
end

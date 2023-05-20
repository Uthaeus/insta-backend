class Comment < ApplicationRecord
  belongs_to :user

  validates_presence_of :content

  has_many :comments, dependent: :destroy
  has_many :topics, dependent: :destroy
end

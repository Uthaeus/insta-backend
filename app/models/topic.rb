class Topic < ApplicationRecord
  
  belongs_to :user

  validates_presence_of :title

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
end

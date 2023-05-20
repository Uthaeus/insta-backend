class Post < ApplicationRecord
  belongs_to :user

  validates_presence_of :image, :content

  mount_uploader :image, PostUploader

  has_many :comments, dependent: :destroy
  has_many :topics, dependent: :destroy

  
end

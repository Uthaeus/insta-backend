class RemoveLikesColumnFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :post_likes, :integer
    remove_column :users, :comment_likes, :integer
    remove_column :posts, :likes, :integer
    remove_column :comments, :likes, :integer
  end
end

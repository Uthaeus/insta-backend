class AddLikesToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :post_likes, :integer, array: true, default: []
    add_column :users, :comment_likes, :integer, array: true, default: []
  end
end

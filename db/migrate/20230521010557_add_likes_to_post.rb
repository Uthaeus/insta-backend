class AddLikesToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :likes, :integer, array: true, default: []
    add_column :comments, :likes, :integer, array: true, default: []
  end
end

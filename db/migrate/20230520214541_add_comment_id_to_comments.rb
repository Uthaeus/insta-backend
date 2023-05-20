class AddCommentIdToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :comment, foreign_key: true
  end
end

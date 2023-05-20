class CreateTopics < ActiveRecord::Migration[7.0]
  def change
    create_table :topics do |t|
      t.string :title
      t.references :post, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :comment, foreign_key: true

      t.timestamps
    end

    add_index :topics, [:post_id, :user_id, :comment_id], unique: true
    add_reference :posts, :topic, foreign_key: true
    add_reference :comments, :topic, foreign_key: true
  end
end

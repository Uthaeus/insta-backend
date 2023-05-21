class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.integer :liked, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :post, foreign_key: true
      t.references :comment, foreign_key: true

      t.timestamps
    end
  end
end

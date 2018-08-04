class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.integer :user_id, null: false
      t.integer :emomusic_id, null: false

      t.timestamps

      t.index :user_id
      t.index :emomusic_id
      t.index [:user_id, :emomusic_id]
    end
  end
end
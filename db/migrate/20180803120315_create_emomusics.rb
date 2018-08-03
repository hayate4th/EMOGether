class CreateEmomusics < ActiveRecord::Migration[5.1]
  def change
    create_table :emomusics do |t|
      t.text :title
      t.text :composer
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :emomusics, [:user_id, :created_at]
  end
end

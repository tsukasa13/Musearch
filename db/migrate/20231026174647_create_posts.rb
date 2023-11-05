class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :song_id, null: false
      t.string :listen, null: false
      t.text :text, null: false
      t.timestamps
    end
  end
end

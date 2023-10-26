class CreateSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :songs do |t|
      t.integer :user_id, null: false
      t.string :song_name, null: false
      t.string :artist_name, null: false
      t.integer :genre, null: false
      t.timestamps
    end
  end
end

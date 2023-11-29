class AddGenreToSongs < ActiveRecord::Migration[6.1]
  def change
    add_column :songs, :genre, :string
  end
end

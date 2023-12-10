class Song < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  #accepts_nested_attributes_for :posts, allow_destroy: true

  def in_song?
    Song.where(song_name: self.song_name).where.not(id: self.id).exists?
  end
end

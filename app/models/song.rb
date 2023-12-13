class Song < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  #accepts_nested_attributes_for :posts, allow_destroy: true
  validates :song_name, presence: true
  validates :artist_name, presence: true
  validate :unique_combination

  def unique_combination
    if Song.exists?(song_name: song_name)
      if Song.exists?(song_name: song_name, artist_name: artist_name)
        errors.add(:base, '同じ曲名とアーティスト名の組み合わせは既に存在します。')
      end
    end
  end

  #def in_song?
    #Song.where(song_name: self.song_name).where.not(id: self.id).exists?
  #end
end

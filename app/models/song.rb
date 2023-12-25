class Song < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  validates :song_name, presence: true
  validates :artist_name, presence: true
  validate :unique_combination

  def unique_combination
    if Song.exists?(song_name: song_name)
      if Song.exists?(song_name: song_name, artist_name: artist_name)
        errors.add(:base, '同じ曲名とアーティスト名の組み合わせは既に存在します。曲検索で確認してください。')
      end
    end
  end

end

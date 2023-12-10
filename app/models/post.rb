class Post < ApplicationRecord
  belongs_to :song
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def self.likes(user, page, per_page)
    includes(:likes)
      .where(likes: {user_id: user.id})
      .order(created_at: :desc)
      .page(page)
      .per(per_page)
  end
end

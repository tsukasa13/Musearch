class Post < ApplicationRecord
  belongs_to :song
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def self.likes(user, page, per_page)
    includes(:likes)
      .where(likes: {user_id: user.id})
      .order(created_at: :desc)
      .page(page)
      .per(per_page)
  end
end

class Post < ApplicationRecord
  belongs_to :song
  has_many :comments, dependent: :destroy
end

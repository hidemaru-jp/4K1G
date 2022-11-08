class Post < ApplicationRecord
  belongs_to  :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy


  has_one_attached :image

  def get_image
    if image.attached?
      image.variant(resize_to_limit: [100, 100]).processed
    end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end

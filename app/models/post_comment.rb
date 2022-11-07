class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_one_attached :image

  def get_image
    if image.attached?
      image.variant(resize_to_limit: [100, 100]).processed
    end
  end

end

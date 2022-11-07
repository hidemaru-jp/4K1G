class Post < ApplicationRecord
  belongs_to  :user

  has_one_attached :image

  def get_image

    if image.attached?
      image.variant(resize_to_limit: [100, 100]).processed
    end

  end

end

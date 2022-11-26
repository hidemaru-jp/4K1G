class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :notifications, dependent: :destroy
  validates :comment, length: { minimum: 1, maximum: 100 }

  has_one_attached :image

  def get_image
    if image.attached?
      image.variant(resize_to_limit: [100, 100]).processed
    end
  end

end

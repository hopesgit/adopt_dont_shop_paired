class User < ApplicationRecord
  has_many :reviews

  def average_rating
    if self.reviews.average(:rating)
      self.reviews.average(:rating).round(1)
    else
      0
    end
  end
end

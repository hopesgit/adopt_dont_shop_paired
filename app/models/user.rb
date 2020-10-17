class User < ApplicationRecord
  has_many :reviews

  def average_rating
    if self.reviews.average(:rating)
      self.reviews.average(:rating).round(1)
    else
      0
    end
  end

  def highest_rating
    maximum = self.reviews.maximum(:rating)
    self.reviews.where("rating = #{maximum}")
  end

  def lowest_rating
    minimum = self.reviews.minimum(:rating)
    self.reviews.where("rating = #{minimum}")
  end
end

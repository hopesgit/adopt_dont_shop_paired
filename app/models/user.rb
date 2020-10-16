class User < ApplicationRecord
  has_many :reviews

  def average_rating
    sum = self.reviews.sum do |review|
      review.rating
    end
    (sum.to_f / self.reviews.count).round(1)
  end
end

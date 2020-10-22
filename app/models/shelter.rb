class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews

  validates_presence_of :name

  def total_pets
    pets.count
  end

  def average_rating
    reviews.average(:rating)
  end

  def total_applications
    pets.sum do |pet|
      pet.applications.count
    end
  end
end

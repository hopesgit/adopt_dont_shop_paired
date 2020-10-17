class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews

  validates_presence_of :name

  def self.total_number_shelters
    require "pry"; binding.pry
  end
end

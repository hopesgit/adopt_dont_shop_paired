class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  validates_presence_of :name, uniqueness: {case_sensitive: false}

  def adopt
    self.update(status: "Adopted")
  end
end

class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  validates_presence_of :name, uniqueness: {case_sensitive: false}

  def adopt
    self.update(status: "Adopted")
  end

  def app_status(id)
    self.application_pets.where("application_id = #{id}").pluck(:application_pet_status).first
  end
end

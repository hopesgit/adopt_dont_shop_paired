class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates_presence_of :user_id, :status

  def find_user(id)
    User.find(id)
  end

  def approved?
    application_pets.all? {|pet| pet.application_pet_status == "Approved"}
  end

  def rejected?
    application_pets.any? {|pet| pet.application_pet_status == "Rejected"}
  end
end

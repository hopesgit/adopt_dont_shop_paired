require 'rails_helper'

describe Pet, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "relationships" do
    it { should belong_to :shelter }
    it { should have_many :application_pets }
    it { should have_many(:applications).through(:application_pets) }
  end

  describe "#adopt(pet_id)" do
    it "changes to Adopted status from Adoptable" do
      user = User.create!({
                         name: "Truck Johnson",
               street_address: "333 Balloon Way",
                         city: "Heck",
                        state: "AR",
                          zip: 65423
                            })
      shelter_1 = Shelter.create(name: "Kali's Shelter",
                              address: "123 Main St.",
                                 city: "Denver",
                                state: "CO",
                                  zip: "12345")
      pet_1 = shelter_1.pets.create!(name: "Kali",
                                     age: 2,
                                     sex: "female",
                             description: "Cute and sassy cat",
                                  status: "Adoptable",
                                   image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")
      application = Application.create!(user_id: user.id,
                          description: "I'll be a great pet owner!",
                          status: "In Progress")
      ApplicationPet.create!(pet_id: pet_1.id, application_id: application.id)

      expect(pet_1.adopt).to eq(true)
    end
  end
end

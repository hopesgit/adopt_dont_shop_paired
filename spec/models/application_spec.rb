require 'rails_helper'

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe "validations" do
    it { should validate_presence_of :description }
    it { should validate_presence_of :status }
  end

  describe "methods" do
    it "#user_name" do
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
      pet_2 = shelter_1.pets.create!(name: "Ryan",
                                     age: 3,
                                     sex: "male",
                             description: "love bites are the only bites",
                                  status: "Adoptable",
                                   image: "https://images.unsplash.com/photo-1543852786-1cf6624b9987?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80")
      application = Application.create!(user_id: user.id,
                          description: "I'll be a great pet owner!",
                          status: "Pending")

      expect(application.user_name(application.user_id)).to eq("Truck Johnson")
    end

  end
end

require 'rails_helper'

describe "As a visitor" do
  describe "When I visit an applications show page '/applications/:id'" do
    it "it has user name, address, decscription, names of pets, and status" do
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
      ApplicationPet.create!(pet_id: pet_1.id, application_id: application.id)
      ApplicationPet.create!(pet_id: pet_2.id, application_id: application.id)

      visit "/applications/#{application.id}"

      expect(page).to have_content("Application Number: #{application.id}")
      expect(page).to have_content("#{user.name}")
      expect(page).to have_content("#{user.street_address}")
      expect(page).to have_content("#{user.city}")
      expect(page).to have_content("#{user.state}")
      expect(page).to have_content("#{user.zip}")
      expect(page).to have_content("#{application.description}")
      expect(page).to have_link("#{pet_1.name}")
      expect(page).to have_link("#{pet_2.name}")
      expect(page).to have_content("#{application.status}")
    end
  end
end

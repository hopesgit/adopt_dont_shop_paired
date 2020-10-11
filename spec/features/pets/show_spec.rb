require 'rails_helper'

describe "As a visitor" do
  describe "when I visit '/pets/:id'" do
    it "I see the pet with that id including the pet's: image, name, description, approximate age, sex, adoptable/pending adoption status" do
      shelter_1 = Shelter.create(name: "Kali's Shelter",
                              address: "123 Main St.",
                                 city: "Denver",
                                state: "CO",
                                  zip: "12345")
      pet_1 = shelter_1.pets.create(name: "Kali",
                                     age: 2,
                                     sex: "female",
                             description: "Cute and sassy cat",
                                  status: "Adoptable",
                                   image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")

      visit "pets/#{pet_1.id}"

      expect(page).to have_css("img[src*='https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg']")
      expect(page).to have_content("#{pet_1.name}")
      expect(page).to have_content("#{pet_1.description}")
      expect(page).to have_content("#{pet_1.age}")
      expect(page).to have_content("#{pet_1.sex}")
      expect(page).to have_content("#{pet_1.status}")
    end
  end
end

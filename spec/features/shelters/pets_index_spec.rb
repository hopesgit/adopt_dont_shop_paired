require 'rails_helper'

describe "As a visitor" do
  describe "when I visit '/shelters/:shelter_id/pets'" do
    it "I see each Pet that can be adopted from that Shelter with that shelter_id including the Pet's:, image, name, approximate age, sex" do
      shelter_1 = Shelter.create(name: "Kali's Shelter",
                              address: "123 Main St.",
                                 city: "Denver",
                                state: "CO",
                                  zip: "12345")
      pet_1 = shelter_1.pets.create(name: "Kali",
                                     age: 2,
                                     sex: "female",
                                   image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")
      pet_2 = shelter_1.pets.create(name: "Pepper",
                                     age: 3,
                                     sex: "male",
                                   image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")

      visit "/shelters/#{shelter_1.id}/pets"

      expect(page).to have_content("#{pet_1.name}")
      expect(page).to have_content("#{pet_1.age}")
      expect(page).to have_content("#{pet_1.sex}")
      expect(page).to have_content("#{pet_2.name}")
      expect(page).to have_content("#{pet_2.age}")
      expect(page).to have_content("#{pet_2.sex}")
      expect(page).to have_css("img[src*='https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg']")
      expect(page).to have_css("img[src*='https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg']")
    end
  end
end

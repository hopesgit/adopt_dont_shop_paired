require 'rails_helper'

describe "As a visitor" do
  describe "when I visit '/shelters'" do
    it "I see the name of each shelter in the system" do
      shelter_1 = Shelter.create(name: "Kali's Shelter",
                                 address: "123 Main St.",
                                 city: "Denver",
                                 state: "CO",
                                 zip: "12345")
      shelter_1 = Shelter.create(name: "Pepper's Shelter",
                                 address: "678 Happy St.",
                                 city: "Boulder",
                                 state: "CO",
                                 zip: "54321")

      visit '/shelters'

      expect(page).to have_content("Shelters")
      expect(page).to have_content("Address: ")
      expect(page).to have_content("#{shelter_1.address}")
      expect(page).to have_content("#{shelter_1.city}")
      expect(page).to have_content("#{shelter_1.state}")
      expect(page).to have_content("#{shelter_1.zip}")
    end
  end
end

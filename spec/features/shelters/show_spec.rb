require 'rails_helper'

describe "As a visitor" do
  describe "when I visit '/shelters/:id'" do
    it "I see the shelter with that id including the shelter's: name, address, city, state, zip" do
      shelter_1 = Shelter.create(name: "Kali's Shelter",
                              address: "123 Main St.",
                                 city: "Denver",
                                state: "CO",
                                  zip: "12345")

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content("#{shelter_1.address}")
      expect(page).to have_content("#{shelter_1.city}")
      expect(page).to have_content("#{shelter_1.state}")
      expect(page).to have_content("#{shelter_1.zip}")
    end
  end
end

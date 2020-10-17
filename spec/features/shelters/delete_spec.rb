require 'rails_helper'

describe "As a visitor" do
  describe "When I visit a shelter show page" do
    it "I see a link to delete the shelter, When I click the link \"Delete Shelter\" then a 'DELETE' request is sent to '/shelters/:id', the shelter is deleted, and I am redirected to the shelter index page where I no longer see this shelter" do

      shelter_1 = Shelter.create(name: "Kali's Shelter",
                              address: "123 Main St.",
                                 city: "Denver",
                                state: "CO",
                                  zip: "12345")
      shelter_2 = Shelter.create(name: "Grant's Shelter",
                              address: "427 W 34th St.",
                                 city: "Denver",
                                state: "CO",
                                  zip: "80205")

      visit "/shelters/#{shelter_2.id}"

      expect(page).to have_link("Delete Shelter", href: "/shelters/#{shelter_2.id}/delete")

      click_link("Delete Shelter", href: "/shelters/#{shelter_2.id}/delete")
      save_and_open_page

      expect(current_path).to eq("/shelters")
      expect(page).not_to have_content("#{shelter_2.name}")
      expect(page).not_to have_content("#{shelter_2.address}")
      expect(page).not_to have_content("#{shelter_2.zip}")
      expect(page).to have_content("#{shelter_1.name}")
      expect(page).to have_content("#{shelter_1.address}")
      expect(page).to have_content("#{shelter_1.zip}")
    end
  end
end

require 'rails_helper'

describe "As a visitor" do
  describe "when I visit the shelter show page" do
    it "I see a link to update the shelter \"Update Shelter\", When I click the link \"Update Shelter\", Then I am taken to '/shelters/:id/edit' where I  see a form to edit the shelter's data including: name, address, city, state, zip" do

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

      expect(page).to have_link("Update Shelter", href: "/shelters/#{shelter_1.id}/edit")

      click_link("Update Shelter", href: "/shelters/#{shelter_1.id}/edit")

      expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")
      expect(page).to have_field('name')
      expect(page).to have_field('address')
      expect(page).to have_field('city')
      expect(page).to have_field('state')
      expect(page).to have_field('zip')
    end
  end
end

describe "As a visitor" do
  describe "When I fill out the form with updated information and I click the button to submit the form" do
    it "Then a `PATCH` request is sent to '/shelters/:id', the shelter's info is updated, and I am redirected to the Shelter's Show page where I see the shelter's updated info" do

      shelter_1 = Shelter.create(name: "Kali's Shelter",
                              address: "123 Main St.",
                                 city: "Denver",
                                state: "CO",
                                  zip: "12345")

      visit "/shelters/#{shelter_1.id}/edit"

      fill_in('name', :with => 'My Shelter')
      fill_in('address', :with => '123 Main St.')
      fill_in('city', :with => 'Los Gatos')
      fill_in('state', :with => 'CA')
      fill_in('zip', :with => '94245')

      click_on 'Update Shelter'

      expect(current_path).to eq("/shelters/#{shelter_1.id}")
      expect(page).to have_content("94245")
    end
  end
end

describe "when I visit the Shelters Update Page" do
  it "there is a link at the top to the Pets Index Page" do
    shelter_1 = Shelter.create(name: "Kali's Shelter",
                            address: "123 Main St.",
                               city: "Denver",
                              state: "CO",
                                zip: "12345")

    visit "/shelters/#{shelter_1.id}/edit"

    expect(page).to have_link("Pets", href: '/pets')
  end
end

require 'rails_helper'

describe "As a visitor" do
  describe "when I visit '/shelters'" do
    it "I see the name of each shelter in the system along with its full address" do
      shelter_1 = Shelter.create(name: "Kali's Shelter",
                              address: "123 Main St.",
                                 city: "Denver",
                                state: "CO",
                                  zip: "12345")
      shelter_2 = Shelter.create(name: "Pepper's Shelter",
                              address: "678 Happy St.",
                                 city: "Boulder",
                                state: "CO",
                                  zip: "54321")

      visit '/shelters'

      expect(page).to have_content("Shelters")
      expect(page).to have_content("Address: ")
      expect(page).to have_content("#{shelter_1.name}")
      expect(page).to have_content("#{shelter_1.address}")
      expect(page).to have_content("#{shelter_1.city}")
      expect(page).to have_content("#{shelter_1.state}")
      expect(page).to have_content("#{shelter_1.zip}")
      expect(page).to have_content("#{shelter_2.name}")
      expect(page).to have_content("#{shelter_2.address}")
      expect(page).to have_content("#{shelter_2.city}")
      expect(page).to have_content("#{shelter_2.state}")
      expect(page).to have_content("#{shelter_2.zip}")
    end
  end
end

describe "Next to every shelter, I see a link to edit that shelter's info and one to delete the shelter" do
  it "when I click the edit link I should be taken to that shelters edit page where I can update its information, and if I click delete I am returned to the Shelter Index Page where I no longer see that shelter" do
    shelter_1 = Shelter.create(name: "Kali's Shelter",
                            address: "123 Main St.",
                               city: "Denver",
                              state: "CO",
                                zip: "12345")
    shelter_2 = Shelter.create(name: "Pepper's Shelter",
                            address: "678 Happy St.",
                               city: "Boulder",
                              state: "CO",
                                zip: "54321")

    visit '/shelters'

    expect(page).to have_css('.update', count: 2)
    expect(page).to have_css('.delete', count: 2)

    click_link("Update Shelter", href: "/shelters/#{shelter_1.id}/edit")
    fill_in('name', :with => 'My Shelter')
    fill_in('address', :with => '123 Main St.')
    fill_in('city', :with => 'Los Gatos')
    fill_in('state', :with => 'CA')
    fill_in('zip', :with => '94245')

    click_on 'Update Shelter'

    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).to have_content("My Shelter")
    expect(page).to have_content("Los Gatos")
    expect(page).to have_content("CA")
    expect(page).to have_content("94245")

    visit '/shelters'
    click_link("Delete Shelter", href: "/shelters/#{shelter_2.id}/delete")
    expect(page).not_to have_content("Pepper's Shelter")
  end
end

describe "when I visit the Shelters Index Page" do
  it "there is a link at the top to the Pets Index Page" do
    visit '/shelters'

    expect(page).to have_link("Pets", href: '/pets')
  end
end

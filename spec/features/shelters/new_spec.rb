require 'rails_helper'

describe "As a visitor" do
  describe "when I visit the shelter index page" do
    it "I see a link to create a new Shelter, 'New Shelter', that when clicked takes me to '/shelters/new' where I  see a form for a new shelter" do

      visit "/shelters"

      expect(page).to have_link("New Shelter", href: '/shelters/new')
    end
  end
end

describe "As a visitor" do
  describe "When I fill out the form with a new shelter's: name, address, city, state, zip, And I click the button 'Create Shelter' to submit the form" do
    it "Then a `POST` request is sent to '/shelters', a new shelter is created, and I am redirected to the Shelter Index page where I see the new Shelter listed." do

      visit "/shelters"
      click_link("New Shelter")
      fill_in('name', :with => 'Shelter Name')
      fill_in('address', :with => '123 Main St.')
      fill_in('city', :with => 'San Francisco')
      fill_in('state', :with => 'CA')
      fill_in('zip', :with => '94115')
      click_on 'New Shelter'

      expect(current_path).to eq('/shelters')
      expect(page).to have_content("Shelter Name")
      expect(page).to have_content("123 Main St.")
      expect(page).to have_content("San Francisco")
      expect(page).to have_content("CA")
      expect(page).to have_content("94115")
    end
  end
end

describe "when I visit the Shelters New Page" do
  it "there is a link at the top to the Pets Index Page and Shelters Index page" do
    shelter_1 = Shelter.create(name: "Kali's Shelter",
                            address: "123 Main St.",
                               city: "Denver",
                              state: "CO",
                                zip: "12345")

    visit "/shelters/new"

    expect(page).to have_link("Pets", href: '/pets')
    expect(page).to have_link("Shelters", href: '/shelters')
  end
end

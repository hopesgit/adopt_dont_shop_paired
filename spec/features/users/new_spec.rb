require 'rails_helper'

describe "As a visitor" do
  describe "When I visit '/users/new'" do
    it "I see a form to create a new user, and when I fill in the form with my Name, Street Address, City, State, and Zip then I'm taken to my new user's show page and I see all of the information I entered in the form" do
      visit '/users/new'

      fill_in('name', :with => 'Sally Peach')
      fill_in('street_address', :with => '123 Main St.')
      fill_in('city', :with => 'San Francisco')
      fill_in('state', :with => 'CA')
      fill_in('zip', :with => '94115')
      click_on 'Submit'

      expect(current_path).to eq("/users/#{user_1.id}/show")
      expect(page).to have_content("Sally Peach")
      expect(page).to have_content("123 Main St.")
      expect(page).to have_content("San Francisco")
      expect(page).to have_content("CA")
      expect(page).to have_content("94115")

    end
  end
end

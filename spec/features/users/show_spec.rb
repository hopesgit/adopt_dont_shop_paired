require 'rails_helper'

describe "As a visitor" do
  describe "When I visit a User's show page" do
    it "I see all that User's information including the User's Name, Street Address, City, State, Zip" do
      user_1 = User.create(name: "Sally Peach",
                 street_address: "123 Main St.",
                           city: "Denver",
                          state: "CO",
                            zip: "80205")

      visit "/users/#{user_1.id}"

      expect(page).to have_content("Sally Peach")
      expect(page).to have_content("123 Main St.")
      expect(page).to have_content("Denver")
      expect(page).to have_content("CO")
      expect(page).to have_content("80205")
    end
  end
end

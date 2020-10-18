require "rails_helper"

describe "As a visitor" do
  describe "when I get to the new application page" do
    it "has a form for me to fill out" do

      user = User.create!({
                          name: "Carly Rae Jepsen",
                          street_address: "444 Maybe Ln",
                          city: "Hollywood",
                          state: "CA",
                          zip: 33333
                          })
      visit '/pets'
      click_link("Start an Application")
      expect(current_path).to eq("/applications/new")

      fill_in("User Name", with: "#{user.name}")
      click_on("Submit")

      expect(page).to have_content("#{user.name}")
      expect(page).to have_content("#{user.street_address}")
      expect(page).to have_content("#{user.city}")
      expect(page).to have_content("#{user.state}")
      expect(page).to have_content("#{user.zip}")
      expect(page).to have_content("Status: In Progress")
    end
  end
end

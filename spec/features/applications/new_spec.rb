require "rails_helper"

describe "As a visitor" do
  before(:each) do
    @user = User.create!({
                        name: "Carly Rae Jepsen",
                        street_address: "444 Maybe Ln",
                        city: "Hollywood",
                        state: "CA",
                        zip: 33333
                        })
  end
    describe "when I get to the new application page" do
      it "has a form for me to fill out" do
        visit '/pets'
        click_link("Start an Application")
        expect(current_path).to eq("/applications/new")

        fill_in("User Name", with: "#{@user.name}")
        click_on("Submit")

        expect(page).to have_content("#{@user.name}")
        expect(page).to have_content("#{@user.street_address}")
        expect(page).to have_content("#{@user.city}")
        expect(page).to have_content("#{@user.state}")
        expect(page).to have_content("#{@user.zip}")
        expect(page).to have_content("Status: In Progress")
      end

      it "will flash an error if it can't find user" do
        visit("/applications/new")

        fill_in("User Name", with: "Jenny")
        click_on("Submit")

        expect(current_path).to eq("/applications/new")
        expect(page).to have_content("User could not be found. Please try again.")
      end
    end
end

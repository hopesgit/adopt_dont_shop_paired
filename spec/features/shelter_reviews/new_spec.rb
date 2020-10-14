require "rails_helper"

describe "As a Visitor" do
  describe "When I visit a shelter's show page" do
    it "has this link" do
      shelter = Shelter.create!({
                            name: "Dog Lovers",
                            address: "444 Dogbone Dr",
                            city: "Heck",
                            state: "AR",
                            zip: 65423
                            })
      visit("/shelters/#{shelter.id}")

      expect(page).to have_link("Add a Review")
      click_on("Add a Review!")
      expect(current_path).to eq("/shelters/#{shelter.id}/reviews/new")
    end
  end

  describe "When I click the link" do
    it "I find this content" do
      shelter = Shelter.create!({
                            name: "Dog Lovers",
                            address: "444 Dogbone Dr",
                            city: "Heck",
                            state: "AR",
                            zip: 65423
                            })
      visit("/shelters/#{shelter.id}/reviews/new")

      fill_in("Title", with: "Bark!")
      fill_in("Rating", with: 5)
      fill_in("Content", with: "So much cute!")
      fill_in("Picture", with: "dog.png")
      fill_in("Name", with: "Stick Brightling")
      click_on("Submit")
    end
  end
end

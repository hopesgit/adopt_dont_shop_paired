require "rails_helper"

describe "As a visitor" do
  describe "When I navigate to a shelter's show page" do
    it "I see this content" do
      shelter_1 = Shelter.create!(name: "Kali's Shelter",
                              address: "123 Main St.",
                                 city: "Denver",
                                state: "CO",
                                  zip: "12345")
      user = User.create!({name: "Truck Johnson",
                 street_address: "333 Balloon Way",
                           city: "Heck",
                          state: "AR",
                            zip: 65423})
      review = Review.create!({title: "So many lovelies!",
                              rating: 5,
                             content: "I visited earlier today to come look at all the lovely dogs and get all guilty about not being able to adopt one, and today's visit didn't disappoint!",
                             picture: "https://p1cdn4static.civiclive.com/UserFiles/Servers/Server_1881137/Image/Residents/Animal%20Services/Aurora%20Animal%20Shelter/020987.jpg",
                              user_id: "#{user.id}",
                           shelter_id: "#{shelter_1.id}" })

      visit("/shelters/#{shelter_1.id}")
      expect(page).to have_content("So many lovelies!")
      within("div#review-#{review.id}") do
        click_button("Delete Review")
      end
      expect(page).to_not have_content("So many lovelies!")
    end
  end
end

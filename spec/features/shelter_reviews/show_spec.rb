require "rails_helper"

describe "As a visitor" do
  describe "When I visit a shelter's show page" do
    it "has reviews for the shelter" do
      user = User.create!({
                          name: "Truck Johnson",
                          street_address: "333 Balloon Way",
                          city: "Heck",
                          state: "AR",
                          zip: 65423
                          })
      shelter = Shelter.create!({
                            name: "Dog Lovers",
                            address: "444 Dogbone Dr",
                            city: "Heck",
                            state: "AR",
                            zip: 65423
                            })
      review = Review.create!({
                              title: "So many lovelies!",
                              rating: 5,
                              content: "I visited earlier today to come look at all the lovely dogs and get all guilty about not being able to adopt one, and today's visit didn't disappoint!",
                              picture: "https://p1cdn4static.civiclive.com/UserFiles/Servers/Server_1881137/Image/Residents/Animal%20Services/Aurora%20Animal%20Shelter/020987.jpg",
                              user_name: "#{user.name}",
                              shelter_id: "#{shelter.id}"
                              })
      visit("/shelters/#{shelter.id}")

      expect(current_path).to eq("/shelters/#{shelter.id}")
      expect(page).to have_content("#{review.title}")
      expect(page).to have_content("#{review.content}")
      expect(page).to have_content("#{review.user_name}")
      expect(page).to have_content("Rating: #{review.rating}")
    end
  end
end

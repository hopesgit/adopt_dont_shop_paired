require 'rails_helper'

describe "As a visitor" do
  describe "When I click on Edit Review" do
    it "I can update any of these fields and submit the form. When the form is submitted, I should return to that shelter's show page and I can see my updated review" do
      shelter = Shelter.create!({
                               name: "Kali's Shelter",
                            address: "123 Main St.",
                               city: "Denver",
                              state: "CO",
                                zip: 12345
                                  })
      user = User.create!({
                         name: "Truck Johnson",
               street_address: "333 Balloon Way",
                         city: "Heck",
                        state: "AR",
                          zip: 65423
                            })
      review = Review.create!({
                           title: "So many lovelies!",
                          rating: 5,
                         content: "I visited earlier today to come look at all the lovely dogs and get all guilty about not being able to adopt one, and today's visit didn't disappoint!",
                         picture: "https://p1cdn4static.civiclive.com/UserFiles/Servers/Server_1881137/Image/Residents/Animal%20Services/Aurora%20Animal%20Shelter/020987.jpg",
                       user_name: user.name,
                         user_id: user.id,
                      shelter_id: shelter.id
                              })

      visit "/shelters/#{shelter.id}"

      click_link("Edit Review", href: "/shelters/#{shelter.id}/reviews/#{review.id}/edit")
      fill_in('title', :with => 'So many lovelies!')
      fill_in('rating', :with => 4)
      fill_in('content', :with => 'Place was neat')
      fill_in('picture', :with => 'https://images.unsplash.com/photo-1548681528-6a5c45b66b42?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80')
      click_on("Submit")

      expect(current_path).to eq("/shelters/#{shelter.id}")
      expect(page).to have_content("So many lovelies!")
      expect(page).to have_content(4)
      expect(page).to have_content("Place was neat")
      expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1548681528-6a5c45b66b42?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80']")
      expect(page).not_to have_content("I visited earlier today to come look at all the lovely dogs and get all guilty about not being able to adopt one, and today's visit didn't disappoint!")
    end
  end
end

describe "As a visitor, when I visit the page to edit a review" do
  describe "and I fail to enter a title, a rating, and/or content in the edit shelter review form, but still try to submit the form" do
    it "I see a flash message indicating that I need to fill in a title, rating, and content in order to edit a shelter review and I'm returned to the edit form to edit that review" do
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
                              user_name: user.name,
                              user_id: user.id,
                              shelter_id: shelter.id})

      visit "/shelters/#{shelter.id}"

      click_link("Edit Review", href: "/shelters/#{shelter.id}/reviews/#{review.id}/edit")
      fill_in('title', :with => "")
      fill_in('rating', :with => 4)
      fill_in('content', :with => 'Place was neat')
      fill_in('picture', :with => 'https://images.unsplash.com/photo-1548681528-6a5c45b66b42?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80')
      click_on("Submit")

      expect(page).to have_content("Please fill out this field.")
      expect(page).to have_button("Submit")
    end
  end
end

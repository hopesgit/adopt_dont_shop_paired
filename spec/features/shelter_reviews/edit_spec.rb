describe "As a visitor" do
  describe "When I click on Edit Review" do
    it "I can update any of these fields and submit the form. When the form is submitted, I should return to that shelter's show page and I can see my updated review" do
      shelter_1 = Shelter.create(name: "Kali's Shelter",
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

      visit "/shelters/#{shelter_1.id}"

      click_link("Update Review", href: "/shelters/#{shelter_1.id}/reviews/edit")
      fill_in('title', :with => 'So many lovelies!')
      fill_in('rating', :with => 4)
      fill_in('content', :with => 'Place was neat')
      fill_in('picture', :with => 'https://images.unsplash.com/photo-1548681528-6a5c45b66b42?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80')
      click_on("Submit")

      expect(current_path).to eq("/shelters/#{shelter_1.id}")
      expect(page).to have_content("So many lovelies!")
      expect(page).to have_content(4)
      expect(page).to have_content("Place was neat")
      expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1548681528-6a5c45b66b42?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80']")
      expect(page).not_to have_content("I visited earlier today to come look at all the lovely dogs and get all guilty about not being able to adopt one, and today's visit didn't disappoint!")
    end
  end
end

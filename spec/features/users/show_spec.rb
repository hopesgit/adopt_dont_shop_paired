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

    it "Then I see every review this User has written including the review's title, rating, and content" do
      shelter_1 = Shelter.create(name: "Kali's Shelter",
                              address: "123 Main St.",
                                 city: "Denver",
                                state: "CO",
                                  zip: "12345")
      user_1 = User.create!(name: "Sally Peach",
                 street_address: "123 Main St.",
                           city: "Denver",
                          state: "CO",
                            zip: "80205")
      review_1 = Review.create!({title: "Sally's Review",
                                rating: 4,
                               content: "Nice place to find a great pet!",
                               picture: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                               user_id: "#{user_1.id}",
                            shelter_id: "#{shelter_1.id}"
                             })

      visit "/users/#{user_1.id}"

      expect(page).to have_content("Sally's Review")
      expect(page).to have_content(4)
      expect(page).to have_content("Nice place to find a great pet!")
      expect(page).to have_css("img[src*='https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg']")
    end

    it "Then I see the average rating of all of their reviews" do
      shelter_1 = Shelter.create(name: "Kali's Shelter",
                              address: "123 Main St.",
                                 city: "Denver",
                                state: "CO",
                                  zip: "12345")
      user_1 = User.create!(name: "Sally Peach",
                 street_address: "123 Main St.",
                           city: "Denver",
                          state: "CO",
                            zip: "80205")
      review_1 = Review.create!({title: "Sally's Review",
                                rating: 4,
                               content: "Nice place to find a great pet!",
                               picture: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                               user_id: "#{user_1.id}",
                            shelter_id: "#{shelter_1.id}"
                             })
      review_2 = Review.create!({title: "Sally's Thoughts",
                                rating: 5,
                               content: "Love this shelter!",
                               user_id: "#{user_1.id}",
                            shelter_id: "#{shelter_1.id}"
                             })
      review_3 = Review.create!({title: "Pollllly",
                                rating: 3,
                               content: "It's alright, but not my favorite",
                               user_id: "#{user_1.id}",
                            shelter_id: "#{shelter_1.id}"
                             })
      visit "/users/#{user_1.id}"

      expect(page).to have_content("Average Rating:")
      expect(page).to have_content(user_1.average_rating)
    end

    it "Then I see a section for 'Highlighted Reviews' showing the review with the best rating that this user has written and the review with the worst rating that this user has written" do
      shelter_1 = Shelter.create(name: "Kali's Shelter",
                              address: "123 Main St.",
                                 city: "Denver",
                                state: "CO",
                                  zip: "12345")
      user_1 = User.create!(name: "Sally Peach",
                 street_address: "123 Main St.",
                           city: "Denver",
                          state: "CO",
                            zip: "80205")
      review_1 = Review.create!({title: "Sally's Review",
                                rating: 4,
                               content: "Nice place to find a great pet!",
                               picture: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                               user_id: "#{user_1.id}",
                            shelter_id: "#{shelter_1.id}"
                             })
      review_2 = Review.create!({title: "Sally's Thoughts",
                                rating: 5,
                               content: "Love this shelter!",
                               user_id: "#{user_1.id}",
                            shelter_id: "#{shelter_1.id}"
                             })
      review_3 = Review.create!({title: "Pollllly",
                                rating: 3,
                               content: "It's alright, but not my favorite",
                               user_id: "#{user_1.id}",
                            shelter_id: "#{shelter_1.id}"
                             })
      visit "/users/#{user_1.id}"

      within "#highlights" do
        expect(page).to have_content("Sally's Thoughts")
        expect(page).to have_content("Pollllly")
        expect(page).not_to have_content("Sally's Review")
      end
    end
  end
end

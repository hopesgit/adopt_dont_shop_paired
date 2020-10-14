require 'rails_helper'

describe "As a visitor" do
  describe "when I visit '/shelters/:id'" do
    it "I see the shelter with that id including the shelter's: name, address, city, state, zip" do
      shelter_1 = Shelter.create(name: "Kali's Shelter",
                              address: "123 Main St.",
                                 city: "Denver",
                                state: "CO",
                                  zip: "12345")

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content("#{shelter_1.address}")
      expect(page).to have_content("#{shelter_1.city}")
      expect(page).to have_content("#{shelter_1.state}")
      expect(page).to have_content("#{shelter_1.zip}")
    end
  end
end

describe "when I visit the Shelters Show Page" do
  it "there is a link at the top to the Pets Index Page, the Shelters Index page, and a link to take me to that shelter's pets page ('/shelters/:id/pets')" do
    shelter_1 = Shelter.create(name: "Kali's Shelter",
                            address: "123 Main St.",
                               city: "Denver",
                              state: "CO",
                                zip: "12345")

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_link("Pets", href: '/pets')
    expect(page).to have_link("Shelters", href: '/shelters')
    expect(page).to have_link("Pets at this Shelter", href: "/shelters/#{shelter_1.id}/pets")
  end

  it "I see a link to edit the shelter review next to each review, and when I click on this link, I am taken to an edit shelter review path on this new page, I see a form that includes that review's pre populated data: title, rating, content, image, and the name of the user that wrote the review" do
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
    review = Review.create!({title: "LOVE",
                            rating: 5,
                           content: "Srsly the best!",
                           picture: "https://images.unsplash.com/photo-1548681528-6a5c45b66b42?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
                            user_id: "#{user.id}",
                         shelter_id: "#{shelter_1.id}"})

    visit "/shelters/#{shelter_1.id}"
    expect(page).to have_css('.update', count: 2)

    click_link("Edit Review", href: "/shelters/#{@shelter_1.id}/reviews/edit")

    expect(page).to have_field('title')
    expect(page).to have_field('rating')
    expect(page).to have_field('content')
    expect(page).to have_field('picture')
  end

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

    click_link("Edit Review", href: "/shelters/#{@shelter_1.id}/reviews/edit")
    fill_in('title', :with => 'So many lovelies!')
    fill_in('rating', :with => 4)
    fill_in('content', :with => 'Place was neat')
    fill_in('picture', :with => 'https://images.unsplash.com/photo-1548681528-6a5c45b66b42?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80')
    click_on("Submit")

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    expect(page).to have_content("So many lovelies!")
    expect(page).to have_content(4)
    expect(page).to have_content("Place was neat")
    expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1548681528-6a5c45b66b42?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80']")
    expect(page).not_to have_content("I visited earlier today to come look at all the lovely dogs and get all guilty about not being able to adopt one, and today's visit didn't disappoint!")
  end
end

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

    it "has this content when looking at a shelter's show page" do
      user_1 = User.create!({
                            name: "Truck Johnson",
                            street_address: "333 Balloon Way",
                            city: "Heck",
                            state: "AR",
                            zip: 65423
                            })

      user_2 = User.create!({
                            name: "Mary Shelley",
                            street_address: "555 Stein Dr",
                            city: "Olde Tymes",
                            state: "PA",
                            zip: 33333
                            })
      shelter = Shelter.create!({
                            name: "Dog Lovers",
                            address: "444 Dogbone Dr",
                            city: "Heck",
                            state: "AR",
                            zip: 65423
                            })
      pet_1 = shelter.pets.create!(name: "Kali",
                                     age: 2,
                                     sex: "female",
                             description: "Cute and sassy cat",
                                  status: "Adoptable",
                                   image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")
      pet_2 = shelter.pets.create!(name: "Ryan",
                                     age: 3,
                                     sex: "male",
                             description: "love bites are the only bites",
                                  status: "Adoptable",
                                   image: "https://images.unsplash.com/photo-1543852786-1cf6624b9987?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80")
      application_1 = Application.create!(user_id: user_1.id,
                          description: "I'll be a great pet owner!",
                          status: "In Progress")
      application_2 = Application.create!(user_id: user_2.id,
                          description: "You know these doggos will be safe with me!",
                          status: "In Progress")
      ApplicationPet.create(pet_id: pet_1.id, application_id: application_1.id, application_pet_status: "")
      ApplicationPet.create(pet_id: pet_2.id, application_id: application_2.id, application_pet_status: "")
      review_1 = Review.create!({
                              title: "So many lovelies!",
                              rating: 5,
                              content: "I visited earlier today to come look at all the lovely dogs and get all guilty about not being able to adopt one, and today's visit didn't disappoint!",
                              picture: "https://p1cdn4static.civiclive.com/UserFiles/Servers/Server_1881137/Image/Residents/Animal%20Services/Aurora%20Animal%20Shelter/020987.jpg",
                              user_name: user_1.name,
                              user_id: user_1.id,
                              shelter_id: shelter.id
                              })
      review_2 = Review.create!({
                                title: "So many lovelies!",
                                rating: 3,
                                content: "I visited earlier and it was disappointing!",
                                picture: "",
                                user_name: user_2.name,
                                user_id: user_2.id,
                                shelter_id: shelter.id
                                })

      visit("shelters/#{shelter.id}")

      expect(page).to have_content("Number of pets at this shelter: #{shelter.total_pets}")
      expect(page).to have_content("Average rating: #{shelter.average_rating}")
      expect(page).to have_content("Total applications on pets at this shelter: #{shelter.total_applications}")
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
                            shelter_id: shelter.id
                            })

    visit "/shelters/#{shelter.id}"

    click_link("Edit Review", href: "/shelters/#{shelter.id}/reviews/#{review.id}/edit")

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
                          user_name: user.name,
                         shelter_id: "#{shelter_1.id}" })

    visit "/shelters/#{shelter_1.id}"

    click_link("Edit Review", href: "/shelters/#{shelter_1.id}/reviews/#{review.id}/edit")
    fill_in('title', :with => 'So many lovelies!')
    fill_in('rating', :with => 4)
    fill_in('content', :with => 'Place was neat')
    fill_in('picture', :with => 'https://images.unsplash.com/photo-1548681528-6a5c45b66b42?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80')

    click_on("Submit")

    expect(page).to have_content("So many lovelies!")
    expect(page).to have_content(4)
    expect(page).to have_content("Place was neat")
    expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1548681528-6a5c45b66b42?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80']")
    expect(page).not_to have_content("I visited earlier today to come look at all the lovely dogs and get all guilty about not being able to adopt one, and today's visit didn't disappoint!")
  end

end

require 'rails_helper'

describe "When I visit a pets show page I see a link to view all applications for this pet" do
  it "When I click that link I can see a list of all the names of applicants for this pet and each applicants name is a link to the application's show page" do
    user_1 = User.create!({
                       name: "Truck Johnson",
             street_address: "333 Balloon Way",
                       city: "Heck",
                      state: "AR",
                        zip: 65423
                          })
    user_2 = User.create!({
                       name: "Sally Peach",
             street_address: "123 Main St",
                       city: "Boulder",
                      state: "CO",
                        zip: 80305
                          })
    shelter_1 = Shelter.create(name: "Kali's Shelter",
                            address: "123 Main St.",
                               city: "Denver",
                              state: "CO",
                                zip: "12345")
    pet_1 = shelter_1.pets.create!(name: "Kali",
                                   age: 2,
                                   sex: "female",
                           description: "Cute and sassy cat",
                                status: "Adoptable",
                                 image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")
    pet_2 = shelter_1.pets.create!(name: "Ryan",
                                   age: 3,
                                   sex: "male",
                           description: "love bites are the only bites",
                                status: "Adoptable",
                                 image: "https://images.unsplash.com/photo-1543852786-1cf6624b9987?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80")
    application_1 = Application.create!(user_id: user_1.id,
                                     description: "I'll be a great pet owner!",
                                          status: "Approved")
    application_2 = Application.create!(user_id: user_2.id,
                                     description: "I'm the best'",
                                          status: "In Progress")
    ApplicationPet.create(pet_id: pet_1.id, application_id: application_1.id, application_pet_status: "Pending")
    ApplicationPet.create(pet_id: pet_1.id, application_id: application_2.id, application_pet_status: "Pending")

    visit "pets/#{pet_1.id}"

    click_on("View All Applications")
save_and_open_page
    expect(current_path).to eq("/pets/#{pet_1.id}/applications")
    expect(page).to have_content("#{user_1.name}")
    expect(page).to have_content("#{user_2.name}")
  end
end

describe "When I visit a pet applications index page for a pet that has no applications on them" do
  it "I see a message saying that there are no applications for this pet yet" do
    user_1 = User.create!({
                       name: "Truck Johnson",
             street_address: "333 Balloon Way",
                       city: "Heck",
                      state: "AR",
                        zip: 65423
                          })
    user_2 = User.create!({
                       name: "Sally Peach",
             street_address: "123 Main St",
                       city: "Boulder",
                      state: "CO",
                        zip: 80305
                          })
    shelter_1 = Shelter.create(name: "Kali's Shelter",
                            address: "123 Main St.",
                               city: "Denver",
                              state: "CO",
                                zip: "12345")
    pet_1 = shelter_1.pets.create!(name: "Kali",
                                   age: 2,
                                   sex: "female",
                           description: "Cute and sassy cat",
                                status: "Adoptable",
                                 image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")
    pet_2 = shelter_1.pets.create!(name: "Ryan",
                                   age: 3,
                                   sex: "male",
                           description: "love bites are the only bites",
                                status: "Adoptable",
                                 image: "https://images.unsplash.com/photo-1543852786-1cf6624b9987?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80")
    application_1 = Application.create!(user_id: user_1.id,
                                     description: "I'll be a great pet owner!",
                                          status: "Approved")
    application_2 = Application.create!(user_id: user_2.id,
                                     description: "I'm the best'",
                                          status: "In Progress")
    ApplicationPet.create(pet_id: pet_2.id, application_id: application_1.id, application_pet_status: "Pending")
    ApplicationPet.create(pet_id: pet_2.id, application_id: application_2.id, application_pet_status: "Pending")

    visit "pets/#{pet_1.id}"

    click_on("View All Applications")
save_and_open_page
    expect(current_path).to eq("/pets/#{pet_1.id}/applications")
    expect(page).to have_content("There are no applications for this pet yet.")
  end
end

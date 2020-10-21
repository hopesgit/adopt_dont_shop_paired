require 'rails_helper'

describe "As a visitor" do
  describe "when I visit '/pets/:id'" do
    it "I see the pet with that id including the pet's: image, name, description, approximate age, sex, adoptable/pending adoption status" do
      shelter_1 = Shelter.create(name: "Kali's Shelter",
                              address: "123 Main St.",
                                 city: "Denver",
                                state: "CO",
                                  zip: "12345")
      pet_1 = shelter_1.pets.create(name: "Kali",
                                     age: 2,
                                     sex: "female",
                             description: "Cute and sassy cat",
                                  status: "Adoptable",
                                   image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")

      visit "pets/#{pet_1.id}"

      expect(page).to have_css("img[src*='https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg']")
      expect(page).to have_content("#{pet_1.name}")
      expect(page).to have_content("#{pet_1.description}")
      expect(page).to have_content("#{pet_1.age}")
      expect(page).to have_content("#{pet_1.sex}")
      expect(page).to have_content("#{pet_1.status}")
    end
  end
end

describe "when I visit the Pet Show Page" do
  it "there is a link at the top to the Pets Index Page and the Shelters Index Page" do
    shelter_1 = Shelter.create(name: "Kali's Shelter",
                            address: "123 Main St.",
                               city: "Denver",
                              state: "CO",
                                zip: "12345")
    pet_1 = shelter_1.pets.create(name: "Kali",
                                   age: 2,
                                   sex: "female",
                           description: "Cute and sassy cat",
                                status: "Adoptable",
                                 image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")

    visit "pets/#{pet_1.id}"

    expect(page).to have_link("Pets", href: '/pets')
    expect(page).to have_link("Shelters", href: '/shelters')
  end
end

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

    expect(current_path).to eq("/pets/#{pet_1.id}/applications")
    expect(page).to have_content("#{user_1.name}")
    expect(page).to have_content("#{user_2.name}")
  end
end

require 'rails_helper'

describe "Pet index page" do
  it "shows all pets in system" do
    shelter_1 = Shelter.create(name: "Kali's Shelter",
                            address: "123 Main St.",
                               city: "Denver",
                              state: "CO",
                                zip: "12345")
    shelter_2 = Shelter.create(name: "Dave's Shelter",
                            address: "456 Main St.",
                               city: "Denver",
                              state: "CO",
                                zip: "80205")
    pet_1 = shelter_1.pets.create(name: "Kali",
                                   age: 2,
                                   sex: "female",
                                 image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")
    pet_2 = shelter_1.pets.create(name: "Pepper",
                                   age: 3,
                                   sex: "male",
                                 image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")
    pet_3 = shelter_2.pets.create(name: "Boots",
                                   age: 1,
                                   sex: "female",
                                 image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")
    visit '/pets'

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.age)
    expect(page).to have_content(pet_1.sex)
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_2.age)
    expect(page).to have_content(pet_2.sex)
    expect(page).to have_content(pet_3.name)
    expect(page).to have_content(pet_3.age)
    expect(page).to have_content(pet_3.sex)
    expect(page).to have_content(pet_1.shelter.name)
    expect(page).to have_content(pet_2.shelter.name)
    expect(page).to have_content(pet_3.shelter.name)
    expect(page).to have_css("img[src*='https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg']")
    expect(page).to have_css("img[src*='https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg']")
    expect(page).to have_css("img[src*='https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg']")

  end

end

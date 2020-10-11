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
                                 image: "https://images.unsplash.com/photo-1548681528-6a5c45b66b42?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80")
    pet_3 = shelter_2.pets.create(name: "Boots",
                                   age: 1,
                                   sex: "female",
                                 image: "https://images.unsplash.com/photo-1513360371669-4adf3dd7dff8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80")
    visit '/pets'

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.age)
    expect(page).to have_content(pet_1.sex)
    expect(page).to have_css("img[src*='https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg']")
    expect(page).to have_content(pet_1.shelter.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_2.age)
    expect(page).to have_content(pet_2.sex)
    expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1548681528-6a5c45b66b42?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80']")
    expect(page).to have_content(pet_2.shelter.name)
    expect(page).to have_content(pet_3.name)
    expect(page).to have_content(pet_3.age)
    expect(page).to have_content(pet_3.sex)
    expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1513360371669-4adf3dd7dff8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80']")
    expect(page).to have_content(pet_3.shelter.name)
  end
end

describe "Pets Index page" do
  it "has a link to edit pet's info next to every pet, and when I click the link I should be taken to that pets edit page where I can update its information, and if I click delete I am returned to the Pets Index Page where I no longer see that pet" do
    shelter_1 = Shelter.create(name: "Kali's Shelter",
                            address: "123 Main St.",
                               city: "Denver",
                              state: "CO",
                                zip: "12345")
    pet_1 = shelter_1.pets.create(name: "Kali",
                                   age: 2,
                                   sex: "female",
                                 image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")
    pet_2 = shelter_1.pets.create(name: "Pepper",
                                   age: 3,
                                   sex: "male",
                                 image: "https://images.unsplash.com/photo-1548681528-6a5c45b66b42?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80")
    visit '/pets'

    expect(page).to have_css('.update', count: 2)
    expect(page).to have_css('.delete', count: 2)

    click_link("Update Pet", href: "/pets/#{pet_1.id}/edit")
    fill_in('name', :with => 'Boots')
    fill_in('age', :with => '4')
    fill_in('sex', :with => 'male')
    fill_in('image', :with => 'https://images.unsplash.com/photo-1548681528-6a5c45b66b42?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80')
    click_on("Update Pet")

    expect(current_path).to eq("/pets/#{pet_1.id}")
    expect(page).to have_content("Boots")
    expect(page).to have_content("4")
    expect(page).to have_content("male")
    expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1548681528-6a5c45b66b42?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80']")
    expect(page).not_to have_content("Kali")

    visit '/pets'
    click_link("Delete Pet", href: "/pets/#{pet_2.id}/delete")
    expect(page).not_to have_content("Pepper")
  end
end

describe "when I visit '/pets'" do
  it "every shelter name is a link to that shelter and every pet has a link to the pet index page" do
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

    visit "/pets"

    expect(page).to have_link("Kali's Shelter", href: "/shelters/#{shelter_1.id}")
    expect(page).to have_link("Kali", href: "/pets/#{pet_1.id}")
    expect(page).to have_link("Pepper", href: "/pets/#{pet_2.id}")
    expect(page).to have_link("Boots", href: "/pets/#{pet_3.id}")

    visit "/shelters/#{shelter_2.id}/pets"
    expect(page).to have_link("Dave's Shelter", href: "/shelters/#{shelter_2.id}")
  end
end

describe "when I visit the Pets Index Page" do
  it "there is a link at the top to the Shelter Index Page" do
    visit '/pets'

    expect(page).to have_link("Shelters", href: '/shelters')
  end
end

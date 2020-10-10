require 'rails_helper'

describe "As a visitor" do
  describe "when I visit a Pet Show page" do
    it "I see a link to update that Pet 'Update Pet', and when I click the link I'm taken to '/pets/:id/edit' where I see a form to edit the pet's data including: image, name, description, age, and sex" do
      shelter_1 = Shelter.create(name: "Kali's Shelter",
                              address: "123 Main St.",
                                 city: "Denver",
                                state: "CO",
                                  zip: "12345")
      pet_1 = shelter_1.pets.create(name: "Kali",
                             description: "cute and sassy",
                                     age: 2,
                                     sex: "female",
                                   image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")

      visit "/pets/#{pet_1.id}"

      click_link 'Update Pet'

      expect(current_path).to eq("/pets/#{pet_1.id}/edit")

      expect(page).to have_field('pet[name]')
      expect(page).to have_field('pet[description]')
      expect(page).to have_field('pet[age]')
      expect(page).to have_field('pet[sex]')
      expect(page).to have_field('pet[image]')
    end
  end
end

describe "When I click the button to submit the form 'Update Pet'" do
  it "a `PATCH` request is sent to '/pets/:id', the pet's data is updated, and I am redirected to the Pet Show page where I see the Pet's updated information" do
    shelter_1 = Shelter.create(name: "Kali's Shelter",
                            address: "123 Main St.",
                               city: "Denver",
                              state: "CO",
                                zip: "12345")
    pet_1 = shelter_1.pets.create(name: "Kali",
                           description: "cute and sassy",
                                   age: 2,
                                   sex: "female",
                                 image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")

    visit "/pets/#{pet_1.id}/edit"

    fill_in('pet[name]', :with => 'Kali')
    fill_in('pet[description]', :with => 'cute and sassy')
    fill_in('pet[age]', :with => '2')
    fill_in('pet[sex]', :with => 'female')
    fill_in('pet[image]', :with => 'https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg')
    find('[type=submit]').click

    expect(current_path).to eq("/pets/#{pet_1.id}")
    expect(page).to have_content("Kali")
    expect(page).to have_content("cute and sassy")
    expect(page).to have_content("2")
    expect(page).to have_content("female")
    expect(page).to have_css("img[src*='https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg']")
  end
end

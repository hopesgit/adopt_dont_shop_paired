require 'rails_helper'

describe "As a visitor" do
  describe "When I visit a pet show page" do
    it "I see a link to delete the pet 'Delete Pet', and when I click the link then a 'DELETE' request is sent to '/pets/:id', the pet is deleted, and I am redirected to the pet index page where I no longer see this pet" do
      shelter_1 = Shelter.create(name: "Kali's Shelter",
                              address: "123 Main St.",
                                 city: "Denver",
                                state: "CO",
                                  zip: "12345")
      pet_1 = shelter_1.pets.create(name: "Kali",
                                     age: 2,
                                     sex: "female",
                                   image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")

      visit "/pets/#{pet_1.id}"

      expect(page).to have_link("Delete Pet", href: "/pets/#{pet_1.id}/delete")

      click_link("Delete Pet", href: "/pets/#{pet_1.id}/delete")

      expect(current_path).to eq("/pets/")
      expect(page).not_to have_content("#{pet_1.name}")
      expect(page).not_to have_content("#{pet_1.age}")
      expect(page).not_to have_content("#{pet_1.image}")
    end
  end
end

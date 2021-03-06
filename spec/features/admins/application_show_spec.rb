require "rails_helper"

describe "As a visitor" do
  before(:each) do
    @user = User.create!({
                       name: "Truck Johnson",
             street_address: "333 Balloon Way",
                       city: "Heck",
                      state: "AR",
                        zip: 65423
                          })
    @shelter_1 = Shelter.create(name: "Kali's Shelter",
                            address: "123 Main St.",
                               city: "Denver",
                              state: "CO",
                                zip: "12345")
    @pet_1 = @shelter_1.pets.create!(name: "Kali",
                                   age: 2,
                                   sex: "female",
                           description: "Cute and sassy cat",
                                status: "Adoptable",
                                 image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")
    @pet_2 = @shelter_1.pets.create!(name: "Ryan",
                                   age: 3,
                                   sex: "male",
                           description: "love bites are the only bites",
                                status: "Adoptable",
                                 image: "https://images.unsplash.com/photo-1543852786-1cf6624b9987?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80")
    @application = Application.create!(user_id: @user.id,
                        description: "I'll be a great pet owner!",
                        status: "In Progress")
    ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application.id, application_pet_status: "Pending")
    ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application.id, application_pet_status: "Pending")
  end

  describe "when I visit the admin version of an application show page" do
  it "has a button for each pet to be approved" do
      visit("/admin/applications/#{@application.id}")

      within("#app-pet-#{@pet_1.id}") do
        has_button?("Approve Pet")
      end
      within("#app-pet-#{@pet_2.id}") do
        has_button?("Approve Pet")
      end
    end
  end

  describe "When I click the Approve Pet button" do
    it "I'm taken back to the admin application show page and next to the pet that I approved, I do not see a button to approve this pet and instead I see an indicator next to the pet that they have been approved" do
      visit("/admin/applications/#{@application.id}")

      within("#app-pet-#{@pet_1.id}") do
        expect(page).to have_content("Pet Application Status: Pending")
        click_on("Approve Pet")
      end

      expect(current_path).to eq("/admin/applications/#{@application.id}")
      expect(page).to have_content("Approved")
    end
  end

  describe "When I click the Reject Pet button" do
    it "I'm taken back to the admin application show page and next to the pet that I rejected, I do not see a button to approve or reject this pet and instead I see an indicator next to the pet that they have been approved" do
      visit("/admin/applications/#{@application.id}")

      within("#app-pet-#{@pet_1.id}") do
        expect(page).to have_content("Pet Application Status: Pending")
        click_on("Reject Pet")
      end

      expect(current_path).to eq("/admin/applications/#{@application.id}")
      expect(page).to have_content("Rejected")
    end
  end

  describe "when I make my determinations, the application status is either accepted or rejected" do
    it "can change app status based on pet statuses" do
      visit("admin/applications/#{@application.id}")

      within("#app-pet-#{@pet_1.id}") do
        click_on("Approve Pet")
      end

      within("#app-pet-#{@pet_2.id}") do
        click_on("Approve Pet")
      end

      expect(current_path).to eq("/admin/applications/#{@application.id}")
      within("#app-status") do
        expect(page).to have_content("Status: Approved")
      end
    end
  end
end

describe "When I visit the admin application show page for pending application" do
  it "next to the pet I do not see a button to approve or reject them and instead I see a message that this pet has been approved for adoption" do
    @user_1 = User.create!({
                       name: "Truck Johnson",
             street_address: "333 Balloon Way",
                       city: "Heck",
                      state: "AR",
                        zip: 65423
                          })
    @user_2 = User.create!({
                        name: "Brittany",
              street_address: "123 Main St",
                        city: "Boulder",
                       state: "CO",
                         zip: 80385
                          })
    @shelter_1 = Shelter.create(name: "Kali's Shelter",
                             address: "123 Main St.",
                                city: "Denver",
                               state: "CO",
                                 zip: "12345")
    @pet_1 = @shelter_1.pets.create!(name: "Kali",
                                   age: 2,
                                   sex: "female",
                           description: "Cute and sassy cat",
                                status: "Adoptable",
                                 image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")
    @application_1 = Application.create!(user_id: @user_1.id,
                                     description: "I'll be a great pet owner!",
                                          status: "In Progress")
    @application_2 = Application.create!(user_id: @user_2.id,
                                     description: "I'm the best'",
                                          status: "In Progress")
    ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application_2.id)

    visit("/admin/applications/#{@application_1.id}")
    click_on("Approve Pet")

    visit("/admin/applications/#{@application_2.id}")

    expect(page).to_not have_button("Approve Pet")
    expect(page).to have_content("This pet has already been approved for adoption.")
  end
end

describe "When I visit the admin application show page for pending application" do
  it "next to the pet I do not see a button to approve or reject them and instead I see a message that this pet has been approved for adoption" do
    @user_1 = User.create!({
                       name: "Truck Johnson",
             street_address: "333 Balloon Way",
                       city: "Heck",
                      state: "AR",
                        zip: 65423
                          })
    @user_2 = User.create!({
                        name: "Brittany",
              street_address: "123 Main St",
                        city: "Boulder",
                       state: "CO",
                         zip: 80385
                          })
    @shelter_1 = Shelter.create(name: "Kali's Shelter",
                             address: "123 Main St.",
                                city: "Denver",
                               state: "CO",
                                 zip: "12345")
    @pet_1 = @shelter_1.pets.create!(name: "Kali",
                                   age: 2,
                                   sex: "female",
                           description: "Cute and sassy cat",
                                status: "Adopted",
                                 image: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg")
    @application_1 = Application.create!(user_id: @user_1.id,
                                     description: "I'll be a great pet owner!",
                                          status: "Approved")
    @application_2 = Application.create!(user_id: @user_2.id,
                                     description: "I'm the best'",
                                          status: "In Progress")
    ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application_1.id, application_pet_status: "Approved")
    ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application_2.id)

    visit("/admin/applications/#{@application_2.id}")

    expect(page).to_not have_button("Approve Pet")
    expect(page).to have_content("This pet has already been approved for adoption.")
  end
end

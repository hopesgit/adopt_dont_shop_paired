require 'rails_helper'

describe "As a visitor" do
  describe "when I visit my application" do
    it "does not have a desc field or submit button" do
      user = User.create!({
                         name: "Truck Johnson",
               street_address: "333 Balloon Way",
                         city: "Heck",
                        state: "AR",
                          zip: 65423
                            })
      application = Application.create!(user_id: @user.id,
                                        description: "I'll be a great pet owner!",
                                        status: "In Progress")

      visit("/applications/new")
      fill_in("User Name", with: "#{user.name}")
      click_on("Submit")
      expect(page).to_not have_content("Please take a moment")
    end
  end
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
    ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application.id)
    ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application.id)
  end

    describe "When I visit an applications show page '/applications/:id'" do
      it "it has user name, address, decscription, names of pets, and status" do

        visit "/applications/#{@application.id}"

        expect(page).to have_content("Application Number: #{@application.id}")
        expect(page).to have_content("#{@user.name}")
        expect(page).to have_content("#{@user.street_address}")
        expect(page).to have_content("#{@user.city}")
        expect(page).to have_content("#{@user.state}")
        expect(page).to have_content("#{@user.zip}")
        expect(page).to have_content("#{@application.description}")
        expect(page).to have_link("#{@pet_1.name}")
        expect(page).to have_link("#{@pet_2.name}")
        expect(page).to have_content("#{@application.status}")
      end

      it "And that application has not been submitted, I see a section on the page to 'Add a Pet to this Application' where I can search for pets by name by adding a name, clicking on search, and it redirects me to the applications show page where I see all pets that match my search criteria" do

        visit "/applications/#{@application.id}"

        fill_in("Pet Name", with: "Kali")
        click_on("Search")

        expect(current_path).to eq("/applications/#{@application.id}")
        expect(page).to have_content("Kali")
      end

      it "next to each Pet's name after I search for a name I see a button to 'Adopt this Pet', I click it, and I'm taken back to to the application show page and I see the Pet I want to adopt listed on this application" do
        @pet_3 = @shelter_1.pets.create!(name: "Nico",
                                       age: 3,
                                       sex: "female",
                               description: "fun furball",
                                    status: "Adoptable"
                                        )
        visit "/applications/#{@application.id}"

        fill_in("Pet Name", with: "Nico")
        click_on("Search")

        expect(page).to have_content("Nico")

        click_on("Adopt this Pet")

        expect(current_path).to eq("/applications/#{@application.id}")
        expect(page).to have_content("Nico")
      end

      it "has a field to add description and submit application" do
        visit "/applications/#{@application.id}"

        fill_in("Description", with: "They'll love me, don't worry")
        click_on("Submit")

        expect(current_path).to eq("/applications/#{@application.id}")
        expect(page).to have_content("Description: They'll love me, don't worry")
        expect(page).to have_content("Status: Pending")
        expect(page).to have_content("#{@pet_1.name}")
        expect(page).to have_content("#{@pet_2.name}")
        expect(page).to_not have_content("Add a Pet to this Application")
      end

      it "I see a flash message that I need to fill out that field before I can submit the application if I do not put a reason, and it's still 'In Progress'" do
        visit "/applications/#{@application.id}"

        fill_in("Description", with: "")
        click_on("Submit")

        expect(current_path).to eq("/applications/#{@application.id}")
        expect(page).to have_content("Status: In Progress")
      end

      it "can find partial matches for names" do
        @pet_3 = @shelter_1.pets.create!(name: "Nico",
                                       age: 3,
                                       sex: "female",
                               description: "fun furball",
                                    status: "Adoptable"
                                        )

        visit "/applications/#{@application.id}"

        save_and_open_page
        fill_in("Pet Name", with: "Nic")
        click_on("Search")
        expect(current_path).to eq("/applications/#{@application.id}")
        expect(page).to have_content("Nico")
      end
    end
  end

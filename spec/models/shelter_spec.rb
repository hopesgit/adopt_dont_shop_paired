require 'rails_helper'

describe Shelter, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "relationships" do
    it {should have_many :pets}
  end

  describe "model methods" do
    it "#total_pets" do
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
      expect(shelter_1.total_pets).to eq(2)
    end

    it "#review_rating_average" do
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
      expect(shelter.average_rating).to eq(4)
    end
  end
end

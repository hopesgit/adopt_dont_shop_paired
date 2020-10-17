require 'rails_helper'

RSpec.describe User, type: :model do

  describe "instance method" do
    it '#average_rating' do
      shelter_1 = Shelter.create(name: "Kali's Shelter",
                              address: "123 Main St.",
                                 city: "Denver",
                                state: "CO",
                                  zip: "12345")
      user_1 = User.create!(name: "Sally Peach",
                 street_address: "123 Main St.",
                           city: "Denver",
                          state: "CO",
                            zip: "80205")
      review_1 = Review.create!({title: "Sally's Review",
                                rating: 4,
                               content: "Nice place to find a great pet!",
                               picture: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                               user_id: "#{user_1.id}",
                            shelter_id: "#{shelter_1.id}"
                             })
      review_2 = Review.create!({title: "Sally's Thoughts",
                                rating: 5,
                               content: "Love this shelter!",
                               user_id: "#{user_1.id}",
                            shelter_id: "#{shelter_1.id}"
                             })
      review_3 = Review.create!({title: "Pollllly",
                                rating: 3,
                               content: "It's alright, but not my favorite",
                               user_id: "#{user_1.id}",
                            shelter_id: "#{shelter_1.id}"
                             })

      expect(user_1.average_rating).to eq(4)
    end
  end

  describe "instance method" do
    it '#highest_rating' do
      shelter_1 = Shelter.create(name: "Kali's Shelter",
                              address: "123 Main St.",
                                 city: "Denver",
                                state: "CO",
                                  zip: "12345")
      user_1 = User.create!(name: "Sally Peach",
                 street_address: "123 Main St.",
                           city: "Denver",
                          state: "CO",
                            zip: "80205")
      review_1 = Review.create!({title: "Sally's Review",
                                rating: 4,
                               content: "Nice place to find a great pet!",
                               picture: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                               user_id: "#{user_1.id}",
                            shelter_id: "#{shelter_1.id}"
                             })
      review_2 = Review.create!({title: "Sally's Thoughts",
                                rating: 5,
                               content: "Love this shelter!",
                               user_id: "#{user_1.id}",
                            shelter_id: "#{shelter_1.id}"
                             })
      review_3 = Review.create!({title: "Pollllly",
                                rating: 3,
                               content: "It's alright, but not my favorite",
                               user_id: "#{user_1.id}",
                            shelter_id: "#{shelter_1.id}"
                             })

      expect(user_1.highest_rating).to be_truthy
    end
  end

  describe "instance method" do
    it '#lowest_rating' do
      shelter_1 = Shelter.create(name: "Kali's Shelter",
                              address: "123 Main St.",
                                 city: "Denver",
                                state: "CO",
                                  zip: "12345")
      user_1 = User.create!(name: "Sally Peach",
                 street_address: "123 Main St.",
                           city: "Denver",
                          state: "CO",
                            zip: "80205")
      review_1 = Review.create!({title: "Sally's Review",
                                rating: 4,
                               content: "Nice place to find a great pet!",
                               picture: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg",
                               user_id: "#{user_1.id}",
                            shelter_id: "#{shelter_1.id}"
                             })
      review_2 = Review.create!({title: "Sally's Thoughts",
                                rating: 5,
                               content: "Love this shelter!",
                               user_id: "#{user_1.id}",
                            shelter_id: "#{shelter_1.id}"
                             })
      review_3 = Review.create!({title: "Pollllly",
                                rating: 3,
                               content: "It's alright, but not my favorite",
                               user_id: "#{user_1.id}",
                            shelter_id: "#{shelter_1.id}"
                             })

      expect(user_1.lowest_rating).to be_truthy
    end
  end
end

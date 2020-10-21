class Review < ApplicationRecord
  belongs_to :shelter
  belongs_to :user

  validates_presence_of :title, :rating, :content, :user

  def self.user_id(user_name)
    User.select(:name == user_name).limit(1).first.id
  end
end

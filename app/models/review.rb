class Review < ApplicationRecord
  belongs_to :shelter
  belongs_to :user

  validates :title, presence: true
  validates :rating, presence: true
  validates :content, presence: true

  def self.user_id(user_name)
    User.select(:name == user_name).limit(1).first.id
  end
end

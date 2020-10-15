class Review < ApplicationRecord
  belongs_to :shelter

  def self.user_id(user_name)
    User.select(:name == user_name).limit(1).first.id
  end
end

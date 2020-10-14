class Review < ApplicationRecord
  belongs_to :shelter

  # def user_name
  #   User.find(user_id).name
  # end
end

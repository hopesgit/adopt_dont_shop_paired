class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    binding.pry
    pet = Pet.find(params[:pet_id])
  end
end

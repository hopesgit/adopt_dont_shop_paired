class ShelterController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show

  end

  def new
  end

  def create
    binding.pry
    shelter = Shelter.new({
      name: params[:shelter][:name],
      address: params[:shelter][:address],
      city: params[:shelter][:city],
      state: params[:shelter][:state],
      zip: params[:shelter][:zip],
      })
      shelter.save
      redirect_to '/shelters'
  end

end

class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def new
  end

  def create
    pet = Pet.new({
      name: params[:pet][:name],
      description: params[:pet][:description],
      age: params[:pet][:age],
      sex: params[:pet][:sex],
      image: params[:pet][:image]
      })
    pet.save
    redirect_to "/shelters/:id/pets"
  end

  def shelter_index
    @pets = Pet.where("shelter_id = ?", params[:id])
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def edit
    @pet = Pet.find(params[:id])
  end

end

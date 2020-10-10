class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def new
  end

  def create
    pet = Pet.new({
      name: params[:name],
      description: params[:description],
      age: params[:age],
      sex: params[:sex],
      image: params[:image]
      })
    pet.save
    redirect_to "/shelters/:id/pets"
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def edit
    @pet = Pet.find(params[:id])
  end

end

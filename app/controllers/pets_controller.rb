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
      image: params[:image],
      shelter_id: params[:id],
      status: "Adoptable"
      })
    pet.save
    redirect_to "/shelters/#{params[:id]}/pets"
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update({
      name: params[:name],
      description: params[:description],
      age: params[:age],
      sex: params[:sex],
      image: params[:image]
      })
    pet.save
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to '/pets'
  end

end

class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def shelter_index
    @pets = Pet.where("shelter_id = #{params[:id]}")
  end

  def show
    @pet = Pet.find(params[:id])
  end

end

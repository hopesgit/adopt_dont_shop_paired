class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    if !params[:search].nil?
      @pets = Pet.where(name: params[:search])
    end
  end

  def new
  end

  def create
    user = User.find_by(name: params[:user_name])
    if user.nil?
      flash[:failure] = 'User could not be found. Please try again.'
      redirect_to "/applications/new"
    else
      application = Application.create!(status: "In Progress",
                                        user_id: user.id,
                                        description: "")
      redirect_to "/applications/#{application.id}"
    end
  end

  def edit
  end

  def update
    pet = Pet.find(params[:pet_id])
    application = Application.find(params[:id])
    ApplicationPet.create!(pet_id: pet.id, application_id: application.id)
    redirect_to "/applications/#{application.id}"
  end

end

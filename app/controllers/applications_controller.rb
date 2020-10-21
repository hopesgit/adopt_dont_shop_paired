class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    if !params[:search].nil?
      @pets = Pet.where("name LIKE ?", "%#{params[:search].capitalize}%")
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
      application = Application.create!(status: "In Progress", user_id: user.id)
      redirect_to "/applications/#{application.id}"
    end
  end

  def edit
  end

  def update
    application = Application.find(params[:id])
    if params[:description].nil?
      pet = Pet.find(params[:pet_id])
      ApplicationPet.create!(pet_id: pet.id, application_id: application.id, application_pet_status: "Pending")
    elsif params[:description] != ""
      application.update(description: params[:description], status: "Pending")
    end
    redirect_to "/applications/#{application.id}"
  end
end

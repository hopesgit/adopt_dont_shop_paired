class ApplicationPetsController < ApplicationController

  def update
    application = Application.find(params[:id])
    app_pet = ApplicationPet.where("pet_id = #{params[:pet_id]}")
    app_pet.update(application_pet_status: "Approved")
    redirect_to "/admin/applications/#{params[:id]}"
  end

end

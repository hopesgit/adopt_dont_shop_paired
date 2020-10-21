class ApplicationPetsController < ApplicationController

  def update
    application = Application.find(params[:id])
    app_pet = ApplicationPet.where("pet_id = #{params[:pet_id]} AND application_id = #{params[:id]}")
    if params[:judge]  == "Approve"
      app_pet.update(application_pet_status: "Approved")
    else
      app_pet.update(application_pet_status: "Rejected")
    end
    redirect_to "/admin/applications/#{params[:id]}"
  end

end

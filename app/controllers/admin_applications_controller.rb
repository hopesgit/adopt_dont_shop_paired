class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if @application.approved?
      @application.update(status: "Approved")
      @application.adopt_pets
    elsif @application.rejected?
      @application.update(status: "Rejected")
    end
  end

end

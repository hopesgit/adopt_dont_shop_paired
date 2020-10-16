class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
    if !params[:order].nil?
      @shelters.merge!(Shelter.order(:name))
    end
  end

  def new
  end

  def create
    shelter = Shelter.new({
      name: params[:name],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zip: params[:zip]
      })
    shelter.save
    redirect_to '/shelters'
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update({
      name: params[:name],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zip: params[:zip]
      })
    if shelter.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash.now[:notice] = "Please fill in all fields to edit the shelter"
      render :new
    end
  end

  def destroy
    Shelter.destroy(params[:id])
    redirect_to '/shelters'
  end

end

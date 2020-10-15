class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
  end

  def edit
    @review = Review.find(params[:id])
  end

  def create
    review = Review.create!({
      title: params[:title],
      rating: params[:rating],
      content: params[:content],
      picture: params[:picture],
      shelter_id: params[:id],
      user_name: params[:user_name],
      user_id: Review.user_id(params[:user_name])
      })
    redirect_to "/shelters/#{review.shelter_id}"
  end

  def update
    review = Review.find(params[:id])
    review.update({title: params[:title],
    rating: params[:rating],
    content: params[:content],
    picture: params[:picture],
    shelter_id: params[:id],
    user_name: params[:user_name]})
    review.save
    redirect_to "/shelters/#{review.shelter_id}"
  end

end

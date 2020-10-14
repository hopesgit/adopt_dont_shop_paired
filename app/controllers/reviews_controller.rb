class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.update({
      title: params[:title],
      rating: params[:rating],
      content: params[:content],
      picture: params[:picture],
      })
    review.save
    redirect_to "/shelters/#{params[:id]}"
  end
end

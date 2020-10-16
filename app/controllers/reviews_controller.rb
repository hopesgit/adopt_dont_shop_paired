class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    user = User.find_by(name: params[:user_name])
    review = Review.create!({
      title: params[:title],
      rating: params[:rating],
      content: params[:content],
      picture: params[:picture],
      shelter_id: shelter.id,
      user_name: user.name,
      user_id: user.id
      })
    redirect_to "/shelters/#{shelter.id}"
  end

  def update
    review = Review.find(params[:review_id])
    if review.update!({title: params[:title],
    rating: params[:rating],
    content: params[:content],
    picture: params[:picture],
    shelter_id: params[:shelter_id],
    user_name: params[:user_name]})
      redirect_to "/shelters/#{params[:shelter_id]}"
    else
      flash[:notice] = "Please fill in all required fields to edit the review."
      redirect_to "/shelters/#{params[:shelter_id]}/reviews/#{params[:review_id]}/edit"
    end
  end

end

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
    # binding.pry
    if user.nil?
      flash[:warning] = "Error: Not all required fields filled out"
      render :new
    else
      Review.create!({
        title: params[:title],
        rating: params[:rating],
        content: params[:content],
        picture: params[:picture],
        shelter_id: shelter.id,
        user_name: user.name,
        user_id: user.id
        })
      flash[:success] = "Ya did it!"
      redirect_to "/shelters/#{shelter.id}"
    end
  end

  def update
    review = Review.find(params[:review_id])
    review.update!({title: params[:title],
    rating: params[:rating],
    content: params[:content],
    picture: params[:picture],
    shelter_id: params[:shelter_id],
    user_name: params[:user_name]})
    review.save
    redirect_to "/shelters/#{params[:shelter_id]}"
  end

  def destroy
    @review = Review.find(params[:review_id])
    @review.destroy!
    redirect_to("/shelters/#{params[:shelter_id]}")
  end

end

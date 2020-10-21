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
    if user.nil? || params[:title] == "" || params[:content] == ""
      flash[:warning] = "Error: Form not filled out correctly."
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
      flash[:success] = "Review successfully created."
      redirect_to "/shelters/#{shelter.id}"
    end
  end

  def update
    review = Review.find(params[:review_id])
    review.update({title: params[:title],
    rating: params[:rating],
    content: params[:content],
    picture: params[:picture],
    shelter_id: params[:shelter_id],
    user_name: params[:user_name]})
    if review.save && User.exists?(name: params[:user_name])
      redirect_to "/shelters/#{params[:shelter_id]}"
    else
      flash[:notice] = "Please fill out all required fields and make sure user is valid."
      redirect_to "/shelters/#{params[:shelter_id]}/reviews/#{params[:review_id]}/edit"
    end
  end

  def destroy
    @review = Review.find(params[:review_id])
    @review.destroy!
    redirect_to("/shelters/#{params[:shelter_id]}")
  end

end

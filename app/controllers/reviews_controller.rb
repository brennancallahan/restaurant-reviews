class ReviewsController < ApplicationController

  def index
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new(review_params)
    @review.restaurant = @restaurant
    @reviews = @restaurant.reviews

    if @review.save
      flash[:notice] = 'Review added successfully'
      redirect_to @restaurant
    else
      flash.now[:error] = @review.errors.full_messages.join(', ')
      render :new
    end
  end

  private

    def review_params
      params.require(:review).permit(:rating, :body)
    end

end

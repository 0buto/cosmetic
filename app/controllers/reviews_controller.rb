class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      redirect_to reviews_path, notice: "Відгук успішно додано!"
    else
      render :new, alert: "Не вдалося додати відгук. Спробуйте ще раз."
    end
  end

  private

  def review_params
    params.require(:review).permit(:name, :content)
  end
end

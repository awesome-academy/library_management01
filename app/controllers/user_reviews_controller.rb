class UserReviewsController < ApplicationController
  before_action :load_book
  before_action :load_review, only: :edit

  def new
    @user_review = current_user.user_reviews.new
  end

  def create
    @user_review = current_user.user_reviews.build review_params
    @user_review.book_id = @book.id
    if @user_review.save
      flash[:info] = t ".created"
      redirect_to @book
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def edit; end

  def update
    if @user_review.update review_params
      flash[:info] = t ".edited"
      redirect_to @book
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    if @user_review.destroy
      flash[:info] = t ".deleted"
    else
      flash[:danger] = t ".delete_fail"
    end
    redirect_to @book
  end

  private

  def review_params
    params.require(:user_review).permit :rate, :user_id, :book_id, :content
  end

  def load_book
    @book = Book.find_by id: params[:book_id]
    return if @book
    flash[:danger] = t "books.load_book.error_message"
    redirect_to root_path
  end

  def load_review
    @user_review = UserReview.find_by id: params[:id]
    return if @user_review
    flash[:danger] = t ".no_found_review"
    redirect_to @book
  end
end

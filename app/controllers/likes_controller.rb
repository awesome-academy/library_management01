class LikesController < ApplicationController
  before_action :load_like, only: :destroy

  def index
    @likes = @book.likes._page params[:page]
  end

  def create
    @like = current_user.likes.build book_id: params[:book_id]
    if @like.save
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_to request.referrer || root_path
  end

  def destroy
    if @like.destroy
      flash[:success] = t ".deleted"
    else
      flash[:danger] = t ".failed"
    end
    redirect_to request.referrer || root_path
  end

  private

  def load_like
    @like = current_user.likes.find_by book_id: params[:book_id]
    return if @like
    flash[:danger] = t ".cant_find"
    redirect_to root_path
  end
end

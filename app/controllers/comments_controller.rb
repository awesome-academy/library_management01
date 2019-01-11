class CommentsController < ApplicationController
  before_action :load_book, only: :create
  before_action :load_user

  def index
    @comment = Comment.order_by_created_at._page params[:page]
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new comment_params
    @comment.user_id = current_user.id
    @comment.book_id = params[:book_id]
    if @comment.save
      flash[:success] = t ".create_success"
      redirect_to book_path @book
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit :user_id, :book_id, :content
  end

  def load_book
    @book = Book.find_by id: params[:book_id]
    return if @book
    flash[:danger] = t "books.load_book.error_message"
    redirect_to root_path
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".error"
    redirect_to root_path
  end
end

class CategoriesController < ApplicationController
  before_action :load_category, only: :show

  def index
    @categories = Category.newest.search_category(params[:search])
      ._page params[:page]
    respond_to do |format|
      format.html
      format.xls{send_data @categories.to_xsl}
    end
  end

  def show; end

  private

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t ".error"
    redirect_to categories_path
  end
end

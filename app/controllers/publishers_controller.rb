class PublishersController < ApplicationController
  load_and_authorize_resource
  before_action :load_publisher, except: %i(new create index)
  before_action :is_admin?, only: %i(edit destroy)

  def index
    @q = Publisher.ransack params[:q]
    @publishers = @q.result.alphabet._page params[:page]
    respond_to do |format|
      format.html
      format.xls{send_data @publishers.to_xsl}
    end
  end

  def new
    @publisher = Publisher.new
  end

  def edit; end

  def update
    if @publisher.update_attributes publisher_params
      flash[:success] = t ".updated"
      redirect_to @publisher
    else
      render :edit
    end
  end

  def show; end

  def create
    @publisher = Publisher.new publisher_params
    if @publisher.save
      flash[:success] = t ".create_success"
      redirect_to @publisher
    else
      render :new
    end
  end

  def destroy
    if @publisher.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_to publishers_path
  end

  private

  def load_publisher
    @publisher = Publisher.find_by id: params[:id]
    return if @publisher
    flash[:danger] = t ".error"
    redirect_to root_path
  end

  def publisher_params
    params.require(:publisher).permit :name, :address
  end
end

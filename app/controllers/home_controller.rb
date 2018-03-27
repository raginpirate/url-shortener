class HomeController < ApplicationController
  rescue_from ArgumentError, with: :error

  def index
    @link = Link.new
    @top_links = Link.order(clicks: :desc).first(12)
  end

  def all
    @link = Link.new
    @links = Link.paginate(:page => params[:page], :per_page => 5)
  end

  def error
    logger.error "Attempt to use invalid route"
    redirect_to root_path, notice: 'Invalid URL: This Route Does Not Exist.'
  end
end
class HomeController < ApplicationController
  # if paginate page values are incorrect, we get this error
  rescue_from ArgumentError, with: :error

  # root
  def index
    @link = Link.new
    @top_links = Link.order(clicks: :desc).first(12)
  end

  # all table display
  def all
    @link = Link.new
    @links = Link.paginate(:page => params[:page], :per_page => 5).order('slug DESC')
  end

  # error redirect from invalid root
  def error
    logger.error "Attempt to use invalid route"
    redirect_to root_path, notice: 'Invalid URL: This Route Does Not Exist.'
  end
end
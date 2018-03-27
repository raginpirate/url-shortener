class LinksController < ApplicationController
  before_action :set_link, only: [:show]
  #called after we set our session so our model can set our slug
  after_action :set_session, only: [:create]
  rescue_from NoMethodError, with: :invalid_link
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_link
  
  def index
    @links = Link.all
  end

  def show
    if params[:slug]
      @link = Link.find_by(slug: params[:slug])
      if redirect_to @link.given_url
        @link.clicks += 1
        @link.save
      end
    else
      @link = Link.new
      @linkPrev = Link.find_by(slug: params[:id])
    end
  end

  def update
    create
  end

  def create
    @link = Link.new(link_params)

    respond_to do |format|
      if @link.save
        logger.debug "Got here"
        format.html { redirect_to root_path, notice: 'Link was successfully created.' }
        format.js
        format.json { render action: 'show', status: :created, location: @link }
      else
        format.html { render action: 'new' }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_link
      @link = Link.find_by(slug: params[:slug])
    end

    def link_params
      params.require(:link).permit(:given_url)
    end

    def invalid_link
      logger.error "Attempt to access invalid link"
      redirect_to root_path, notice: 'Invalid URL: This Link No Longer Exists or Never Did.'
    end

    def set_session
      session[:link_slug] = @link.display_slug
      session[:slug] = @link.slug
    end

end
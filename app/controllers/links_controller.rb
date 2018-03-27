class LinksController < ApplicationController
  
  # called after we set our session so our model can set our slug
  after_action :set_session, only: [:create]

  # occurs if find_by returns null and the error propogates from model
  rescue_from NoMethodError, with: :invalid_link

  # occurs if invalid slug
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_link

  def show
    if params[:slug]
      @link = set_link(params[:slug])
      if redirect_to @link.given_url
        @link.clicks += 1
        @link.save
      end
    else
      @link = Link.new
      @linkPrev = set_link(params[:id])
    end
  end

  # adding a url while looking at link desc.
  # is not update, but instead create
  # should we want to implement update,
  # we can do params[] checks in this method
  def update
    create
  end

  def create
    @link = Link.new(link_params)

    respond_to do |format|
      if @link.save
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
    
    def set_link(slug_val)
      Link.find_by(slug: slug_val)
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
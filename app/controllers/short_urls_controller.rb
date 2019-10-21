class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
  end

  def create
  end

  def show
  end

  def load_url
    @url.clicks.create
    redirect_to @url.url
  end

  def top_one_hundred
    top_one_hundred = Click.select(:short_url_id).group(:short_url_id).order("count(short_url_id) desc").first(100)
    render json: {
      urls: top_one_hundred,
    }, status: :ok and return
  end

  private
  def set_url
    @url = ShortUrl.find(params[:short_url])
  end

end

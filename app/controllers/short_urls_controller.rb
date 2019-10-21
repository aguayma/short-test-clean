class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
  end

  def create
  end

  def show
  end

  def top_one_hundred
    top_one_hundred = Clicks.select(:short_url_id).group(:short_url_id).order("count(short_url_id) desc").first(100)
    render json: {
      urls: top_hundred,
    }, status: :ok and return
  end

end

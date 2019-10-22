class ShortUrlsController < ApplicationController
  require 'uri'

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token
  before_action :set_url, only: [:load_url]

  def index
  end

  def create
  end

  def show
  end

  def load_url
    @url.clicks.create
    redirect_to @url.add_http_if_needed
  end

  def top_one_hundred
    urls_with_click_counts = []
    top_one_hundred = ShortUrl.left_joins(:clicks).group(:id).order('COUNT(clicks.id) DESC').limit(100)
    top_one_hundred.each do |url|
      urls_with_click_counts.push({url: url, click: url.clicks.count})
    end
    render json: {
      urls: urls_with_click_counts,
    }, status: :ok and return
  end

  private
  def set_url
    @url = ShortUrl.find_by(code: params[:code])
  end

end

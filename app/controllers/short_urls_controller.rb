class ShortUrlsController < ApplicationController
  require 'uri'

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token
  before_action :set_url, only: [:show]

  def index
    urls_with_click_counts = []
    top_one_hundred = ShortUrl.left_joins(:clicks).group(:id).order('COUNT(clicks.id) DESC').limit(100)
    top_one_hundred.each do |url|
      urls_with_click_counts.push({title: url.title, click_count: url.clicks.count, full_url: url.full_url, short_code: url.short_code})
    end
    render json: {
      urls: urls_with_click_counts,
    }, status: :ok and return
  end

  def create
    @short_url = ShortUrl.new(short_url_params)
    if @short_url.save
      Resque.enqueue(CapturePageTitle, @short_url.id)
      render json: {
        short_code: @short_url.short_code
      }, status: :ok and return
    else
      render json: { errors: "Full url #{@short_url.errors['full_url'][0]}" }, status: :bad_request and return
    end
  end

  def show
    if @url
      @url.clicks.create
      redirect_to @url.add_http_if_needed
    else
      render json: { errors: '' }, status: :not_found and return
    end
  end

  private
  def set_url
    @url = ShortUrl.find_by(short_code: params[:id])
  end

  def short_url_params
    params.permit(:full_url)
  end

end

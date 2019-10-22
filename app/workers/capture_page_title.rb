require 'open-uri'
require 'nokogiri'

class CapturePageTitle
  @queue = :page_title
  def self.perform(short_url_id)
    short_url = ShortUrl.find(short_url_id)
    title = Nokogiri::HTML.parse(open(short_url.url)).title
    short_url.update(title: title)
  end
end

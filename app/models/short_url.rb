class ShortUrl < ApplicationRecord
  URL_VALIDATION = /^(((http|https):\/\/|)?[a-z0-9]+\D+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?)$/
  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validate :validate_full_url, :on => :create
  has_many :clicks

  def short_code
  end

  def update_title!
  end

  def add_http_if_needed
    if !url.match(/^((http|https):\/\/)/)
      "http://" + url
    end
  end

  private

  def validate_full_url
    if !!url.match(URL_VALIDATION)
    else
      errors.add(:url, 'is not a valid url.')
    end
  end

end

class ShortUrl < ApplicationRecord
  URL_VALIDATION = /^(((http|https):\/\/|)?[a-z0-9]+\D+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?)$/
  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validate :validate_full_url, :on => :create
  has_many :clicks
  after_create :create_short_code

  def create_short_code(id = self.id, base = 62)
    return CHARACTERS[0] if id == 0
    result = ""
      while id > 0
        r = id % base
        result.prepend(CHARACTERS[r])
        id = (id / base).floor
      end
    self.short_code = result
    self.save
  end

  def update_title!
    title = Nokogiri::HTML.parse(open(full_url)).title
    self.update(title: title)
  end

  def add_http_if_needed
    if !full_url.match(/^((http|https):\/\/)/)
      "http://" + full_url
    else
      full_url
    end
  end

  private

  def validate_full_url
    if full_url.nil?
      errors.add(:full_url, "can't be blank")
    elsif !!!full_url.match(URL_VALIDATION)
      errors.add(:full_url, "is not a valid url")
    end
  end

end

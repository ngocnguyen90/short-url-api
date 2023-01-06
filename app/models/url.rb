require 'uri'

class Url < ApplicationRecord
  validates :long_url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https]), on: :encode
  validates :short_url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https]), on: :decode
  before_create :generate_short_url

  def generate_short_url
    url = RANDOM_STRING_FOR_URL_SHORTENER.sample(UNIQUE_ID_LENGTH).join
    old_url = Url.where(short_url: url).last
    if old_url.present?
      generate_short_url
    else
      self.short_url = url
    end
  end

  def find_duplicate
    Url.find_by_long_url long_url
  end

  def find_by_short_url
    Url.find_by_short_url short_url
  end

  def new_url?
    find_duplicate.nil?
  end

  def can_decode?
    self.short_url = short_url_sanitize
    !find_by_short_url.nil?
  end

  def short_url_sanitize
    URI(short_url.to_s).path.split('/').last
  end

  def encode!
    save(context: :encode)
  end
end

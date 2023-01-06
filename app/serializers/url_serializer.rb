class UrlSerializer < ActiveModel::Serializer
  attribute :short_url, if: :include_short_url?
  attribute :long_url, if: :include_long_url?

  def short_url
    object.short_url = "#{HOST_URL_SHORTENER}#{object.short_url}"
  end

  def include_short_url?
    true if instance_options[:type] == 'encode'
  end

  def include_long_url?
    true if instance_options[:type] == 'decode'
  end
end

AttributeNormalizer.configure do |config|

  config.default_normalizers = :squish, :blank

  config.normalizers[:downcase] = lambda do |value, options|
    value.is_a?(String) ? value.mb_chars.downcase.to_s : value
  end
end

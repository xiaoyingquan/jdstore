require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Jdstore
  class Application < Rails::Application

    config.i18n.default_locale = "zh-CN"
    config.time_zone = "Beijing"
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end

Time::DATE_FORMATS.merge!(:default => '%Y/%m/%d %I:%M %p', :ymd => '%Y/%m/%d')

datetime = Time.now

datetime.to_s(:db)            # => "2007-12-04 00:00:00"
datetime.to_s(:number)        # => "20071204000000"
datetime.to_s(:short)         # => "04 Dec 00:00"
datetime.to_s(:long)          # => "December 04, 2007 00:00"
datetime.to_s(:long_ordinal)  # => "December 4th, 2007 00:00"
datetime.to_s(:rfc822)        # => "Tue, 04 Dec 2007 00:00:00 +0000"
datetime.to_s(:iso8601)       # => "2007-12-04T00:00:00+00:00"

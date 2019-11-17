require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FreemarketSample54a
  class Application < Rails::Application
    config.i18n.default_locale = :ja
    
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]
    # タイムゾーンを日本時間に設定
    config.time_zone = 'Asia/Tokyo'
    
    # コントローラ作成時に不要ファイルを作成しないよう制御
    config.generators do |g|
      g.javascripts false
      g.helper false
      g.test_framework false
    end
  end
end

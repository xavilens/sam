require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Sam
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.paths['app/views'] << 'app/views/users'
    config.paths['app/views'] << 'app/views/layouts'
    config.paths['app/views'] << 'app/views/events'
    config.paths['app/views'] << 'app/views/messages'
    config.paths['app/views'] << 'app/views/modules'
    config.paths['app/views'] << 'app/views/images'
    config.paths['app/views'] << 'app/views/forms'

    config.autoload_paths += %W(#{config.root}/app)
    config.autoload_paths += %W(#{config.root}/app/models/conversations)
    config.autoload_paths += %W(#{config.root}/app/models/messages)
    config.autoload_paths += %W(#{config.root}/app/models/events)
    config.autoload_paths += %W(#{config.root}/app/models/uploads)
    config.autoload_paths += %W(#{config.root}/app/models/ads)
    config.autoload_paths += %W(#{config.root}/app/models/rehearsal_studios)


    config.eager_load_paths += %W(#{config.root}/app)

    # ref: https://github.com/plataformatec/devise/wiki/How-To:-Redirect-to-a-specific-page-when-the-user-can-not-be-authenticated
    config.autoload_paths << Rails.root.join('lib')

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Madrid'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end

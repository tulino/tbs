Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Bullet N+1 Errors
  config.after_initialize do
    # enable Bullet gem, otherwise do nothing
    Bullet.enable = true
    # pop up a JavaScript alert in the browser
    Bullet.alert = true
    # log to the Bullet log file (Rails.root/log/bullet.log)
    Bullet.bullet_logger = true
    # log warnings to your browser's console.log (Safari/Webkit browsers or Firefox w/Firebug installed)
    Bullet.console = false
    # pop up Growl warnings if your system has Growl installed. Requires a little bit of configuration
    # Bullet.growl = true
    # send XMPP/Jabber notifications to the receiver indicated.
    # Bullet.xmpp = { :account  => 'bullets_account@jabber.org', :password => 'bullets_password_for_jabber', :receiver => 'your_account@jabber.org', :show_online_status => true }
    Bullet.rails_logger = true
    # add notifications to bugsnag
    Bullet.bugsnag = false
    # add notifications to airbrake
    Bullet.airbrake = false
    # adds the details in the bottom left corner of the page
    Bullet.add_footer = true
    # include paths with any of these substrings in the stack trace, even if they are not in your main app
    # Bullet.stacktrace_includes = [ 'your_gem', 'your_middleware' ]
    # Detect eager-loaded associations which are not used
    Bullet.unused_eager_loading_enable = false
    # Detect unnecessary COUNT queries which could be avoided with a counter_cache
    Bullet.counter_cache_enable = false
  end
end

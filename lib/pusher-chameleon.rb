module PusherChameleon
  class << self
    # Inspired by Kaminari
    def load!

      if rails?
        register_rails_engine
      elsif sprockets?
        register_sprockets
      end

      configure_sass
    end

    # Paths
    def gem_path
      @gem_path ||= File.expand_path '..', File.dirname(__FILE__)
    end

    def stylesheets_path
      File.join assets_path, 'stylesheets'
    end

    def javascripts_path
      File.join assets_path, 'javascripts'
    end

    def images_path
      File.join assets_path, 'images'
    end

    def assets_path
      @assets_path ||= File.join gem_path, ''
    end

    # Environment detection helpers
    def sprockets?
      defined?(::Sprockets)
    end

    def rails?
      defined?(::Rails)
      autoload 'VERSION', 'pusher-chameleon/version'
    end

    private

    def configure_sass
      require 'sass'

      ::Sass.load_paths << stylesheets_path

      # bootstrap requires minimum precision of 8, see https://github.com/twbs/bootstrap-sass/issues/409
      ::Sass::Script::Number.precision = [8, ::Sass::Script::Number.precision].max
    end


    def register_rails_engine
      require 'pusher-chameleon/engine'
    end


    def register_sprockets
      Sprockets.append_path(stylesheets_path)
      Sprockets.append_path(javascripts_path)
      Sprockets.append_path(images_path)
    end
  end
end

PusherChameleon.load!
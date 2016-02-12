# Require core library
require 'middleman-core'

module Landingman
  class DotenvExtension < ::Middleman::Extension
    option :env_file, '.env', 'Environment File Name'
    option :env_separator, '.', 'Separate Environment name from Environment File Name'

    def initialize(app, options_hash={}, &block)
      super

      # Require libraries only when activated
      require 'dotenv' unless defined?(::Dotenv)

      # Properly Scope the paths
      specific_env_path = "#{options.env_file}#{options.env_separator}#{app.environment}"
      global_env_path = options.env_file
      parent_specific_env_path = File.expand_path(File.join(app.root, '..', specific_env_path))
      parent_global_env_path = File.expand_path(File.join(app.root, '..', global_env_path))

      # Dot Env
      ::Dotenv.load(
        File.join(Dir.pwd, specific_env_path),
        File.join(Dir.pwd, global_env_path),
        parent_specific_env_path,
        parent_global_env_path
      )
      app.before do
        ::Dotenv.load(
          File.join(app.root, specific_env_path),
          File.join(app.root, global_env_path),
          parent_specific_env_path,
          parent_global_env_path
        )
      end
    end
  end
end
require "middleman-core"

Middleman::Extensions.register :landingman_dotenv, auto_activate: :before_configuration do
  require "landingman-dotenv/extension"
  ::Landingman::DotenvExtension
end

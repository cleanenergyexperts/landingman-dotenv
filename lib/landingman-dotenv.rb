require "middleman-core"

Middleman::Extensions.register :landingman_dotenv do
  require "landingman-dotenv/extension"
  ::Landingman::DotenvExtension
end

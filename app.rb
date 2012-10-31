require './sprockets_application'

class Application < SprocketsApplication
  get '/' do
    "hello world"
  end
end
require './app'

map '/assets' do
  run Application.settings.sprockets
end

run Application
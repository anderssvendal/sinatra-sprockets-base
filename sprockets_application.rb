require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry' if development?
require 'sprockets'
require 'sprockets-sass'
require 'haml'
require 'sass'

class SprocketsApplication < Sinatra::Application
  set :root, File.dirname(__FILE__)
  set :sprockets, (Sprockets::Environment.new(root) { |env| env.logger = Logger.new(STDOUT) })
  set :assets_path, File.join(root, 'assets')

  configure do
    Dir.glob(File.join(root, 'assets', '**/**/')).each do |folder|
      sprockets.append_path(folder)
    end
  end
end
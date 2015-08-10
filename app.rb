require 'bundler/setup'
require 'sinatra/base'
require './riemann_middleware'

class MyApp < Sinatra::Base
  use RiemannMiddleware

  configure do
    set :bind, '0.0.0.0'
  end
  get '/' do
    "hello world\n"
  end
  # start the server if ruby file executed directly
  run! if app_file == $0
end

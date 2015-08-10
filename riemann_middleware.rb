require 'riemann/client'
class RiemannMiddleware

  def initialize(app)
    @app = app
  end


  def call(env)
    @app.call(env).tap do |res|
      c = Riemann::Client.new host: 'riemann', port: 5555, timeout: 5
      c << {
        host: 'localhost',
        metric: 63.5,
        description: "63.5 milliseconds per request",
        time: Time.now.to_i
      }

    end
  end
end

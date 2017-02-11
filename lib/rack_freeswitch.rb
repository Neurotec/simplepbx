module Rack
  class Freeswitch
    RACK_INPUT = 'rack.input'.freeze
    def initialize(app, options = {})
      @app = app
    end

    #fix bug variable_%(2000
    def call(env)
      if env['CONTENT_TYPE'] == "application/x-www-form-urlencoded"
        body = env[RACK_INPUT].read.gsub(/%\(/,"(")
        env[RACK_INPUT] = StringIO.new(body)
        @app.call(env)
      else
        @app.call(env)
      end
    end
  end
end

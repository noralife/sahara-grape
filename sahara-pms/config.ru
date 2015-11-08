require 'uri'
require 'net/http'
require './models.rb'
require './db.rb'
require './helpers.rb'
require './api.rb'
require 'pry'
require 'rack/cors'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :get
  end
end

run SaharaPms::API

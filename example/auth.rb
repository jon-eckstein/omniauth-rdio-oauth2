require 'sinatra'
require 'omniauth'
require 'omniauth-rdio-oauth2'

use Rack::Session::Cookie
use OmniAuth::Builder do
  provider :rdio_oauth2, "CLIENT_ID", "CLIENT_SECRET"
end

get '/' do
  <<-HTML
  <a href='/auth/rdio_oauth2'>Sign in with Rdio</a>
  HTML
end

get '/auth/rdio_oauth2/callback' do
  auth = request.env['omniauth.auth']
  redirect '/'
end

get '/auth/failure' do
  puts params[:message]
  redirect '/'
end
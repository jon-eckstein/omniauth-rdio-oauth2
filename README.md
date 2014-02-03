omniauth-rdio-oauth2
--------------------

An Omniauth Strategy for Rdio's OAuth2 API/ Beta JS API

This gem is mostly untested. Use at your own risk.

## Installation

Add to your `Gemfile`:

```ruby
gem 'omniauth-rdio-oauth2'
```

Then `bundle install`.

## Usage

Here's an example for adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :rdio_oauth2, ENV["RDIO_CLIENT_ID"], ENV["RDIO_CLIENT_SECRET"]
end
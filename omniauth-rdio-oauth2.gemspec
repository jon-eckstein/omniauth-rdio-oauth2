# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name          = 'omniauth-rdio-oauth2'
  gem.version       = '0.1.2'
  gem.author        = 'Robert Long'
  gem.email         = 'robert@robertlong.me'
  gem.license       = 'MIT'
  gem.homepage      = 'https://github.com/robertlong/omniauth-rdio-oauth2'
  gem.summary       = 'OmniAuth strategy for Rdio OAuth2'
  gem.description   = 'OmniAuth strategy for Rdio OAuth2'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ['lib']

  # Dependencies
  gem.add_runtime_dependency 'omniauth-oauth2'
end
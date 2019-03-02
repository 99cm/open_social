lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'open_social/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'open_social'
  s.version     = OpenSocial.version
  s.summary     = 'Adds social network login services (OAuth) to Open'
  s.description = s.summary
  s.required_ruby_version = '>= 2.5.3'

  s.author   = 'Leo Wang'
  s.homepage = 'https://github.com/99cm/open_social'
  s.license  = 'BSD-3'

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_runtime_dependency 'open_core', 'master'
  s.add_runtime_dependency 'open_auth_devise', 'master'
  s.add_runtime_dependency 'omniauth'
  s.add_runtime_dependency 'oa-core'
  s.add_runtime_dependency 'omniauth-twitter'
  s.add_runtime_dependency 'omniauth-facebook'
  s.add_runtime_dependency 'omniauth-github'
  s.add_runtime_dependency 'omniauth-google-oauth2'
  s.add_runtime_dependency 'omniauth-amazon'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'capybara-screenshot'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_bot', '~> 4.7'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3', '1.3.6'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'puma'
end
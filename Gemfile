source 'http://rubygems.org'
#gem "rake", "0.8.7"
gem 'rails', '3.1.0.rc5'
gem 'sqlite3'

# Asset template engines
gem 'sass-rails', "~> 3.1.0.rc"
gem 'haml', :git => 'git://github.com/nex3/haml.git' 
gem "haml-rails"
gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'
gem 'compass', :git => 'https://github.com/chriseppstein/compass.git', :branch => 'rails31'

gem 'awesome_nested_set'

group :test, :development do
  gem 'ruby-debug19', :require => 'ruby-debug'
end

group :test do
  gem 'turn', :require => false
end

group :production do
  gem 'therubyracer-heroku'
end

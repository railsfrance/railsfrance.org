source 'http://rubygems.org'

gem 'rails', 				'~> 3.1.1' 

gem 'pg', 				'~> 0.11'
gem 'simple_form', 			'~> 1.5'
gem 'kaminari', 			'~> 0.12'
gem 'make_voteable',			'~> 0.1'
gem 'acts-as-taggable-on',		'~> 2.1'
gem 'haml-rails',			'~> 0.3'
gem 'friendly_id',			'~> 4.0.0.beta14' 
gem 'redis',				'~> 2.2'
gem 'date_validator',			'~> 0.6'
gem 'recaptcha',			'~> 0.3', :require => 'recaptcha/rails'
gem 'httparty'
# Abilities / Authorization
gem 'cancan',				'~> 1.6'
gem 'devise',				'~> 1.1'

# Js
gem 'jquery-rails',			'~> 1.0'
gem 'therubyracer',			'~> 0.9'
gem 'pjax_rails',			:git => 'git://github.com/Sush/pjax_rails.git'
gem 'rails3-jquery-autocomplete',	'~> 1.0'

# Geocoding solution
gem 'geocoder',				'~> 1.0'

# State Machine
gem 'state_machine',			'~> 1.0'

# Markdown syntax
gem 'redcarpet',			'~> 1.17'
gem 'albino',				'~> 1.3'
gem 'nokogiri',				'~> 1.3'
gem 'sanitize',				'~> 2.0'

# Upload solution
gem 'rack-cache', :require => 'rack/cache'
gem 'dragonfly',			'~> 0.9'

# Social
gem 'twitter',				'~> 1.7'
gem 'gravtastic',			'~> 3.2'

# SEO
gem 'meta-tags',			'~> 1.2', :require => 'meta_tags'

# For virtual model
gem 'basic_active_model',		'~> 1.0'

# Configuration helper
gem 'rails_config',			'~> 0.2'

# Exception handling
gem 'exceptional',			'~> 2.0'

# Asset template engines
gem 'sass-rails',			'~> 3.1.1'
group :assets do
  gem 'coffee-rails',			'~> 3.1.1'
  gem 'uglifier',			'~> 1.0'
end

# Admin
gem 'activeadmin',			'~> 0.3'

group :development, :test do
  gem 'ruby-debug19' unless ENV["CI"]
  gem 'awesome_print'
  gem 'capybara',			'~> 1.1'
  gem 'factory_girl_rails',		'~> 1.2'
  gem 'fuubar'
  gem 'launchy'
  gem 'active_reload',			'~> 0.6'
  gem 'letter_opener'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'database_cleaner',		'~> 0.6'
end

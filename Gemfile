source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'

gem 'rails',                      '~> 5.1.4'
gem 'pg',                         '~> 0.18'
gem 'puma',                       '~> 3.7'
gem 'sass-rails',                 '~> 5.0'
gem 'uglifier',                   '>= 1.3.0'
gem 'coffee-rails',               '~> 4.2'
gem 'turbolinks',                 '~> 5'
gem 'figaro' ,                    '~> 1.1'
gem 'unsplash',                   '~> 1.5', '>= 1.5.1'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Bootstrap.
gem 'bootstrap',                  '~> 4.0.0.beta'
gem 'jquery-rails',               '4.3.1'

group :development, :test do
  gem 'guard',                    '~> 2.14', '>= 2.14.1'
  gem 'guard-livereload',         '~> 2.5', '>= 2.5.2'
  gem 'guard-rspec',              '~> 4.7', '>= 4.7.3'
  gem 'rspec-rails',              '~> 3.7'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.2'
  gem 'factory_girl_rails',       '~> 4.8'
  gem 'capybara',                 '~> 2.15', '>= 2.15.4'
  gem 'pry',                      '~> 0.11.2'
  gem 'pry-byebug',               '~> 3.5'
  gem 'pry-rails',                '~> 0.3.6'
  gem 'rubocop-rails',            '~> 1.1'
  gem 'vcr',                      '~> 3.0', '>= 3.0.3'
  gem 'webmock',                  '~> 3.1'
end

group :development do
  gem 'web-console',              '>= 3.3.0'
  gem 'listen',                   '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen',    '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

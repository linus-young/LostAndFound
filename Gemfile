source 'http://ruby.taobao.org'
ruby '2.0.0'

gem 'rails', '3.2.16'

gem 'bootstrap-sass', '~> 2.3.2.0'
gem 'bcrypt-ruby', '~> 3.0.1'
gem 'faker', '~> 1.1.2'
gem 'will_paginate', '~> 3.0.4'
gem 'bootstrap-will_paginate', '~> 0.0.9'
gem 'simple_form'
gem 'rubyzip',  "~> 0.9.9" # because guard do not work well under mac
gem 'activeadmin'
gem "meta_search", '>= 1.1.0.pre'
gem "paperclip", "~> 4.1"
gem 'acts_as_commentable_with_threading'
gem 'rails-i18n', '~> 3.0.0' # For 3.x

# SORRY! But the 'datetimepicker-rails' name in RubyGems repo already taken.
gem 'datetimepicker-rails', require: 'datetimepicker-rails',
                            git: 'git://github.com/zpaulovics/datetimepicker-rails.git'

group :development, :test do
  gem 'sqlite3', '~> 1.3.7'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 2.14.0'
  gem 'guard-rspec', '~> 3.0.2'
  gem 'spork-rails', github: 'sporkrb/spork-rails'
  gem 'guard-spork', '~> 1.5.0'
  gem 'childprocess', '~> 0.3.6'
  gem 'guard-livereload', require: false
end

group :test do
  gem 'selenium-webdriver', '~> 2.0.0'
  gem 'capybara', '~> 2.1.0'

  # use next line in linux
  # gem 'libnotify', '~> 0.8.0'

  gem 'growl', '1.0.3' # for OS X

  gem 'database_cleaner', github: 'bmabey/database_cleaner'
  gem 'factory_girl_rails', '~> 4.2.1'
  gem 'shoulda-matchers'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', '~> 2.2.1'
gem 'turbolinks', '~> 1.1.1'
gem 'jbuilder', '~> 1.0.2'

group :doc do
  gem 'sdoc', '~> 0.3.20', require: false
end

group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

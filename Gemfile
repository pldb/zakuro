# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in zakuro.gemspec
gemspec

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

group :test do
  gem 'rspec'
end

group :development do
  gem 'reek'
  gem 'rubocop-performance'
  gem 'solargraph'
  gem 'yard'
end

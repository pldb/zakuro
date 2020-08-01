# frozen_string_literal: true

require 'bundler/gem_tasks'

require 'rspec/core/rake_task'
require 'yard'
require 'yard/rake/yardoc_task'

# rake spec
RSpec::Core::RakeTask.new('spec')
task default: :spec

# rake yard
YARD::Rake::YardocTask.new do |t|
  t.files = %w[
    lib/**/*.rb
  ]
  t.options = []
  # t.options = %w[--debug --verbose] if $trace
end

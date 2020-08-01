# frozen_string_literal: true

require_relative 'lib/zakuro/version'

Gem::Specification.new do |spec|
  spec.name          = 'zakuro'
  spec.version       = Zakuro::VERSION
  spec.authors       = ['pldb']
  spec.email         = ['pldb.github@gmail.com']

  spec.summary       = 'japanese calendar library.'
  spec.description   = 'mainly lunar solar calendar'
  spec.homepage      = 'https://github.com/pldb/zakuro'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org/'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/pldb/zakuro'
  spec.metadata['changelog_uri'] = 'https://github.com/pldb/zakuro'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end

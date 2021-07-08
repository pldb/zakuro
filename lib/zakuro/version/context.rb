# frozen_string_literal: true

require_relative './version_class_resolver'

# :nodoc:
module Zakuro
  #
  # Context 暦コンテキスト
  #
  class Context
    attr_reader :version_name
    attr_reader :resolver

    VERSION_NAMES = %w[Genka Gihou Daien Senmyou Joukyou Kansei Tenpou Gregorio].freeze

    def initialize(version_name:)
      raise ArgumentError.new, 'invalid version' unless VERSION_NAMES.include?(version_name)

      @version_name = version_name
      @resolver = VersionClassResolver.new(version_name: version_name)
    end
  end
end

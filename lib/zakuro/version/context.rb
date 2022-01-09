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

    #
    # 初期化
    #
    # @param [String] version_name 暦名
    #
    def initialize(version_name: '')
      @version_name = version_name

      unless invalid?
        raise ArgumentError.new, 'invalid version' unless VERSION_NAMES.include?(version_name)
      end

      @resolver = VersionClassResolver.new(version_name: version_name)
    end

    #
    # 不正か
    #
    # @return [True] 不正
    # @return [False] 不正なし
    #
    def invalid?
      @version_name.empty?
    end
  end
end

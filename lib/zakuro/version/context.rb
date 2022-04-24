# frozen_string_literal: true

require_relative './version_class_resolver'

# :nodoc:
module Zakuro
  #
  # Context 暦コンテキスト
  #
  class Context
    # @return [String] 暦名
    attr_reader :version_name
    # @return [VersionClassResolver] 暦リゾルバー
    attr_reader :resolver

    # @return [Array<String>] 暦名
    VERSION_NAMES = %w[Genka Gihou Daien Senmyou Joukyou Kansei Tenpou Gregorio].freeze

    #
    # 初期化
    #
    # @param [String] version_name 暦名
    #
    # @raise [ArgumentError] 引数エラー
    #
    def initialize(version_name: '')
      @version_name = version_name

      if !invalid? && !VERSION_NAMES.include?(version_name)
        raise ArgumentError.new, 'invalid version'
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

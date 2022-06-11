# frozen_string_literal: true

require_relative './option'

require_relative './version_class_resolver'

# :nodoc:
module Zakuro
  # :nodoc:
  module Context
    #
    # Context 暦コンテキスト
    #
    class Context
      # @return [Option] オプション
      attr_reader :option
      # @return [VersionClassResolver] 暦リゾルバー
      attr_reader :resolver

      #
      # 初期化
      #
      # @param [Hash<String, Object>] options オプション値
      #
      # @raise [ArgumentError] 引数エラー
      #
      def initialize(version: Option::INVALID_VERSION_NAME, options: {})
        @option = Option.new(default_version: version, hash: options)

        @resolver = VersionClassResolver.new(version_name: option.version)
      end

      #
      # 不正か
      #
      # @return [True] 不正
      # @return [False] 不正なし
      #
      def invalid?
        !@option.version?
      end
    end
  end
end

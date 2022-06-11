# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Context
    #
    # Option オプション値
    #
    class Option
      # @return [String] 無効暦名
      INVALID_VERSION_NAME = ''
      # @return [Array<String>] 暦名
      VERSION_NAMES = %w[Genka Gihou Daien Senmyou Joukyou Kansei Tenpou Gregorio].freeze

      # @return [String] 没日オプションキー名
      DROPPED_DATE_KEY = 'dropped_date'

      # @return [Hash<String, Object>] オプション値
      attr_reader :hash
      # @return [String] デフォルト暦名
      attr_reader :default_version

      #
      # 初期化
      #
      # @param [String] default_version デフォルト暦名
      #
      # @param [Hash<String, Object>] options オプション値
      #
      def initialize(default_version: INVALID_VERSION_NAME, hash: {})
        @default_version = default_version
        @hash = hash
      end

      #
      # 暦名を返す
      #
      # @return [String] 暦名
      #
      def version
        version = self.class.version(version: @default_version)

        return version if self.class.version?(version: version)

        version = hash['version']

        self.class.version(version: version)
      end

      #
      # 有効なデフォルト暦名か
      #
      # @return [True] 有効
      # @return [False] 無効
      #
      def default_version?
        self.class.version?(version: @default_version)
      end

      #
      # 有効な暦名か
      #
      # @return [True] 有効
      # @return [False] 無効
      #
      def version?
        self.class.version?(version: version)
      end

      #
      # 没日か
      #
      # @return [True] 没日あり
      # @return [False] 没日なし
      #
      def dropped_date?
        value = @hash[DROPPED_DATE_KEY]

        return true if value.is_a?(TrueClass)

        false
      end

      #
      # 暦名を返す
      #
      # @param [String] version 暦名
      #
      # @return [String] 暦名
      #
      def self.version(version: INVALID_VERSION_NAME)
        return INVALID_VERSION_NAME unless version

        return INVALID_VERSION_NAME if version.empty?

        return INVALID_VERSION_NAME unless VERSION_NAMES.include?(version)

        version
      end

      #
      # 有効な暦か
      #
      # @param [String] version 暦名
      #
      # @return [True] 有効
      # @return [False] 無効
      #
      def self.version?(version: INVALID_VERSION_NAME)
        return false if version == INVALID_VERSION_NAME

        true
      end
    end
  end
end

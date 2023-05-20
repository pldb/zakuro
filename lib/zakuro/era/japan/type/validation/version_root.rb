# frozen_string_literal: true

require_relative './both/date'
require_relative './both/year'
require_relative './version_range'

# :nodoc:
module Zakuro
  # :nodoc:
  module Japan
    # :nodoc:
    module Type
      # :nodoc:
      module Validation
        #
        # VersionRoot 暦基本情報
        #
        class VersionRoot
          # @return [Hash<String, String>] 終了年
          attr_reader :last_year
          # @return [Hash<String, String>] 終了日
          attr_reader :last_date
          # @return [Array<Hash<String, String>>] 暦期間情報
          attr_reader :list

          #
          # 初期化
          #
          # @param [Hash<String, Object>] hash 暦情報
          #
          def initialize(hash:)
            @last_year = hash['last_year']
            @last_date = hash['last_date']
            @list = hash['list']
          end

          #
          # 検証する
          #
          # @return [Array<String>] 不正メッセージ
          #
          def validate
            failed = []

            failed |= validate_last_year

            failed |= validate_last_date

            failed |= validate_list

            failed
          end

          #
          # 終了年を検証する
          #
          # @return [Array<String>] 不正メッセージ
          #
          def validate_last_year
            Both::Year.new(hash: last_year).validate
          end

          #
          # 終了日を検証する
          #
          # @return [Array<String>] 不正メッセージ
          #
          def validate_last_date
            Both::Date.new(hash: last_date).validate
          end

          #
          # 暦期間情報を検証する
          #
          # @return [True] 正しい
          # @return [False] 正しくない
          #
          def list?
            return false unless list

            list.is_a?(Array)
          end

          #
          # 暦期間情報を検証する
          #
          # @return [Array<String>] 不正メッセージ
          #
          def validate_list
            return ["invalid list. #{list.class}"] unless list?

            failed = []
            list.each_with_index do |li, index|
              failed |= VersionRange.new(hash: li, index: index).validate
            end
            failed
          end
        end
      end
    end
  end
end

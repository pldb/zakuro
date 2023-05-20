# frozen_string_literal: true

require_relative '../../../western/calendar'
require_relative '../../calendar'
require_relative './both/date'
require_relative './both/year'

# :nodoc:
module Zakuro
  # :nodoc:
  module Japan
    # :nodoc:
    module Type
      # :nodoc:
      module Validation
        #
        # Gengou 元号情報
        #
        class Gengou
          # @return [Integer] 要素位置
          attr_reader :index
          # @return [String] 元号名
          attr_reader :name
          # @return [Hash<String, String>] 開始年
          attr_reader :start_year
          # @return [Hash<String, String>] 開始日
          attr_reader :start_date

          #
          # 初期化
          #
          # @param [Hash<String, Strin>] hash 元号情報
          # @param [Integer] index （元号セット内での）元号の要素位置
          #
          def initialize(hash:, index:)
            @index = index
            @name = hash['name']
            @start_year = hash['start_year']
            @start_date = hash['start_date']
          end

          #
          # 検証する
          #
          # @return [Array<String>] 不正メッセージ
          #
          def validate
            prefix = "list[#{index}]. "
            failed = []

            failed.push(prefix + "invalid name. #{name}") unless name?

            failed |= validate_start_year

            failed |= validate_start_date

            failed
          end

          #
          # 元号名を検証する
          #
          # @return [True] 正しい
          # @return [False] 正しくない
          #
          def name?
            return false unless name

            name.is_a?(String)
          end

          #
          # 開始年を検証する
          #
          # @return [Array<String>] 不正メッセージ
          #
          def validate_start_year
            Both::Year.new(hash: start_year).validate
          end

          #
          # 開始日を検証する
          #
          # @return [Array<String>] 不正メッセージ
          #
          def validate_start_date
            SwitchDate.new(hash: start_date).validate
          end
        end
      end
    end
  end
end

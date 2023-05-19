# frozen_string_literal: true

require_relative '../../../japan/calendar'
require_relative '../../../western/calendar'

require_relative '../../type/validation/both/date'
require_relative '../../type/validation/both/year'

require_relative './type'
require 'yaml'

# :nodoc:
module Zakuro
  # :nodoc:
  module Japan
    # :nodoc:
    module Version
      #
      # Resource yaml解析結果
      #
      module Resource
        #
        # Validator yaml解析
        #
        module Validator
          #
          # Root 基本情報
          #
          class Root
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
              Type::Validation::Both::Year.new(hash: last_year).validate
            end

            #
            # 終了日を検証する
            #
            # @return [Array<String>] 不正メッセージ
            #
            def validate_last_date
              Type::Validation::Both::Date.new(hash: last_date).validate
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
                failed |= Range.new(hash: li, index: index).validate
              end
              failed
            end
          end

          #
          # Range 暦期間情報
          #
          class Range
            # @return [Integer] 要素位置
            attr_reader :index
            # @return [String] 元号名
            attr_reader :name
            # @return [Hash<String, String>] 開始年
            attr_reader :start_year
            # @return [Hash<String, String>] 開始日
            attr_reader :start_date
            # @return [True] リリース有
            # @return [False] リリース無
            attr_reader :released

            #
            # 初期化
            #
            # @param [Hash<String, Strin>] hash 元号情報
            # @param [Integer] index 暦情報の要素位置
            #
            def initialize(hash:, index:)
              @index = index
              @name = hash['name']
              @start_year = hash['start_year']
              @start_date = hash['start_date']
              @released = hash['released']
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

              failed.push(prefix + "invalid released. #{released}") unless released?

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
              Type::Validation::Both::Year.new(hash: start_year).validate
            end

            #
            # 開始日を検証する
            #
            # @return [Array<String>] 不正メッセージ
            #
            def validate_start_date
              Type::Validation::Both::Date.new(hash: start_date).validate
            end

            #
            # リリース有無を検証する
            #
            # @return [True] 正しい
            # @return [False] 正しくない
            #
            def released?
              return false if released.nil?

              released.is_a?(TrueClass) || released.is_a?(FalseClass)
            end
          end

          class << self
            #
            # 検証する
            #
            # @param [Hash<String, Object>] yaml_hash yaml取得結果
            #
            # @return [Array<String>] 不正メッセージ
            #
            def run(yaml_hash:)
              Root.new(hash: yaml_hash).validate
            end
          end
        end
      end
    end
  end
end

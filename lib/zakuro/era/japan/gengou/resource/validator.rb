# frozen_string_literal: true

require_relative '../../../japan/calendar'
require_relative '../../../western/calendar'
require_relative './type'
require 'yaml'

# :nodoc:
module Zakuro
  # :nodoc:
  module Japan
    # :nodoc:
    module Gengou
      #
      # Resource yaml解析結果
      #
      module Resource
        #
        # Validator yaml解析
        #
        module Validator
          #
          # Set 元号セット情報の検証/展開
          #
          class Set
            # @return [String] 元号セットID
            attr_reader :id
            # @return [String] 元号セット名
            attr_reader :name
            # @return [Hash<String, String>] 終了年
            attr_reader :last_year
            # @return [Hash<String, String>] 終了日
            attr_reader :last_date
            # @return [Array<Hash<String, String>>] 元号情報
            attr_reader :list

            #
            # 初期化
            #
            # @param [Hash<String, Object>] hash 元号セット情報
            #
            def initialize(hash:)
              @id = hash['id']
              @name = hash['name']
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
              failed.push("invalid id. #{id}") unless id?

              failed.push("invalid name. #{name}") unless name?

              failed |= validate_last_year

              failed |= validate_last_date

              failed |= validate_list
              failed
            end

            #
            # IDを検証する
            #
            # @return [True] 正しい
            # @return [False] 正しくない
            #
            def id?
              return false unless id

              id.is_a?(Integer)
            end

            #
            # 元号セット名を検証する
            #
            # @return [True] 正しい
            # @return [False] 正しくない
            #
            def name?
              return false unless @name

              name.is_a?(String)
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
              SwitchDate.new(hash: last_date).validate
            end

            #
            # 元号情報を検証する
            #
            # @return [True] 正しい
            # @return [False] 正しくない
            #
            def list?
              return false unless list

              list.is_a?(Array)
            end

            #
            # 元号情報を検証する
            #
            # @return [Array<String>] 不正メッセージ
            #
            def validate_list
              return ["invalid list. #{list.class}"] unless list?

              failed = []
              list.each_with_index do |li, index|
                failed |= Gengou.new(hash: li, index: index).validate
              end
              failed
            end
          end

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

          #
          # SwitchDate 切替日（運用/計算）
          #
          class SwitchDate
            # @return [Hash<String, Strin>] 計算値
            attr_reader :calculation
            # @return [Hash<String, Strin>] 運用値
            attr_reader :operation

            #
            # 初期化
            #
            # @param [Hash<String, Strin>] hash 切替日（運用/計算）
            #
            def initialize(hash:)
              @calculation = hash['calculation']
              @operation = hash['operation']
            end

            #
            # 検証する
            #
            # @return [Array<String>] 不正メッセージ
            #
            def validate
              failed = []

              failed |= validate_calculation_date

              failed |= validate_operation_date

              failed
            end

            private

            #
            # 日（計算値）を検証する
            #
            # @return [Array<String>] 不正メッセージ
            #
            def validate_calculation_date
              Both::Date.new(hash: calculation, optional: true).validate
            end

            #
            # 日（運用値）を検証する
            #
            # @return [Array<String>] 不正メッセージ
            #
            def validate_operation_date
              Both::Date.new(hash: operation).validate
            end
          end

          #
          # Both 和暦/西暦
          #
          module Both
            #
            # Year 年
            #
            class Year
              # @return [String] 和暦元号年
              attr_reader :japan
              # @return [String] 西暦年
              attr_reader :western

              #
              # 初期化
              #
              # @param [Hash<String, Strin>] hash 年情報
              #
              def initialize(hash:)
                @japan = hash['japan']
                @western = hash['western']
              end

              #
              # 検証する
              #
              # @return [Array<String>] 不正メッセージ
              #
              def validate
                failed = []

                failed.push("invalid japan year. #{japan}") unless japan?

                failed.push("invalid western year. #{western}") unless western?

                failed
              end

              #
              # 和暦元号年を検証する
              #
              # @return [True] 正しい
              # @return [False] 正しくない
              #
              def japan?
                return false unless @japan

                japan.is_a?(Integer)
              end

              #
              # 和暦元号年を検証する
              #
              # @return [True] 正しい
              # @return [False] 正しくない
              #
              def western?
                return false unless @western

                western.is_a?(Integer)
              end
            end

            #
            # Date 日
            #
            class Date
              # @return [String] 和暦日
              attr_reader :japan
              # @return [String] 西暦日
              attr_reader :western
              # @return [True] 省略可
              # @return [False] 省略不可
              attr_reader :optional

              #
              # 初期化
              #
              # @param [Hash<String, Strin>] hash 日情報
              #
              def initialize(hash:, optional: false)
                @japan = hash['japan']
                @western = hash['western']
                @optional = optional
              end

              #
              # 検証する
              #
              # @return [Array<String>] 不正メッセージ
              #
              def validate
                failed = []

                failed.push("invalid japan date. #{japan}") unless japan?

                failed.push("invalid western date. #{western}") unless western?

                failed
              end

              #
              # 和暦日を検証する
              #
              # @return [True] 正しい
              # @return [False] 正しくない
              #
              def japan?
                return true if optional?(text: japan)

                Japan::Calendar.valid_date_text(text: japan)
              end

              #
              # 西暦日を検証する
              #
              # @return [True] 正しい
              # @return [False] 正しくない
              #
              def western?
                return true if optional?(text: western)

                Western::Calendar.valid_date_text(text: western)
              end

              #
              # 省略可で省略されているか
              #
              # @param [String] text 文字列
              #
              # @return [True] 省略あり
              # @return [False] 省略なし
              #
              def optional?(text: '')
                return false unless optional

                return true if text == ''

                false
              end
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
              Set.new(hash: yaml_hash).validate
            end
          end
        end
      end
    end
  end
end

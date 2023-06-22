# frozen_string_literal: true

require_relative './gengou'
require_relative './switch_date'

# :nodoc:
module Zakuro
  # :nodoc:
  module Japan
    # :nodoc:
    module Type
      # :nodoc:
      module Validation
        #
        # GengouSet 元号セット情報の検証/展開
        #
        class GengouSet
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
      end
    end
  end
end

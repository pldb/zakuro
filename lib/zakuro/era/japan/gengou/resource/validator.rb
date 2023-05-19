# frozen_string_literal: true

require_relative '../../../japan/calendar'
require_relative '../../../western/calendar'

require_relative '../../type/validation/switch_date'

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
              Type::Validation::Both::Year.new(hash: last_year).validate
            end

            #
            # 終了日を検証する
            #
            # @return [Array<String>] 不正メッセージ
            #
            def validate_last_date
              Type::Validation::SwitchDate.new(hash: last_date).validate
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
              Type::Validation::Both::Year.new(hash: start_year).validate
            end

            #
            # 開始日を検証する
            #
            # @return [Array<String>] 不正メッセージ
            #
            def validate_start_date
              Type::Validation::SwitchDate.new(hash: start_date).validate
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

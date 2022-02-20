# frozen_string_literal: true

require_relative '../../../japan/calendar'
require_relative '../../../western/calendar'
require_relative './type'
require 'yaml'

# :nodoc:
module Zakuro
  #
  # Japan 和暦
  #
  module Japan
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
          attr_reader :both_last_year
          # @return [Hash<String, String>] 終了日
          attr_reader :both_last_date
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
            @both_last_year = hash['last_year']
            @both_last_date = hash['last_date']
            @list = hash['list']
          end

          #
          # 検証する
          #
          # @return [Array<String>] 不正メッセージ
          #
          def validate
            failed = []
            failed.push("invalid id. #{@id}") unless id?

            failed.push("invalid name. #{@name}") unless name?

            failed |= validate_both_last_year

            failed |= validate_both_last_date

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
            return false unless @id

            @id.is_a?(Integer)
          end

          #
          # 元号セット名を検証する
          #
          # @return [True] 正しい
          # @return [False] 正しくない
          #
          def name?
            return false unless @name

            @name.is_a?(String)
          end

          #
          # 終了年を検証する
          #
          # @return [Array<String>] 不正メッセージ
          #
          def validate_both_last_year
            Both::Year.new(hash: @both_last_year).validate
          end

          #
          # 終了日を検証する
          #
          # @return [Array<String>] 不正メッセージ
          #
          def validate_both_last_date
            Both::Date.new(hash: @both_last_date).validate
          end

          #
          # 元号情報を検証する
          #
          # @return [True] 正しい
          # @return [False] 正しくない
          #
          def list?
            return false unless @list

            @list.is_a?(Array)
          end

          #
          # 元号情報を検証する
          #
          # @return [Array<String>] 不正メッセージ
          #
          def validate_list
            return ["invalid list. #{@list.class}"] unless list?

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
          attr_reader :both_start_year
          # @return [Hash<String, String>] 開始日
          attr_reader :both_start_date

          #
          # 初期化
          #
          # @param [Hash<String, Strin>] hash 元号情報
          # @param [Integer] index （元号セット内での）元号の要素位置
          #
          def initialize(hash:, index:)
            @index = index
            @name = hash['name']
            @both_start_year = hash['start_year']
            @both_start_date = hash['start_date']
          end

          #
          # 検証する
          #
          # @return [Array<String>] 不正メッセージ
          #
          def validate
            prefix = "list[#{index}]. "
            failed = []

            failed.push(prefix + "invalid name. #{@name}") unless name?

            failed |= validate_both_start_year

            failed |= validate_both_start_date

            failed
          end

          #
          # 元号名を検証する
          #
          # @return [True] 正しい
          # @return [False] 正しくない
          #
          def name?
            return false unless @name

            @name.is_a?(String)
          end

          #
          # 開始年を検証する
          #
          # @return [Array<String>] 不正メッセージ
          #
          def validate_both_start_year
            Both::Year.new(hash: @both_start_year).validate
          end

          #
          # 開始日を検証する
          #
          # @return [Array<String>] 不正メッセージ
          #
          def validate_both_start_date
            Both::Date.new(hash: @both_start_date).validate
          end
        end

        #
        # 和暦/西暦
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

              failed.push("invalid japan year. #{@japan}") unless japan?

              failed.push("invalid western year. #{@western}") unless western?

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

              @japan.is_a?(Integer)
            end

            #
            # 和暦元号年を検証する
            #
            # @return [True] 正しい
            # @return [False] 正しくない
            #
            def western?
              return false unless @western

              @western.is_a?(Integer)
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

            #
            # 初期化
            #
            # @param [Hash<String, Strin>] hash 日情報
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

              failed.push("invalid japan date. #{@japan}") unless japan?

              failed.push("invalid western date. #{@western}") unless western?

              failed
            end

            #
            # 和暦日を検証する
            #
            # @return [True] 正しい
            # @return [False] 正しくない
            #
            def japan?
              Japan::Calendar.valid_date_string(text: @japan)
            end

            #
            # 西暦日を検証する
            #
            # @return [True] 正しい
            # @return [False] 正しくない
            #
            def western?
              Western::Calendar.valid_date_string(str: @western)
            end
          end
        end

        #
        # 検証する
        #
        # @param [Hash<String, Object>] yaml_hash yaml取得結果
        #
        # @return [Array<String>] 不正メッセージ
        #
        def self.run(yaml_hash:)
          Set.new(hash: yaml_hash).validate
        end
      end
    end
  end
end

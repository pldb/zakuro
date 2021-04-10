# frozen_string_literal: true

require_relative '../../western'
require_relative './type'
require 'yaml'

# :nodoc:
module Zakuro
  #
  # Japan 和暦
  #
  module Japan
    #
    # Validator yaml解析
    #
    module Validator
      # :reek:TooManyInstanceVariables { max_instance_variables: 5 }

      #
      # Set 元号セット情報の検証/展開
      #
      class Set
        # @return [String] 元号セットID
        attr_reader :id
        # @return [String] 元号セット名
        attr_reader :name
        # @return [String] 終了日
        attr_reader :end_date
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
          @end_date = hash['end_date']
          @list = hash['list']
        end

        # :reek:TooManyStatements { max_statements: 6 }

        #
        # 検証する
        #
        # @return [Array<String>] 不正メッセージ
        #
        def validate
          failed = []
          failed.push("invalid id. #{id}") unless id?

          failed.push("invalid name. #{name}") unless name?

          failed.push("invalid end_date. #{end_date}") unless western_date?

          failed |= validate_list
          failed
        end

        # :reek:NilCheck

        #
        # IDを検証する
        #
        # @return [True] 正しい
        # @return [False] 正しくない
        #
        def id?
          !(@id.nil? || !@id.is_a?(Integer))
        end

        #
        # 元号セット名を検証する
        #
        # @return [True] 正しい
        # @return [False] 正しくない
        #
        def name?
          !(@name.nil? || !@name.is_a?(String))
        end

        #
        # 日付文字列を検証する
        #
        # @return [True] 正しい
        # @return [False] 正しくない
        #
        def western_date?
          Western::Calendar.valid_date_string(str: @end_date)
        end

        # :reek:NilCheck

        #
        # 元号情報を検証する
        #
        # @return [True] 正しい
        # @return [False] 正しくない
        #
        def list?
          (!@list.nil? || @list.is_a?(Array))
        end

        #
        # 元号情報を検証する
        #
        # @return [True] 正しい
        # @return [False] 正しくない
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
        # @return [String] 開始日
        attr_reader :start_date
        # @return [String] 元旦
        attr_reader :new_year_date
        # @return [String] 開始年
        attr_reader :start_year

        #
        # 初期化
        #
        # @param [Hash<String, Strin>] hash 元号情報
        # @param [Integer] index （元号セット内での）元号の要素位置
        #
        def initialize(hash:, index:)
          @index = index
          @name = hash['name']
          @start_date = hash['start_date']
          @new_year_date = hash['new_year_date']
          @start_year = hash['start_year']
        end

        # :reek:TooManyStatements { max_statements: 7 }

        #
        # 検証する
        #
        # @return [Array<String>] 不正メッセージ
        #
        def validate
          prefix = "list[#{index}]. "
          failed = []

          failed.push(prefix + "invalid name. #{@name}") unless name?

          failed.push(prefix + "invalid start_date. #{@start_date}") unless start_date?

          failed.push(prefix + "invalid start_year. #{@start_year}") unless year?

          failed.push(prefix + "invalid new_year_date. #{@new_year_date}") unless new_year_date?

          failed
        end

        # :reek:NilCheck

        #
        # 元号名を検証する
        #
        # @return [True] 正しい
        # @return [False] 正しくない
        #
        def name?
          (!@name.nil? || @name.is_a?(String))
        end

        #
        # 開始日文字列を検証する
        #
        # @return [True] 正しい
        # @return [False] 正しくない
        #
        def start_date?
          Western::Calendar.valid_date_string(str: @start_date)
        end

        #
        # 元旦文字列を検証する
        #
        # @return [True] 正しい
        # @return [False] 正しくない
        #
        def new_year_date?
          Western::Calendar.valid_date_string(str: @new_year_date)
        end

        # :reek:NilCheck

        #
        # 元号年を検証する
        #
        # @return [True] 正しい
        # @return [False] 正しくない
        #
        def year?
          return true if @start_year.nil?

          @start_year.is_a?(Integer)
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

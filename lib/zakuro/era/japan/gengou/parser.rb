# frozen_string_literal: true

require_relative '../../western'
require_relative './type'
require_relative './validator'
require 'yaml'

# :nodoc:
module Zakuro
  #
  # Japan 和暦
  #
  module Japan
    # :reek:TooManyInstanceVariables { max_instance_variables: 5 }

    #
    # Parser yaml解析
    #
    module Parser
      # :reek:TooManyInstanceVariables { max_instance_variables: 5 }

      #
      # GengouParser 元号情報の検証/展開を行う
      #
      class GengouParser
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

        #
        # 元号情報を生成する
        #
        # @return [Gengou] 元号情報
        #
        def create
          start_date = Western::Calendar.parse(str: @start_date)
          new_year_date = Western::Calendar.parse(str: @new_year_date)
          start_year = @start_year || 1

          Gengou.new(name: @name, start_date: start_date, new_year_date: new_year_date,
                     year: start_year)
        end
      end

      #
      # SetParser 元号セット情報の検証/展開
      #
      class SetParser
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

        #
        # 元号セット情報を生成する
        #
        # @return [Set] 元号セット情報
        #
        def create
          end_date = Western::Calendar.parse(str: @end_date)
          list = create_list
          Set.new(
            id: @id, name: @name, end_date: end_date, list: list
          )
        end

        # :reek:TooManyStatements { max_statements: 7 }

        #
        # 元号情報を生成する
        #
        # @return [Array<Gengou>] 元号情報
        #
        def create_list
          result = []
          @list.each_with_index do |li, index|
            gengou = GengouParser.new(hash: li, index: index).create
            next_index = index + 1
            gengou = calc_end_date_on_gengou_data(next_index: next_index,
                                                  gengou: gengou)
            result.push(gengou)
          end

          result
        end

        # :reek:TooManyStatements { max_statements: 6 }

        #
        # 次の元号の開始日から、元号の終了日に変換する
        #
        # @param [Integer] next_index 次の元号の要素位置
        # @param [String] gengou 次回開始日
        #
        # @return [Gengou] 元号情報
        #
        def calc_end_date_on_gengou_data(next_index:, gengou:)
          if next_index >= @list.size
            end_date = Western::Calendar.parse(str: @end_date)
            gengou.write_end_date(end_date: end_date)
            return gengou
          end
          next_start_date = @list[next_index]['start_date']
          gengou.convert_next_start_date_to_end_date(
            next_start_date_string: next_start_date
          )
          gengou
        end
      end

      #
      # 解析/展開する
      #
      # @param [String] filepath 元号セットファイルパス
      #
      # @return [Set] 元号セット情報
      #
      def self.run(filepath: '')
        yaml = YAML.load_file(filepath)

        failed = Validator.run(yaml_hash: yaml)

        raise ArgumentError, failed.join("\n") unless failed.empty?

        parser = SetParser.new(hash: yaml)
        parser.create
      end
    end
  end
end

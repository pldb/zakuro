# frozen_string_literal: true

require_relative '../../../western/calendar'
require_relative './type'
require_relative './validator'
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
        # :reek:TooManyInstanceVariables { max_instance_variables: 5 }

        #
        # Parser yaml解析
        #
        module Parser
          #
          # GengouParser 元号情報の検証/展開を行う
          #
          class GengouParser
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
            # 元号情報を生成する
            #
            # @return [Gengou] 元号情報
            #
            def create
              both_start_year = Both::YearParser.new(hash: @both_start_year).create
              both_start_date = Both::DateParser.new(hash: @both_start_date).create

              Gengou.new(name: @name, both_start_year: both_start_year,
                         both_start_date: both_start_date)
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
            # 元号セット情報を生成する
            #
            # @return [Set] 元号セット情報
            #
            def create
              both_last_date = Both::DateParser.new(hash: @both_last_date).create
              list = create_list
              Set.new(
                id: @id, name: @name, both_last_date: both_last_date, list: list
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
                gengou = calc_last_date_on_gengou_data(next_index: next_index,
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
            def calc_last_date_on_gengou_data(next_index:, gengou:)
              if next_index >= @list.size
                gengou.write_last_year(last_year: @both_last_year['western'])
                last_date = Western::Calendar.parse(text: @both_last_date['western'])
                gengou.write_last_date(last_date: last_date)
                return gengou
              end
              next_item = @list[next_index]
              gengou.convert_next_start_year_to_last_year(
                next_start_year: next_item['start_year']['western']
              )
              gengou.convert_next_start_date_to_last_date(
                next_start_date: next_item['start_date']['western']
              )
              gengou
            end
          end

          #
          # 和暦/西暦
          #
          module Both
            #
            # YearParser 年
            #
            class YearParser
              # @return [Integer] 和暦元号年
              attr_reader :japan
              # @return [Integer] 西暦年
              attr_reader :western

              #
              # 初期化
              #
              # @param [Hash<String, Object>] hash 年情報
              #
              def initialize(hash:)
                @japan = hash['japan']
                @western = hash['western']
              end

              #
              # 年情報を生成する
              #
              # @return [Both::Year] 年情報
              #
              def create
                japan = @japan.to_i
                western = @western.to_i

                Japan::Gengou::Resource::Both::Year.new(japan: japan, western: western)
              end
            end

            #
            # DateParser 日
            #
            class DateParser
              # @return [Japan::Calendar] 和暦日
              attr_reader :japan
              # @return [Western::Calendar] 西暦日
              attr_reader :western

              #
              # 初期化
              #
              # @param [Hash<String, Object>] hash 日情報
              #
              def initialize(hash:)
                @japan = hash['japan']
                @western = hash['western']
              end

              #
              # 日情報を生成する
              #
              # @return [Both::Date] 日情報
              #
              def create
                japan = Japan::Calendar.parse(text: @japan)
                western = Western::Calendar.parse(text: @western)

                Japan::Gengou::Resource::Both::Date.new(japan: japan, western: western)
              end
            end
          end

          #
          # 解析/展開する
          #
          # @param [String] filepath 元号セットファイルパス
          #
          # @return [Set] 元号セット情報
          #
          # @raise [ArgumentError] 引数エラー
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
  end
end

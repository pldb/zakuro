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
            attr_reader :start_year
            # @return [Hash<String, String>] 開始日
            attr_reader :start_date
            # @return [True, False] 運用値
            attr_reader :operated

            #
            # 初期化
            #
            # @param [Hash<String, Strin>] hash 元号情報
            # @param [Integer] index （元号セット内での）元号の要素位置
            # @param [True, False] operated 運用値設定
            #
            def initialize(hash:, index:, operated: false)
              @index = index
              @name = hash['name']
              @start_year = hash['start_year']
              @start_date = hash['start_date']
              @operated = operated
            end

            #
            # 元号情報を生成する
            #
            # @return [Gengou] 元号情報
            #
            def create
              year = Both::YearParser.new(hash: start_year).create
              date = SwitchDateParser.new(hash: start_date, operated: operated).create

              Gengou.new(name: name, start_year: year,
                         start_date: date)
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
            attr_reader :last_year
            # @return [Hash<String, String>] 終了日
            attr_reader :last_date
            # @return [Array<Hash<String, String>>] 元号情報
            attr_reader :list
            # @return [True, False] 運用値
            attr_reader :operated

            #
            # 初期化
            #
            # @param [Hash<String, Object>] hash 元号セット情報
            # @param [True, False] operated 運用値設定
            #
            def initialize(hash:, operated: false)
              @id = hash['id']
              @name = hash['name']
              @last_year = hash['last_year']
              @last_date = hash['last_date']
              @list = hash['list']
              @operated = operated
            end

            #
            # 元号セット情報を生成する
            #
            # @return [Set] 元号セット情報
            #
            def create
              date = SwitchDateParser.new(hash: last_date, operated: operated).create
              list = create_list
              Set.new(
                id: id, name: name, last_date: date, list: list
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
              list.each_with_index do |li, index|
                gengou = GengouParser.new(
                  hash: li, index: index, operated: operated
                ).create
                next_index = index + 1
                gengou = calc_last_date_on_gengou_data(next_index: next_index,
                                                       gengou: gengou)
                result.push(gengou)
              end

              result
            end

            #
            # 次の元号の開始日から、元号の終了日に変換する
            #
            # @param [Integer] next_index 次の元号の要素位置
            # @param [GengouParser] gengou 元号
            #
            # @return [Gengou] 元号情報
            #
            def calc_last_date_on_gengou_data(next_index:, gengou:)
              if next_index >= list.size
                last_gengou_data(gengou: gengou)
                return gengou
              end
              next_item = list[next_index]
              next_start_date = SwitchDateParser.new(
                hash: next_item['start_date'], operated: operated
              ).create

              gengou.convert_next_start_year_to_last_year(
                next_start_year: next_item['start_year']['western']
              )
              gengou.convert_next_start_date_to_last_date(
                next_start_date: next_start_date.western
              )
              gengou
            end

            private

            #
            # 最後の元号の終了日を設定する
            #
            # @param [GengouParser] gengou 元号
            #
            def last_gengou_data(gengou:)
              gengou.write_last_year(last_year: last_year['western'])

              date = SwitchDateParser.new(hash: last_date, operated: operated).create

              gengou.write_last_date(last_date: date.western)
            end
          end

          #
          # SwitchDateParser 切替日（運用/計算）
          #
          class SwitchDateParser
            # @return [Hash<String, Strin>] 計算値
            attr_reader :calculation
            # @return [Hash<String, Strin>] 運用値
            attr_reader :operation
            # @return [True, False] 運用値
            attr_reader :operated

            #
            # 初期化
            #
            # @param [Hash<String, Strin>] hash 切替日（運用/計算）
            # @param [True, False] operated 運用値設定
            #
            def initialize(hash:, operated: false)
              @calculation = hash['calculation']
              @operation = hash['operation']
              @operated = operated
            end

            #
            # 切替日（運用/計算）情報を生成する
            #
            # @return [SwitchDate] 切替日（運用/計算）情報
            #
            def create
              calculation_date = Both::DateParser.new(hash: calculation).create
              operation_date = Both::DateParser.new(hash: operation).create

              Type::Base::SwitchDate.new(
                calculation: calculation_date, operation: operation_date,
                operated: operated
              )
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
                japan_year = japan.to_i
                western_year = western.to_i

                Type::Base::Both::Year.new(
                  japan: japan_year, western: western_year
                )
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
              # @return [Type::Base::Both::Date] 日情報
              #
              def create
                japan_date = Japan::Calendar.new
                western_date = Western::Calendar.new

                japan_date = Japan::Calendar.parse(text: japan) unless japan == ''
                western_date = Western::Calendar.parse(text: western) unless western == ''

                Type::Base::Both::Date.new(
                  japan: japan_date, western: western_date
                )
              end
            end
          end

          class << self
            #
            # 解析/展開する
            #
            # @param [String] filepath 元号セットファイルパス
            # @param [True, False] operated 運用値設定
            #
            # @return [Set] 元号セット情報
            #
            # @raise [ArgumentError] 引数エラー
            #
            def run(filepath: '', operated: false)
              yaml = YAML.load_file(filepath)

              failed = Validator.run(yaml_hash: yaml)

              raise ArgumentError, failed.join("\n") unless failed.empty?

              parser = SetParser.new(hash: yaml, operated: operated)
              parser.create
            end
          end
        end
      end
    end
  end
end

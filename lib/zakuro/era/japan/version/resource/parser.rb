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
    module Version
      #
      # Resource yaml解析結果
      #
      module Resource
        #
        # Parser yaml解析
        #
        module Parser
          #
          # RangeParser 暦期間情報の検証/展開を行う
          #
          class RangeParser
            # @return [Integer] 要素位置
            attr_reader :index
            # @return [String] 暦名
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
            # @param [Integer] index （元号セット内での）元号の要素位置
            #
            def initialize(hash:, index:)
              @index = index
              @name = hash['name']
              @start_year = hash['start_year']
              @start_date = hash['start_date']
              @released = hash['released']
            end

            #
            # 暦期間情報を生成する
            #
            # @return [Range] 暦期間情報
            #
            def create
              year = Both::YearParser.new(hash: start_year).create
              date = Both::DateParser.new(hash: start_date).create

              Range.new(
                name: name, start_year: year,
                start_date: date, released: released
              )
            end
          end

          #
          # RootParser 暦期間情報の検証/展開
          #
          class RootParser
            # @return [Hash<String, String>] 終了年
            attr_reader :last_year
            # @return [Hash<String, String>] 終了日
            attr_reader :last_date
            # @return [Array<Hash<String, String>>] 暦期間情報
            attr_reader :list

            #
            # 初期化
            #
            # @param [Hash<String, Object>] hash 暦期間情報
            #
            def initialize(hash:)
              @id = hash['id']
              @name = hash['name']
              @last_year = hash['last_year']
              @last_date = hash['last_date']
              @list = hash['list']
            end

            #
            # 暦期間情報を生成する
            #
            # @return [Array<Range>] 暦期間情報
            #
            def create
              Both::DateParser.new(hash: last_date).create

              create_list
            end

            # :reek:TooManyStatements { max_statements: 7 }

            #
            # 暦期間情報を生成する
            #
            # @return [Array<Range>] 暦期間情報
            #
            def create_list
              result = []
              list.each_with_index do |li, index|
                range = RangeParser.new(hash: li, index: index).create
                next_index = index + 1
                range = calc_last_date_on_range_data(next_index: next_index,
                                                     range: range)
                result.push(range)
              end

              result
            end

            #
            # 次の暦期間の開始日から、暦期間の終了日に変換する
            #
            # @param [Integer] next_index 次の暦期間の要素位置
            # @param [RangeParser] range 暦期間
            #
            # @return [Range] 暦期間情報
            #
            def calc_last_date_on_range_data(next_index:, range:)
              if next_index >= list.size
                last_range_data(range: range)
                return range
              end
              next_item = list[next_index]
              next_start_date = Both::DateParser.new(
                hash: next_item['start_date']
              ).create

              range.convert_next_start_year_to_last_year(
                next_start_year: next_item['start_year']['western']
              )
              range.convert_next_start_date_to_last_date(
                next_start_date: next_start_date.western
              )
              range
            end

            private

            #
            # 最後の元号の終了日を設定する
            #
            # @param [RangeParser] range 暦期間情報
            #
            def last_range_data(range:)
              range.write_last_year(last_year: last_year['western'])

              date = Both::DateParser.new(hash: last_date).create

              range.write_last_date(last_date: date.western)
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

                Japan::Version::Resource::Both::Year.new(
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
              # @return [Both::Date] 日情報
              #
              def create
                japan_date = Japan::Calendar.new
                western_date = Western::Calendar.new

                japan_date = Japan::Calendar.parse(text: japan) unless japan == ''
                western_date = Western::Calendar.parse(text: western) unless western == ''

                Japan::Version::Resource::Both::Date.new(
                  japan: japan_date, western: western_date
                )
              end
            end
          end

          class << self
            #
            # 解析/展開する
            #
            # @param [String] filepath 暦期間情報ファイルパス
            #
            # @return [Array<Range>] 暦期間情報
            #
            # @raise [ArgumentError] 引数エラー
            #
            def run(filepath: '')
              yaml = YAML.load_file(filepath)

              failed = Validator.run(yaml_hash: yaml)

              raise ArgumentError, failed.join("\n") unless failed.empty?

              parser = RootParser.new(hash: yaml)
              parser.create
            end
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

require_relative './western'
require 'yaml'

# :nodoc:
module Zakuro
  #
  # Japan 和暦
  #
  module Japan
    #
    # Reki 暦
    #
    module Reki
      #
      # Range 暦（範囲）
      #
      class Range
        # @return [String] 暦のクラス名
        #   version 以下を参照
        attr_reader :class_name
        # @return [Western::Calendar] 暦の開始日
        attr_reader :start_date

        #
        # 初期化
        #
        # @param [String] class_name 暦のクラス名
        # @param [Western::Calendar] start_date 暦の開始日
        #
        def initialize(class_name:, start_date:)
          @class_name = class_name
          @start_date = start_date
        end
      end

      LIST = [
        Range.new(
          class_name: 'Zakuro::Genka::Gateway',
          start_date: Western::Calendar.new(year: 445, month: 1, day: 24)
        ),
        Range.new(
          class_name: 'Zakuro::Gihou::Gateway',
          start_date: Western::Calendar.new(year: 698, month: 2, day: 16)
        ),
        Range.new(
          class_name: 'Zakuro::Taien::Gateway',
          start_date: Western::Calendar.new(year: 764, month: 2, day: 7)
        ),
        Range.new(
          class_name: 'Zakuro::Senmyou::Gateway',
          start_date: Western::Calendar.new(year: 862, month: 2, day: 3)
        ),
        Range.new(
          class_name: 'Zakuro::Joukyou::Gateway',
          start_date: Western::Calendar.new(year: 1685, month: 2, day: 4)
        ),
        Range.new(
          class_name: 'Zakuro::Houryaku::Gateway',
          start_date: Western::Calendar.new(year: 1755, month: 2, day: 11)
        ),
        Range.new(
          class_name: 'Zakuro::Kansei::Gateway',
          start_date: Western::Calendar.new(year: 1798, month: 2, day: 16)
        ),
        Range.new(
          class_name: 'Zakuro::Tenpou::Gateway',
          start_date: Western::Calendar.new(year: 1844, month: 2, day: 18)
        ),
        Range.new(
          class_name: 'Zakuro::Gregorio::Gateway',
          start_date: Western::Calendar.new(year: 1872, month: 12, day: 9)
        )
      ].freeze

      #
      # 指定した日付から対象の暦を引き当てる
      #
      # @param [Western::Calendar] date 日付
      #
      # @return [String] 暦のクラス名
      #
      def self.class_name(date: Western::Calendar.new)
        LIST.reverse_each do |range|
          return range.class_name if date >= range.start_date
        end
        raise ArgumentError, "invalid date: #{date.format}"
      end
    end

    #
    # Gengou 元号情報
    #
    class Gengou
      # @return [String] 元号名
      attr_reader :name
      # @return [Western::Calendar] 開始日
      attr_reader :start_date
      # @return [Western::Calendar] 元旦
      attr_reader :new_year_date
      # @return [Western::Calendar] 終了日
      attr_reader :end_date
      # @return [Integer] 元号年
      attr_reader :year

      #
      # 初期化
      #
      # @param [String] name 元号名
      # @param [Western::Calendar] start_date 開始日
      # @param [Western::Calendar] new_year_date 元旦
      # @param [Western::Calendar] end_date 終了日
      # @param [Integer] year 元号年
      #
      def initialize(name: '', start_date: Western::Calendar.new,
                     new_year_date: Western::Calendar.new,
                     end_date: Western::Calendar.new, year: -1)
        @name = name
        @start_date = start_date
        @new_year_date = new_year_date
        @end_date = end_date
        @year = year
      end

      #
      # 終了日を更新する
      #
      # @param [Western::Calendar] end_date 終了日
      #
      def write_end_date(end_date:)
        unless Gengou.valid_date(date: end_date)
          raise ArgumentError, "invalid date format. [#{end_date}]"
        end

        @end_date = end_date
        nil
      end

      # :reek:NilCheck

      #
      # 日付が有効かどうかを確認する
      #
      # @param [Western::Calendar] date 日付
      #
      # @return [True] 有効
      # @return [False] 無効
      #
      def self.valid_date(date:)
        !date.nil? && date.is_a?(Western::Calendar)
      end

      #
      # 次の元号の開始日から、元号の終了日に変換する
      #
      # @param [String] next_start_date_string 次回開始日
      #
      def convert_next_start_date_to_end_date(next_start_date_string: '')
        raise ArgumentError, 'empty string cannot convert' if next_start_date_string.empty?

        start_date = Western::Calendar.parse(str: next_start_date_string)
        @end_date = start_date - 1
        nil
      end

      #
      # 指定した日が元号に含まれるか
      #
      # @param [Western::Calendar] date 日
      #
      # @return [True] 含まれる
      # @return [False] 含まれない
      #
      def include?(date:)
        date >= @start_date && date <= @end_date
      end

      #
      # 不正な元号データかを確認する
      #
      # @return [True] 正しくない
      # @return [True] 正しい
      #
      def invalid?
        @year == -1
      end

      #
      # 1元号年を追加する
      #
      def next_year
        @year += 1 unless invalid?
        nil
      end

      def to_s
        "name: #{@name}, start_date: #{@start_date.format}, " \
        "end_date: #{@end_date.format}, year: #{@year}"
      end
    end

    #
    # Set 元号セット
    #
    class Set
      # @return [Integer] 元号セットID
      attr_reader :id
      # @return [String] 元号セット名
      attr_reader :name
      # @return [Western::Calendar] 元号セットでの終了日
      attr_reader :end_date
      # @return [Array<Gengou>] 元号リスト
      attr_reader :list

      #
      # 初期化
      #
      # @param [Integer] id 元号セットID
      # @param [String] name 元号セット名
      # @param [Western::Calendar] end_date 元号セットでの終了日
      # @param [Array<Gengou>] list 元号リスト
      #
      def initialize(id: -1, name: '', end_date: Western::Calendar.new, list: [])
        @id = id
        @name = name
        @end_date = end_date
        @list = list
      end

      #
      # 指定した日付を含む元号を返す
      #
      # @param [Western::Calendar] date 日
      #
      # @return [Gengou] 元号
      #
      def include_item(date:)
        @list.each do |item|
          return item if item.include?(date: date)
        end

        Gengou.new
      end

      #
      # 元号セットが不正かどうかを確認する
      #
      # @return [True] 正しくない
      # @return [False] 正しい
      #
      def invalid?
        @id == -1
      end
    end

    #
    # Parser yaml解析
    #
    module Parser
      #
      # 検証する
      #
      # @param [Hash<String, Object>] yaml_hash yaml取得結果
      #
      # @return [Array<String>] 不正メッセージ
      #
      def self.validate(yaml_hash)
        SetParser.new(hash: yaml_hash).validate
      end

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

        # :reek:TooManyStatements { max_statements: 6 }

        #
        # 検証する
        #
        # @return [Array<String>] 不正メッセージ
        #
        def validate
          prefix = "list[#{index}]. "
          failed = []

          failed.push(prefix + "invalid name. #{@name}") unless valid_name_type?

          failed.push(prefix + "invalid start_date. #{@start_date}") unless valid_start_date_type?

          failed.push(prefix + "invalid start_year. #{@start_year}") unless valid_year_type?

          unless valid_new_year_date_type?
            failed.push(prefix + "invalid new_year_date. #{@new_year_date}")
          end

          failed
        end

        # :reek:NilCheck

        #
        # 元号名を検証する
        #
        # @return [True] 正しい
        # @return [False] 正しくない
        #
        def valid_name_type?
          !(@name.nil? || !@name.is_a?(String))
        end

        #
        # 開始日文字列を検証する
        #
        # @return [True] 正しい
        # @return [False] 正しくない
        #
        def valid_start_date_type?
          Western::Calendar.valid_date_string(str: @start_date)
        end

        #
        # 元旦文字列を検証する
        #
        # @return [True] 正しい
        # @return [False] 正しくない
        #
        def valid_new_year_date_type?
          Western::Calendar.valid_date_string(str: @new_year_date)
        end

        # :reek:NilCheck

        #
        # 元号年を検証する
        #
        # @return [True] 正しい
        # @return [False] 正しくない
        #
        def valid_year_type?
          return true if @start_year.nil?

          @start_year.is_a?(Integer)
        end

        # :reek:NilCheck

        #
        # 元号情報を生成する
        #
        # @return [Gengou] 元号情報
        #
        def create
          start_date = Western::Calendar.parse(str: @start_date)
          new_year_date = Western::Calendar.parse(str: @new_year_date)
          start_year = @start_year.nil? ? 1 : @start_year

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

        # :reek:TooManyStatements { max_statements: 6 }

        #
        # 検証する
        #
        # @return [Array<String>] 不正メッセージ
        #
        def validate
          failed = []
          failed.push("invalid id. #{id}") unless valid_id_type?

          failed.push("invalid name. #{name}") unless valid_name_type?

          failed.push("invalid end_date. #{end_date}") unless valid_date_type?

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
        def valid_id_type?
          !(@id.nil? || !@id.is_a?(Integer))
        end

        #
        # 元号セット名を検証する
        #
        # @return [True] 正しい
        # @return [False] 正しくない
        #
        def valid_name_type?
          !(@name.nil? || !@name.is_a?(String))
        end

        #
        # 日付文字列を検証する
        #
        # @return [True] 正しい
        # @return [False] 正しくない
        #
        def valid_date_type?
          Western::Calendar.valid_date_string(str: @end_date)
        end

        # :reek:NilCheck

        #
        # 元号情報を検証する
        #
        # @return [True] 正しい
        # @return [False] 正しくない
        #
        def valid_list_type?
          (!@list.nil? || @list.is_a?(Array))
        end

        #
        # 元号情報を検証する
        #
        # @return [True] 正しい
        # @return [False] 正しくない
        #
        def validate_list
          return ["invalid list. #{@list.class}"] unless valid_list_type?

          failed = []
          list.each_with_index do |li, index|
            failed |= GengouParser.new(hash: li, index: index).validate
          end
          failed
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
      def self.parse(filepath: '')
        yaml = YAML.load_file(filepath)

        parser = SetParser.new(hash: yaml)
        failed = parser.validate
        raise YAML::ParseError, failed.join('\n') unless failed.empty?

        parser.create
      end
    end

    #
    # GengouResource 元号情報
    #
    module GengouResource
      # @return [Array<Set>] 元号セット情報リスト
      LIST = [
        Parser.parse(filepath: File.expand_path(
          './gengou/set-001-until-south.yaml',
          __dir__
        )),
        Parser.parse(filepath: File.expand_path(
          './gengou/set-002-from-north.yaml',
          __dir__
        )),
        Parser.parse(filepath: File.expand_path(
          './gengou/set-003-modern.yaml',
          __dir__
        ))
      ].freeze

      # :reek:TooManyStatements { max_statements: 9 }

      #
      # 元号（1行目,2行目）を引き当てる
      #
      # * LINE配列の元号情報を配列順で「x行目」（1始まり）とする
      # * 1行目にデータがあれば、第一要素に1行目のデータが設定される
      # * 1行目と2行目にデータがあれば、第二要素に2行目のデータが設定される
      # * 1行目にデータがなく、2行目以降に1つだけデータがあれば、第一要素にそのデータを設定してそれ以外の要素は未設定
      # * 1行目にデータがなく、2行目以降に2つ以上のデータがあれば、第一要素に末尾行に一番近いデータを設定してそれ以外の要素は未設定
      #
      # @param [Western::Calendar] date 日
      #
      # @return [Array<Gengou>] 元号情報（1行目, 2行目）
      #
      def self.lines(date:)
        lines = native_lines(date: date)
        return lines unless lines[0].invalid?

        first = Japan::Gengou.new
        lines[1..-1].each.with_index(1) do |item, index|
          next if item.invalid?

          first = item
          lines[index] = Japan::Gengou.new
        end
        lines[0] = first
        lines
      end

      #
      # 元号を引き当てる
      #
      # * LISTから単純に元号を引き当てる
      # * 1行目,2行目といった概念は無視する
      #
      # @param [Western::Calendar] date 日
      #
      # @return [Array<Gengou>] 元号情報
      #
      def self.native_lines(date:)
        result = Array.new(LIST.size)
        LIST.each_with_index do |set, index|
          result[index] = set.include_item(date: date)
        end
        result
      end

      #
      # 「日本暦日原典」1行目の元号を返す
      #
      # @param [Western::Calendar] date 日
      #
      # @return [Gengou] 元号情報（1行目）
      #
      def self.first_line(date:)
        lines = lines(date: date)
        lines[0].clone
      end

      #
      # 「日本暦日原典」2行目の元号を返す
      #
      # @param [Western::Calendar] date 日
      #
      # @return [Gengou] 元号情報（2行目）
      #
      def self.second_line(date:)
        lines = lines(date: date)
        lines[1].clone
      end
    end
  end
end

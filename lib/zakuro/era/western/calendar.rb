# frozen_string_literal: true

require 'date'

# :nodoc:
module Zakuro
  #
  # Western 西暦
  #
  module Western
    #
    # Type 日付種別
    #
    module Type
      # @return [Symbol] ユリウス暦
      JULIAN = :julian
      # @return [Symbol] グレゴリオ暦
      GREGORIAN = :gregorian
      # @return [Symbol] ユリウス暦/グレゴリオ暦
      DEFAULT = :default
    end

    # @return [Hash<Symbol, Integer>] グレゴリオ暦の開始日（ユリウス日）
    DATE_START = {
      # 通年ユリウス暦
      Type::JULIAN => Date::JULIAN,
      # 通年グレゴリオ暦
      Type::GREGORIAN => Date::GREGORIAN,
      # ユリウス暦/グレゴリオ暦
      #
      # Date::ITALY は以下引用の通りにユリウス暦/グレゴリオ暦の改暦が行われるため矛盾はない
      #
      # ユリウス暦で1582年10月4日（わが天正10年9月18日）の翌日を10月15日としてグレゴリオ暦に改暦した。
      # 9月朔まではユリウス暦日に対応させるべきであるが、計算の都合でこの頁からグレゴリオ暦に対応させてある。
      # 念のため相当するユリウス暦日を記すと、天正10年正月朔は1月24日、2月朔は2月23日、3月朔は3月24日、
      # 4月朔は4月23日、5月朔は5月22日、6月朔は6月20日、7月朔は7月20日、8月朔は8月18日、9月朔は9月17日である。
      # 以下必要ならグレゴリオ暦日の10日前を求めればよい。（暦法編第3章のix : 第30表参照）
      #  p.393
      #
      # Date::ITALY は改暦による存在しない日付（1582-10-05 ~ 1852-10-14）でエラーが発生する
      #
      # ref: https://github.com/ruby/ruby/blob/487d96c6b1cd7f5d415dba27a9684b30dfa9afed/ext/date/date_core.c#L9237-L9249
      #
      # * A Date object can be created with an optional argument,
      # * the day of calendar reform as a Julian day number, which
      # * should be 2298874 to 2426355 or negative/positive infinity.
      # * The default value is +Date::ITALY+ (2299161=1582-10-15).
      # * See also sample/cal.rb.
      # *
      # *     $ ruby sample/cal.rb -c it 10 1582
      # *         October 1582
      # *      S  M Tu  W Th  F  S
      # *         1  2  3  4 15 16
      # *     17 18 19 20 21 22 23
      # *     24 25 26 27 28 29 30
      # *     31
      #
      Type::DEFAULT => Date::ITALY
    }.freeze

    #
    # 日付種別からRuby標準のグレゴリオ暦開始日を引き当てる
    #
    # @param [Symbol] type 日付種別
    #
    # @return [Integer] Ruby標準のグレゴリオ暦開始日
    #
    def self.to_native_start(type:)
      DATE_START.fetch(type, DATE_START[Type::DEFAULT])
    end

    #
    # Ruby標準のグレゴリオ暦開始日から日付種別を引き当てる
    #
    # @param [Integer] start Ruby標準のグレゴリオ暦開始日
    #
    # @return [Symbol] 日付種別
    #
    def self.to_type(start:)
      DATE_START.invert.fetch(start, Type::DEFAULT)
    end

    #
    # Parameter 初期化引数
    #
    class Parameter
      # @return [Integer] 年
      attr_reader :year
      # @return [Integer] 月
      attr_reader :month
      # @return [Integer] 日
      attr_reader :day
      # @return [Integer] Ruby標準のグレゴリオ暦開始日
      attr_reader :start

      #
      # 初期化
      #
      # @param [Integer] year 年
      # @param [Integer] month 月
      # @param [Integer] day 日
      # @param [Integer] start Ruby標準のグレゴリオ暦開始日
      #
      def initialize(year:, month:, day:, start:)
        @year = year
        @month = month
        @day = day
        @start = start
      end
    end

    # :reek:TooManyMethods { max_methods: 18 }

    #
    # Calendar 年月日情報（西暦）
    #
    # このクラスでは以下の機能が求められる。
    # 1. グレゴリオ暦（yyyy, mm, dd） -> 日付オブジェクト
    # 2. ユリウス暦（yyyy, mm, dd） -> 日付オブジェクト
    # 3. 指定なし（yyyy, mm, dd） -> 日付オブジェクト
    # 4. 日付オブジェクト（グレゴリオ暦） -> グレゴリオ暦（yyyy, mm, dd）
    # 5. 日付オブジェクト（ユリウス暦） -> ユリウス暦（yyyy, mm, dd）
    # 6. 日付オブジェクト（指定なし） -> ユリウス暦/グレゴリオ暦（yyyy, mm, dd）
    #
    # * 3の "指定なし" とは、グレゴリオ暦開始日からを1、それ以前を2とする方式である
    # * 6もまた上記に準じて日付を求める
    # * それぞれ日付オブジェクトに変換する目的は、日付の加減算と比較のためである
    #
    # これらの機能はRubyの標準機能であり、特別な実装を要しない
    #
    # 定数 DATE_START のバリエーションで日付オブジェクトを初期化するだけで良い
    #
    class Calendar # rubocop:disable Metrics/ClassLength
      attr_reader :param, :date

      def validate
        failed = valid_type

        return failed unless failed.size.zero?

        valid_date
      end

      # :reek:TooManyStatements { max_statements: 8 }

      #
      # データ型を検証する
      #
      # @return [Array<String>] 不正メッセージ
      #
      def valid_type
        failed = []
        year = @param.year
        month = @param.month
        day = @param.day
        failed.push("wrong type. year: #{year}") unless year.is_a?(Integer)
        failed.push("wrong type. month: #{month}") unless month.is_a?(Integer)
        failed.push("wrong type. day: #{day}") unless day.is_a?(Integer)
        failed
      end

      # :reek:TooManyStatements { max_statements: 7 }

      #
      # 日付データとして検証する
      #
      # @return [Array<String>] 不正メッセージ
      #
      def valid_date
        failed = []

        year = @param.year
        month = @param.month
        day = @param.day
        start = @param.start
        unless Date.valid_date?(year, month, day, start)
          failed.push("year: #{year}, month: #{month}, " \
                      "day: #{day}, start: #{start}")
        end
        failed
      end

      #
      # 初期化
      #
      # @param [Integer] year 年
      # @param [Integer] month 月
      # @param [Integer] day 日
      # @param [Symbol] type 日付種別
      #
      # @raise [ArgumentError] 引数エラー
      #
      def initialize(year: -4712, month: 1, day: 1, type: Type::DEFAULT)
        start = Western.to_native_start(type: type)
        @param = Parameter.new(year: year, month: month, day: day, start: start)

        failed = validate
        raise ArgumentError, failed.join('\n') unless failed.size.zero?

        @date = Date.new(year, month, day, start)
      end

      #
      # 初期化時の日付とは異なる種別に切り替える
      #
      # @example Ruby標準の start_with に相当する
      #   > date = Date.new(1582, 10, 15)
      #   => #<Date: 1582-10-15 ((2299161j,0s,0n),+0s,2299161j)>
      #   > date.new_start(Date::JULIAN)
      #   => #<Date: 1582-10-05 ((2299161j,0s,0n),+0s,Infj)>
      #
      # @param [Symbol] type 日付種別
      #
      # @return [Calendar] 年月日情報（西暦）
      #
      def redate(type: Type::DEFAULT)
        start = DATE_START.fetch(type, DATE_START[Type::DEFAULT])
        @date = @date.new_start(start)
        self
      end

      #
      # 加算する
      #
      # @param [Calendar,Integer] other 年月日情報（西暦）,日数
      #
      # @return [Calendar] 年月日情報（西暦）
      #
      def +(other)
        return @date.jd + other.date.jd if other.is_a?(Western::Calendar)

        @date += other
        self
      end

      #
      # 減算する
      #
      # @param [Calendar,Integer] other 年月日情報（西暦）,日数
      #
      # @return [Calendar] 年月日情報（西暦）
      #
      def -(other)
        return @date.jd - other.date.jd if other.is_a?(Western::Calendar)

        @date -= other
        self
      end

      #
      # 大小比較する（>）
      #
      # @param [Calendar] other 年月日情報（西暦）
      #
      # @return [True] より大きい（未来日である）
      # @return [False] 以下（現在日/過去日である）
      #
      def >(other)
        @date > other.date
      end

      #
      # 大小比較する（>=）
      #
      # @param [Calendar] other 年月日情報（西暦）
      #
      # @return [True] 以上（現在日/未来日である）
      # @return [False] より小さい（過去日である）
      #
      def >=(other)
        @date >= other.date
      end

      #
      # 大小比較する（<）
      #
      # @param [Calendar] other 年月日情報（西暦）
      #
      # @return [True] より小さい（過去日である）
      # @return [False] 以上（現在日/未来日である）
      #
      def <(other)
        @date < other.date
      end

      #
      # 大小比較する（<=）
      #
      # @param [Calendar] other 年月日情報（西暦）
      #
      # @return [True] 以下（過去日/現在日である）
      # @return [False] より大きい（未来日である）
      #
      def <=(other)
        @date <= other.date
      end

      #
      # 大小比較する（==）
      #
      # @param [Calendar] other 年月日情報（西暦）
      #
      # @return [True] 等しい（現在日である）
      # @return [False] 等しくない（過去日/未来日である）
      #
      def ==(other)
        @date == other.date
      end

      #
      # 年を取得する
      #
      # @return [Integer] 年
      #
      def year
        @date.year
      end

      #
      # 月を取得する
      #
      # @return [Integer] 月
      #
      def month
        @date.month
      end

      #
      # 日を取得する
      #
      # @return [Integer] 日
      #
      def day
        @date.day
      end

      #
      # 次年にする
      #
      # @param [Integer] num 年数
      #
      # @return [Calendar] 年月日情報（西暦）
      #
      def next_year(num: 1)
        @date = @date.next_year(num)
        self
      end

      #
      # 無効値（引数なし）かどうかを検証する
      #
      # @return [True] 無効値
      # @return [False] 無効値以外
      #
      def invalid?
        (@date == Date.new)
      end

      #
      # 年月日をフォーマット化する
      #
      # @param [String] form フォーマット
      #
      # @return [String] 年月日情報
      #
      def format(form: '%Y-%m-%d')
        @date.strftime(form)
      end

      #
      # 年月日情報（西暦）を生成する
      #
      # @param [Date] date Ruby標準日付
      #
      # @return [Calendar] 年月日情報（西暦）
      #
      def self.create(date: Date.new)
        type = Western.to_type(start: date.start)
        Calendar.new(year: date.year, month: date.month,
                     day: date.day, type: type)
      end

      #
      # 年月日情報（西暦）を生成する
      #
      # @param [String] text 日付文字列
      # @param [Symbol] type 日付種別
      #
      # @return [Calendar] 年月日情報（西暦）
      #
      # @raise [ArgumentError] 引数エラー
      #
      def self.parse(text: '', type: Type::DEFAULT)
        unless Calendar.valid_date_string(text: text, type: type)
          raise ArgumentError, "invalid date string: #{text}"
        end

        start = DATE_START.fetch(type, DATE_START[Type::DEFAULT])
        date = Date.parse(text, start)

        Calendar.new(
          year: date.year, month: date.month, day: date.day, type: type
        )
      end

      #
      # 日付文字列を検証する
      #
      # @param [String] text 日付文字列
      # @param [Symbol] type 日付種別
      #
      # @return [True] 正しい
      # @return [True] 正しくない
      #
      def self.valid_date_string(text: '', type: Type::DEFAULT)
        start = DATE_START.fetch(type, DATE_START[Type::DEFAULT])
        begin
          Date.parse(text, start)
        rescue ArgumentError => _e
          return false
        end
        true
      end
    end
  end
end

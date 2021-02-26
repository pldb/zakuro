# frozen_string_literal: true

require_relative '../../../era/western'

# TODO: 用途別にリファクタリング
#  親クラスのMonth
#  計算用のMonth（未定）
#  運用情報向けのMonth（OperatedMonth）

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # Month 月情報
    #
    class Month
      # @return [True] 昨年の月
      # @return [False] 今年の月
      # @note 冬至基準で1年データを作成するため昨年の11月-12月である可能性がある
      attr_accessor :is_last_year
      # @return [True] 大の月（30日）
      # @return [False] 小の月（29日）
      attr_accessor :is_many_days
      # @return [Integer] 月（xx月のxx）
      attr_accessor :number
      # @return [True] 閏月
      # @return [False] 平月
      attr_accessor :leaped
      # @return [SolarTerm] 二十四節気（中気）
      attr_accessor :even_term
      # @return [SolarTerm] 二十四節気（節気）
      attr_accessor :odd_term
      # @return [Remainder] 月初日の大余小余
      attr_reader :remainder
      # @return [Integer] 月齢（朔月、上弦、望月、下弦）
      attr_reader :phase_index
      # @return [Western::Calendar] 月初日の西暦日
      attr_reader :western_date

      # rubocop:disable Metrics/ParameterLists
      # :reek:BooleanParameter

      #
      # 初期化
      #
      # @param [True, False] is_last_year 昨年の月/今年の月
      # @param [Integer] number 月（xx月のxx）
      # @param [True, False] is_many_days 大の月（30日）/小の月（29日）
      # @param [True, False] leaped 閏月/平月
      # @param [Remainder] remainder 月初日の大余小余
      # @param [Integer] phase_index 月齢（朔月、上弦、望月、下弦）
      # @param [SolarTerm] even_term 二十四節気（中気）
      # @param [SolarTerm] odd_term 二十四節気（節気）
      # @param [Western::Calendar] western_date 月初日の西暦日
      #
      def initialize(is_last_year: false, number: -1, is_many_days: false,
                     leaped: false, remainder: Remainder.new, phase_index: -1,
                     even_term: SolarTerm.new, odd_term: SolarTerm.new,
                     western_date: Western::Calendar.new)
        # 年
        @is_last_year = is_last_year
        # 月の大小
        @is_many_days = is_many_days
        # 月
        @number = number
        # 閏
        @leaped = leaped
        # 月初日の大余小余
        @remainder = remainder
        # 月齢（朔月、上弦、望月、下弦）
        @phase_index = phase_index
        # 中気（二十四節気）
        @even_term = even_term
        # 節気（二十四節気）
        @odd_term = odd_term
        # 月初日の西暦日
        @western_date = western_date
      end
      # rubocop:enable Metrics/ParameterLists

      #
      # 月の日数を返す
      #
      # @return [Integer] 日数
      #
      def days
        @is_many_days ? 30 : 29
      end

      #
      # 月の名前（大小）を返す
      #
      # @return [String] 月の名前（大小）
      #
      def days_name
        @is_many_days ? '大' : '小'
      end

      #
      # 同一の月情報かを検証する
      #
      # @param [Month] other 他の月情報
      #
      # @return [True] 同一の月
      # @return [False] 異なる月
      #
      def same?(other:)
        @number == other.number && @leaped == other.leaped
      end

      #
      # 二十四節気が未設定かどうかを検証する
      #
      # @return [True] 設定なし
      # @return [False] 設定あり
      #
      def empty_solar_term?
        @even_term.invalid? && @odd_term.invalid?
      end

      #
      # 文字化する
      #
      # @return [String] 文字
      #
      def to_s
        "is_last_year: #{@is_last_year}, number: #{@number}, leaped: #{@leaped}, " \
          "remainder: #{@remainder.format}, phase_index: #{@phase_index}, " \
          "even_term: #{@even_term.remainder.format}: #{@even_term.index}, " \
          "odd_term: #{@odd_term.remainder.format}: #{@odd_term.index}, " \
          "western_date: #{@western_date.format}"
      end
    end
  end
end

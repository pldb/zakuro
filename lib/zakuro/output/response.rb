# frozen_string_literal: true

require_relative '../result/result'

# :nodoc:
module Zakuro
  #
  # Response 返却値
  #
  module Response
    #
    # SingleDay 1日データ
    #
    module SingleDay
      #
      # Param 引数
      #
      class Param
        # @return [Year] 年情報（各暦のデータ型）
        attr_reader :year
        # @return [Month] 月情報（各暦のデータ型）
        attr_reader :month
        # @return [Western::Calendar] 年月日情報（西暦）
        attr_reader :date
        # @return [Integer] 日数（月初日から指定日までの日数）
        attr_reader :days

        #
        # 初期化
        #
        # @param [Year] year 年情報（各暦のデータ型）
        # @param [Month] month 月情報（各暦のデータ型）
        # @param [Western::Calendar] date 年月日情報（西暦）
        # @param [Integer] days 日数（月初日から指定日までの日数）
        #
        def initialize(year:, month:, date:, days:)
          @year = year
          @month = month
          @date = date
          @days = days
        end
      end

      #
      # 1日データを生成する
      #
      # @param [Parameter] param 引数
      #
      # @return [SingleDay] 1日データ
      #
      def self.save_single_day(param:)
        year = param.year
        month = param.month
        date = param.date
        days = param.days
        Result::Data::SingleDay.new(
          year: save_year(year: year),
          month: save_month(month: month, date: date, days: days),
          day: save_day(month: month, date: date, days: days)
        )
      end

      #
      # 年データを保存する
      #
      # @param [Year] year 年情報（各暦のデータ型）
      #
      # @return [Result::Year] 年データ
      #
      def self.save_year(year:)
        multi_gengou = year.multi_gengou
        first = multi_gengou.first_line
        second = multi_gengou.second_line
        Result::Data::Year.new(
          first_gengou:
            Result::Data::Gengou.new(name: first.name, number: first.year),
          second_gengou:
            Result::Data::Gengou.new(name: second.name, number: second.year),
          zodiac_name: year.zodiac_name, total_days: year.total_days
        )
      end
      private_class_method :save_year

      #
      # 月データを保存する
      #
      # @param [Month] month 月情報（各暦のデータ型）
      # @param [Western::Calendar] date 年月日情報（西暦）
      # @param [Integer] days 日数（月初日から指定日までの日数）
      #
      # @return [Result::Month] 月データ
      #
      def self.save_month(month:, date:, days:)
        Result::Data::Month.new(
          number: month.number, leaped: month.leaped, days_name: month.days_name,
          first_day: save_first_day(remainder: month.remainder,
                                    date: date, days: days),
          odd_solar_terms: save_solar_term(term: month.odd_term),
          even_solar_terms: save_solar_term(term: month.even_term)
        )
      end
      private_class_method :save_month

      #
      # 月初日データを保存する
      #
      # @param [Cycle::AbstractRemainder] remainder 大余小余情報
      # @param [Western::Calendar] date 年月日情報（西暦）
      # @param [Integer] days 日数（月初日から指定日までの日数）
      #
      # @return [Result::Day] 日データ
      #
      def self.save_first_day(remainder:, date:, days:)
        western_date = date.clone - days
        Result::Data::Day.new(
          number: 1,
          zodiac_name: remainder.zodiac_name,
          remainder: remainder.format,
          western_date: western_date.format
        )
      end
      private_class_method :save_first_day

      #
      # 二十四節気データを保存する
      #
      # @note 今は宣明暦に合わせている。江戸期以降の暦には対応していない（複数の中気節気を指定できない）
      #
      # @param [SolarTerm] term 二十四節気情報（各暦のデータ型）
      #
      # @return [Array<Result::SolarTerm>] 二十四節気データ
      #
      def self.save_solar_term(term:)
        return [] if term.invalid?

        [
          Result::Data::SolarTerm.new(
            index: term.index,
            remainder: term.remainder.format
          )
        ]
      end
      private_class_method :save_solar_term

      #
      # 日データを保存する
      #
      # @param [Month] month 月情報（各暦のデータ型）
      # @param [Western::Calendar] date 年月日情報（西暦）
      # @param [Integer] days 日数（月初日から指定日までの日数）
      #
      # @return [Result::Day] 日データ
      #
      def self.save_day(month:, date:, days:)
        remainder = month.remainder
        remainder = remainder.add(
          # 常に参照元のRemainderクラスで生成する
          remainder.class.new(day: days, minute: 0, second: 0)
        )
        Result::Data::Day.new(
          number: (days + 1),
          zodiac_name: remainder.zodiac_name,
          remainder: remainder.format,
          western_date: date.format
        )
      end
      private_class_method :save_day
    end
  end
end

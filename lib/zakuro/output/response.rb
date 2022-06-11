# frozen_string_literal: true

require_relative '../result/result'

# :nodoc:
module Zakuro
  # :nodoc:
  module Output
    #
    # Response 返却値
    #
    module Response
      #
      # SingleDay 1日データ
      #
      module SingleDay
        #
        # 1日データを生成する
        #
        # @param [Calculation::Base::Year] year 年情報（各暦のデータ型）
        # @param [Calculation::Monthly::Month] month 月情報（各暦のデータ型）
        # @param [Calculation::Base::Day] day 日情報
        # @param [Hash<String, Result::Data::Option::AbstractOption>] options オプション
        #
        # @return [Result::Data::SingleDay] 1日データ
        #
        def self.create(year:, month:, day:, options: {})
          Result::Data::SingleDay.new(
            year: save_year(year: year, month: month, day: day),
            month: save_month(month: month, day: day),
            day: save_day(day: day),
            options: options
          )
        end

        #
        # 年データを保存する
        #
        # @param [Calculation::Base::Year] year 年情報（各暦のデータ型）
        # @param [Calculation::Monthly::Month] month 月情報（各暦のデータ型）
        # @param [Calculation::Base::Day] day 日情報
        #
        # @return [Result::Year] 年データ
        #
        def self.save_year(year:, month:, day:)
          gengou = month.gengou
          date = day.western_date
          first = gengou.match_first_line(date: date)
          second = gengou.match_second_line(date: date)
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
        # @param [Calculation::Monthly::Month] month 月情報（各暦のデータ型）
        # @param [Calculation::Base::Day] day 日情報
        #
        # @return [Result::Month] 月データ
        #
        def self.save_month(month:, day:)
          Result::Data::Month.new(
            number: month.number, leaped: month.leaped?, days_name: month.days_name,
            first_day: save_first_day(remainder: month.remainder,
                                      date: day.western_date, days: day.number - 1),
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
            remainder: remainder,
            western_date: western_date
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
              remainder: term.remainder
            )
          ]
        end
        private_class_method :save_solar_term

        #
        # 日データを保存する
        #
        # @param [Calculation::Base::Day] day 日情報
        #
        # @return [Result::Day] 日データ
        #
        def self.save_day(day:)
          remainder = day.remainder
          Result::Data::Day.new(
            number: day.number,
            zodiac_name: remainder.zodiac_name,
            remainder: remainder,
            western_date: day.western_date
          )
        end
        private_class_method :save_day
      end
    end
  end
end

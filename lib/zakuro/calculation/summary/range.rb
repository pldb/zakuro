# frozen_string_literal: true

require_relative '../specifier/multiple_day'

require_relative '../range/operated_range'

require_relative '../range/full_range'

require_relative './internal/operation'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Summary
      #
      # Range 期間
      #
      module Range
        #
        # 生成する
        #
        # @param [Context] context 暦コンテキスト
        # @param [Western::Calendar] start_date 西暦開始日
        # @param [Western::Calendar] last_date 西暦終了日
        #
        # @return [Result::Range] 期間検索結果（和暦日）
        #
        def self.get(context:, start_date: Western::Calendar.new, last_date: Western::Calendar.new)
          # TODO: test

          years = get_full_range_years(
            context: context, start_date: start_date, last_date: last_date
          )
          operated_years = get_operated_range_years(
            context: context, years: years, start_date: start_date, last_date: last_date
          )

          dates = Specifier::MultipleDay.get(
            years: years, start_date: start_date, last_date: last_date
          )

          operated_dates = Specifier::MultipleDay.get(
            years: operated_years, start_date: start_date, last_date: last_date
          )

          list = []
          (0..(dates.size - 1)).each do |index|
            data = operated_dates[index]

            date = dates[index]
            operation = Operation.create(calc_date: date)

            list.push(
              Result::Single.new(
                data: data,
                operation: operation
              )
            )
          end

          Result::Range.new(list: list)
        end

        #
        # 完全範囲を取得する
        #
        # @param [Context] context 暦コンテキスト
        # @param [Western::Calendar] start_date 西暦開始日
        # @param [Western::Calendar] last_date 西暦終了日
        #
        # @return [Array<Base::Year>] 完全範囲
        #
        def self.get_full_range_years(context:, start_date: Western::Calendar.new,
                                      last_date: Western::Calendar.new)
          full_range = Calculation::Range::FullRange.new(
            context: context, start_date: start_date, last_date: last_date
          )
          full_range.get
        end
        private_class_method :get_full_range_years

        #
        # 運用結果範囲を取得する
        #
        # @param [Context] context 暦コンテキスト
        # @param [Western::Calendar] start_date 西暦開始日
        # @param [Western::Calendar] last_date 西暦終了日
        # @param [Western::Calendar] date 西暦日
        #
        # @return [Array<Base::OperatedYear>] 運用結果範囲
        #
        def self.get_operated_range_years(context:, years:, start_date: Western::Calendar.new,
                                          last_date: Western::Calendar.new)
          operated_range = Calculation::Range::OperatedRange.new(
            context: context, start_date: start_date, last_date: last_date, years: years
          )
          operated_range.get
        end
        private_class_method :get_operated_range_years
      end
    end
  end
end

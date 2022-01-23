# frozen_string_literal: true

require_relative '../specifier/single_day'

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
      # Single 一日
      #
      module Single
        #
        # 生成する
        #
        # @param [Context] context 暦コンテキスト
        # @param [Western::Calendar] date 西暦日
        #
        # @return [Result::Single] 一日検索結果（和暦日）
        #
        def self.get(context:, date: Western::Calendar.new)
          years = get_full_range_years(context: context, date: date)

          data = get_data(context: context, years: years, date: date)

          operation = get_operation(years: years, date: date)

          Result::Single.new(
            data: data,
            operation: operation
          )
        end

        #
        # 完全範囲を取得する
        #
        # @param [Context] context 暦コンテキスト
        # @param [Western::Calendar] date 西暦日
        #
        # @return [Array<Base::Year>] 完全範囲
        #
        def self.get_full_range_years(context:, date: Western::Calendar.new)
          full_range = Calculation::Range::FullRange.new(context: context, start_date: date)
          full_range.get
        end
        private_class_method :get_full_range_years

        #
        # 運用結果範囲を取得する
        #
        # @param [Context] context 暦コンテキスト
        # @param [Array<Base::Year>] years 完全範囲
        # @param [Western::Calendar] date 西暦日
        #
        # @return [Array<Base::OperatedYear>] 運用結果範囲
        #
        def self.get_operated_range_years(context:, years:, date: Western::Calendar.new)
          operated_range = Calculation::Range::OperatedRange.new(
            context: context, start_date: date, years: years
          )
          operated_range.get
        end
        private_class_method :get_operated_range_years

        #
        # 1日を取得する
        #
        # @param [Context] context 暦コンテキスト
        # @param [Array<Base::Year>] years 完全範囲
        # @param [Western::Calendar] date 西暦日
        #
        # @return [Data::SingleDay] 1日
        #
        def self.get_data(context:, years:, date: Western::Calendar.new)
          operated_years = get_operated_range_years(context: context, years: years, date: date)

          Calculation::Specifier::SingleDay.get(
            years: operated_years, date: date
          )
        end
        private_class_method :get_data

        #
        # 完全範囲を取得する
        #
        # @param [Context] context 暦コンテキスト
        # @param [Western::Calendar] date 西暦日
        #
        # @return [Array<Base::Year>] 完全範囲
        #
        def self.get_operation(years:, date: Western::Calendar.new)
          calc_date = Calculation::Specifier::SingleDay.get(
            years: years, date: date
          )

          Operation.create(calc_date: calc_date)
        end
        private_class_method :get_operation
      end
    end
  end
end

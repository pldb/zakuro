# frozen_string_literal: true

require_relative '../../range/dated_operation_range'

require_relative '../../range/dated_full_range'

require_relative './specifier/single_day'

require_relative '../internal/operation'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Summary
      # :nodoc:
      module Western
        #
        # Single 一日
        #
        module Single
          class << self
            #
            # 生成する
            #
            # @param [Context::Context] context 暦コンテキスト
            # @param [Western::Calendar] date 西暦日
            #
            # @return [Result::Single] 一日検索結果（和暦日）
            #
            def get(context:, date: Western::Calendar.new)
              years = get_full_range_years(context: context, date: date)

              data = get_data(context: context, years: years, date: date)

              operation = get_operation(years: years, date: date)

              Result::Single.new(
                data: data,
                operation: operation
              )
            end

            private

            #
            # 完全範囲を取得する
            #
            # @param [Context::Context] context 暦コンテキスト
            # @param [Western::Calendar] date 西暦日
            #
            # @return [Array<Calculation::Base::Year>] 完全範囲
            #
            def get_full_range_years(context:, date: Western::Calendar.new)
              full_range = Calculation::Range::DatedFullRange.new(
                context: context, start_date: date
              )
              full_range.get
            end

            #
            # 運用結果範囲を取得する
            #
            # @param [Context::Context] context 暦コンテキスト
            # @param [Array<Calculation::Base::Year>] years 完全範囲
            # @param [Western::Calendar] date 西暦日
            #
            # @return [Array<Base::OperatedYear>] 運用結果範囲
            #
            def get_operation_range_years(context:, years:, date: Western::Calendar.new)
              operation_range = Calculation::Range::DatedOperationRange.new(
                context: context, start_date: date, years: years
              )
              operation_range.get
            end

            #
            # 1日を取得する
            #
            # @param [Context::Context] context 暦コンテキスト
            # @param [Array<Calculation::Base::Year>] years 完全範囲
            # @param [Western::Calendar] date 西暦日
            #
            # @return [Data::SingleDay] 1日
            #
            def get_data(context:, years:, date: Western::Calendar.new)
              operated_years = get_operation_range_years(context: context, years: years, date: date)

              Specifier::SingleDay.get(
                years: operated_years, date: date
              )
            end

            #
            # 完全範囲を取得する
            #
            # @param [Array<Calculation::Base::Year>] years 完全範囲
            # @param [Western::Calendar] date 西暦日
            #
            # @return [Array<Calculation::Base::Year>] 完全範囲
            #
            def get_operation(years:, date: Western::Calendar.new)
              calc_date = Specifier::SingleDay.get(
                years: years, date: date
              )

              Operation.create(calc_date: calc_date)
            end
          end
        end
      end
    end
  end
end

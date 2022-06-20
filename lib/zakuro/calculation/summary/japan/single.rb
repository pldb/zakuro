# frozen_string_literal: true

require_relative '../../range/named_operation_range'

require_relative '../../range/named_full_range'

require_relative '../western/specifier/single_day'

require_relative '../internal/operation'

require_relative './specifier/single_day'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Summary
      # :nodoc:
      module Japan
        #
        # Single 一日
        #
        module Single
          class << self
            #
            # 生成する
            #
            # @param [Context::Context] context 暦コンテキスト
            # @param [Japan::Calendar] date 和暦日
            #
            # @return [Result::Single] 一日検索結果（和暦日）
            #
            def get(context:, date: Japan::Calendar.new)
              years = get_full_range_years(context: context, date: date)

              data = get_data(context: context, years: years, date: date)

              western_date = data.day.western_date
              operation = get_operation(years: years, date: western_date)

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
            # @param [Japan::Calendar] date 和暦日
            #
            # @return [Array<Base::Year>] 完全範囲
            #
            def get_full_range_years(context:, date: Japan::Calendar.new)
              full_range = Calculation::Range::NamedFullRange.new(
                context: context, start_name: date.gengou
              )
              full_range.get
            end

            #
            # 1日を取得する
            #
            # @param [Context::Context] context 暦コンテキスト
            # @param [Array<Base::Year>] years 完全範囲
            # @param [Japan::Calendar] date 和暦日
            #
            # @return [Data::SingleDay] 1日
            #
            def get_data(context:, years:, date: Japan::Calendar.new)
              operated_years = get_operation_range_years(context: context, years: years, date: date)

              Specifier::SingleDay.get(
                years: operated_years, date: date
              )
            end

            #
            # 運用結果範囲を取得する
            #
            # @param [Context::Context] context 暦コンテキスト
            # @param [Array<Calculation::Base::Year>] years 完全範囲
            # @param [Japan::Calendar] date 和暦日
            #
            # @return [Array<Base::OperatedYear>] 運用結果範囲
            #
            def get_operation_range_years(context:, years:, date: Japan::Calendar.new)
              operation_range = Calculation::Range::NamedOperationRange.new(
                context: context, start_name: date.gengou, years: years
              )
              operation_range.get
            end

            #
            # 完全範囲を取得する
            #
            # @param [Array<Calculation::Base::Year>] years 完全範囲
            # @param [Western::Calendar] date 和暦日
            #
            # @return [Array<Base::Year>] 完全範囲
            #
            def get_operation(years:, date: Western::Calendar.new)
              calc_date = Western::Specifier::SingleDay.get(
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

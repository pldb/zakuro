# frozen_string_literal: true

require_relative '../../range/dated_operation_range'

require_relative '../../range/dated_full_range'

require_relative '../internal/operation'

require_relative './specifier/single_day'

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
              # 年情報の再計算
              # * 元号開始日に計算値と運用値のズレが見られる場合、年情報の範囲が異なる場合がある
              # * 例：0781-03-01（計算値は前の元号の「宝亀」を含めるが、運用値では含まない）
              #
              # 運用値の範囲で日付検索するが、元号開始日は計算値のままで取る
              full_range = Calculation::Range::DatedFullRange.new(
                context: context, start_date: date, operated: true, restored: true
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
            # 運用情報を取得する
            #
            # @param [Array<Calculation::Base::Year>] years 完全範囲
            # @param [Western::Calendar] date 西暦日
            #
            # @return [Result::Operation] 運用情報
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

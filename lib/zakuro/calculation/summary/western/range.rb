# frozen_string_literal: true

require_relative '../../range/dated_operation_range'

require_relative '../../range/dated_full_range'

require_relative './specifier/multiple_day'

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
        # Range 期間
        #
        module Range
          class << self
            #
            # 生成する
            #
            # @param [Context::Context] context 暦コンテキスト
            # @param [Western::Calendar] start_date 西暦開始日
            # @param [Western::Calendar] last_date 西暦終了日
            #
            # @return [Result::Range] 期間検索結果（和暦日）
            #
            def get(context:, start_date: Western::Calendar.new,
                    last_date: Western::Calendar.new)
              years = get_full_range_years(
                context: context, start_date: start_date, last_date: last_date
              )
              operated_years = get_operation_range_years(
                context: context, years: years, start_date: start_date, last_date: last_date
              )

              dates = Specifier::MultipleDay.get(
                context: context, years: years, start_date: start_date, last_date: last_date
              )

              operated_dates = Specifier::MultipleDay.get(
                context: context, years: operated_years,
                start_date: start_date, last_date: last_date
              )

              list = create_result_list(dates: dates, operated_dates: operated_dates)

              Result::Range.new(list: list)
            end

            private

            #
            # 完全範囲を取得する
            #
            # @param [Context::Context] context 暦コンテキスト
            # @param [Western::Calendar] start_date 西暦開始日
            # @param [Western::Calendar] last_date 西暦終了日
            #
            # @return [Array<Base::Year>] 完全範囲
            #
            def get_full_range_years(context:, start_date: Western::Calendar.new,
                                     last_date: Western::Calendar.new)
              full_range = Calculation::Range::DatedFullRange.new(
                context: context, start_date: start_date, last_date: last_date
              )
              full_range.get
            end

            #
            # 運用結果範囲を取得する
            #
            # @param [Context::Context] context 暦コンテキスト
            # @param [Array<Base::Year>] years 完全範囲
            # @param [Western::Calendar] start_date 西暦開始日
            # @param [Western::Calendar] last_date 西暦終了日
            #
            # @return [Array<Base::OperatedYear>] 運用結果範囲
            #
            def get_operation_range_years(context:, years:, start_date: Western::Calendar.new,
                                          last_date: Western::Calendar.new)
              operation_range = Calculation::Range::DatedOperationRange.new(
                context: context, start_date: start_date, last_date: last_date, years: years
              )
              operation_range.get
            end

            #
            # 結果リストを生成する
            #
            # @param [Array<Result::Data::SingleDay>] dates 検索結果（計算値）
            # @param [Array<Result::Data::SingleDay>] operated_dates 検索結果（運用値）
            #
            # @return [Array<Result::Single>] 結果リスト
            #
            def create_result_list(dates:, operated_dates:)
              result = []

              return result if dates.size != operated_dates.size

              (0..(dates.size - 1)).each do |index|
                data = operated_dates[index]

                date = dates[index]
                operation = Operation.create(calc_date: date)

                result.push(
                  Result::Single.new(
                    data: data,
                    operation: operation
                  )
                )
              end

              result
            end
          end
        end
      end
    end
  end
end
